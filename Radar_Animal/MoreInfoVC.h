//
//  MoreInfoVC.h
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreInfoVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *stringTitle;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *text;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
