//
//  InsertionVC.h
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapsVC.h"

@interface InsertionVC : UIViewController

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) MapsVC *lastVC;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
