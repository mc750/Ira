//
//  Server.h
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Server : NSObject

@property (strong, nonatomic) NSMutableArray *newsFeedsArray;
@property (strong, nonatomic) NSMutableArray *cutesArray;
@property (strong, nonatomic) NSMutableArray *annotationsArray;

+ (instancetype)getServer;
- (void)insertAnimalOfSpecies:(NSString*)species race:(NSString*)race name:(NSString*)name text:(NSString*)text withStatus:(NSString*)status withImage:(UIImage*)image andLocation:(CLLocationCoordinate2D)coordinate;

@end
