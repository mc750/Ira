//
//  CuteWallVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "CuteWallVC.h"
#import "CuteCell.h"
#import "Server.h"

@interface CuteWallVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray* cutesItens;

@end

@implementation CuteWallVC



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.cutesItens = [[Server getServer] cutesArray];
}

- (void)viewWillAppear:(BOOL)animated{
	[self updateScreen];
}

- (void)updateScreen{
	self.cutesItens = [[Server getServer] cutesArray];
	[self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return [self.cutesItens count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CuteCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cuteCell" forIndexPath:indexPath];
	cell.imageView.image = [UIImage imageNamed:self.cutesItens[indexPath.row][@"ImageName"]];
	cell.textLabel.text = self.cutesItens[indexPath.row][@"Title"];
	
	cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
	cell.textLabel.numberOfLines = 0;
    return cell;
}


@end
