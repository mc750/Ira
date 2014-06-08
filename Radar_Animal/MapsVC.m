//
//  MapsVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "MapsVC.h"
#import <CoreLocation/CoreLocation.h>
#import "InsertionVC.h"
#import "Server.h"
#import "Annotation.h"
#import "MoreInfoVC.h"

@interface MapsVC () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D touchMapCoordinate;
@property (strong, nonatomic) Annotation *clickedAnnotation;


@end

@implementation MapsVC


- (void)viewWillAppear:(BOOL)animated{
	
	[self fetchAnnotationsFromServer];
}


- (void)fetchAnnotationsFromServer{
	NSArray *array = [[Server getServer] annotationsArray];
	for(NSDictionary *dict in array){
		Annotation *annot = [[Annotation alloc] init];
		annot.customTitle = dict[@"Title"];
		annot.status = dict[@"Status"];
		if(dict[@"Image"]){
			annot.image = dict[@"Image"];
		}
		else
			annot.imageName = dict[@"ImageName"];
		annot.coordinate = CLLocationCoordinate2DMake([dict[@"Latitude"] doubleValue], [dict[@"Longitude"] doubleValue]);
		annot.text = dict[@"Text"];
		[self.mapView addAnnotation:annot];
	}	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration =0.7;
    [self.mapView addGestureRecognizer:lpgr];
	
	
	CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(-22.818550, -47.075857);
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 2000, 2000);
	MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
	[self.mapView setRegion:adjustedRegion animated:YES];

}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
	
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    self.touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
	[self performSegueWithIdentifier:@"goToInsertionScreen" sender:nil];
	

}

#pragma mark - MapDelegate



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	
	
    static NSString *AnnotationViewID = @"annotationViewID";
	
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
	
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
	
	if(![annotation isKindOfClass:[MKUserLocation class]]){
		Annotation *annot = (Annotation*)annotation;
		
		UIImage *pinImage;
		if([annot.status isEqualToString:@"Found"])
			pinImage = [UIImage imageNamed:@"foundpin"];
		else
			pinImage = [UIImage imageNamed:@"lostpin"];
			
		UIImageView *pinImageView = [[UIImageView alloc] initWithImage:pinImage];
		pinImageView.center = annotationView.center;
		[annotationView addSubview:pinImageView];
		
		
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		annotationView.rightCalloutAccessoryView = button;
		
		annotationView.annotation = annotation;
		annotationView.canShowCallout = YES;
		annotationView.draggable = NO;
		annotationView.userInteractionEnabled = NO;
	}
	
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	
	self.clickedAnnotation = ((Annotation*)view.annotation);
	
	[self performSegueWithIdentifier:@"goToMoreInfo" sender:view.annotation];
	
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"goToInsertionScreen"]){
		InsertionVC *nextVC = (InsertionVC*)[segue destinationViewController];
		nextVC.coordinate = self.touchMapCoordinate;
		nextVC.lastVC = self;
	}
	else if([segue.identifier isEqualToString:@"goToMoreInfo"]){
		MoreInfoVC *nextVC = (MoreInfoVC*)[segue destinationViewController];
		
		nextVC.stringTitle = self.clickedAnnotation.customTitle;
		nextVC.text = self.clickedAnnotation.text;
		if(self.clickedAnnotation.image){
			nextVC.image = self.clickedAnnotation.image;
		}
		else
			nextVC.imageName = self.clickedAnnotation.imageName;

	}
}


@end
