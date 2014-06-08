//
//  HomeVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "HomeVC.h"
#import "Server.h"
#import "NewsFeedCell.h"

@interface HomeVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *newsFeeds;
@end

@implementation HomeVC


- (void)viewWillAppear:(BOOL)animated{
	[self updateScreen];
}

- (void)updateScreen{
	self.newsFeeds = [[Server getServer] newsFeedsArray];
	[self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.newsFeeds = [[Server getServer] newsFeedsArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}


- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
	
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    //return image
    return image;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [self.newsFeeds count];
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	
    UIView *view = [[UIView alloc]init];
    [view setAlpha:0.0F];
    return view;
	
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger position = self.newsFeeds.count - indexPath.section - 1;
	
	
	NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
	
	cell.titleLabel.text = self.newsFeeds[position][@"Title"];
	cell.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
	cell.textView.text = self.newsFeeds[position][@"Text"];
	cell.textView.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
	
	
	UIImage *image;
	
	if(self.newsFeeds[position][@"Image"])
		image = self.newsFeeds[position][@"Image"];
	else
		image = [UIImage imageNamed:self.newsFeeds[position][@"ImageName"]];
	
	cell.imageView.image = [self image:image scaledToSize:CGSizeMake(95, 95)];
	
	if( [self.newsFeeds[position][@"Status"] isEqualToString:@"Lost"] )
		cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.35];
	else if( [self.newsFeeds[position][@"Status"] isEqualToString:@"Found"] )
		cell.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.35];
	
	return cell;
}

@end
