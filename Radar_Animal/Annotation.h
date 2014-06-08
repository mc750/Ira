//
//  Annotation.h
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *customTitle;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *text;

@end
