//
//  Server.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "Server.h"

@implementation Server

+ (instancetype)getServer {
    static Server *sharedServer = nil;
    @synchronized(self) {
        if (sharedServer == nil){
            sharedServer = [[self alloc] init];
		}
    }
    return sharedServer;
}


- (void)insertAnimalOfSpecies:(NSString*)species race:(NSString*)race name:(NSString*)name text:(NSString*)text withStatus:(NSString*)status withImage:(UIImage*)image andLocation:(CLLocationCoordinate2D)coordinate{
	
	NSMutableDictionary *feedDict = [NSMutableDictionary dictionary];
	feedDict[@"Title"] = [NSString stringWithFormat:@"%@ %@, %@",species,race,name];
	feedDict[@"Image"] = image;
	feedDict[@"Text"] = text;
	feedDict[@"Status"] = status;
	[self.newsFeedsArray addObject:[NSDictionary dictionaryWithDictionary:feedDict]];
	
	NSMutableDictionary *annotDict = [NSMutableDictionary dictionary];
	annotDict[@"Title"] = [NSString stringWithFormat:@"%@ %@, %@",species,race,name];
	annotDict[@"Text"] = text;
	annotDict[@"Status"] = status;
	annotDict[@"Image"] = image;
	annotDict[@"Latitude"] = [NSNumber numberWithDouble:coordinate.latitude];
	annotDict[@"Longitude"] = [NSNumber numberWithDouble:coordinate.longitude];
	[self.annotationsArray addObject:[NSDictionary dictionaryWithDictionary:annotDict]];
	
}

- (NSMutableArray*)newsFeedsArray{
	if (!_newsFeedsArray) {
		NSString *newsFeedsJsonPath = [[NSBundle mainBundle] pathForResource:@"newsfeeds" ofType:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfFile:newsFeedsJsonPath];
		
		NSError *error;
		NSDictionary *newsFeedsDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
		if (error) {
			NSLog(@"%@",error);
			return nil;
		}
		else{
			_newsFeedsArray = [newsFeedsDict objectForKey:@"NewsFeeds"];
		}
	}
	return _newsFeedsArray;
}

- (NSMutableArray*)cutesArray{
	if (!_cutesArray) {
		NSString *cutesJsonPath = [[NSBundle mainBundle] pathForResource:@"cutes" ofType:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfFile:cutesJsonPath];
		
		NSError *error;
		NSDictionary *cutesDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
		if (error) {
			NSLog(@"%@",error);
			return nil;
		}
		else{
			_cutesArray = [cutesDict objectForKey:@"Cutes"];
		}
	}
	return _cutesArray;
}

- (NSMutableArray*)annotationsArray{
	if(!_annotationsArray){
		NSString *annotationsJsonPath = [[NSBundle mainBundle] pathForResource:@"annotations" ofType:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfFile:annotationsJsonPath];
		
		NSError *error;
		NSDictionary *annotationsDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
		if (error) {
			NSLog(@"%@",error);
			return nil;
		}
		else{
			_annotationsArray = [annotationsDict objectForKey:@"Annotations"];
		}
	}
	return _annotationsArray;
}

@end
