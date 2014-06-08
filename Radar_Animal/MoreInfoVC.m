//
//  MoreInfoVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "MoreInfoVC.h"

@interface MoreInfoVC ()

@end

@implementation MoreInfoVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.stringTitle;
	self.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
	self.textView.text = self.text;
	self.textView.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
	
	if(self.image){
		self.imageView.image = self.image;
	}
	else
		self.imageView.image = [UIImage imageNamed:self.imageName];
}



- (IBAction)backToMap:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end
