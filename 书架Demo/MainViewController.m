//
//  MainViewController.m
//  书架Demo
//
//  Created by 朱旭宏 on 15/9/11.
//  Copyright (c) 2015年 朱旭宏. All rights reserved.
//

#import "DetailViewController.h"
#import "ZXHDecorationView.h"
#import "MainViewController.h"
#import "ZXHCollectionView.h"

@interface MainViewController ()

@end

static NSString * const reuseIdentifier = @"Cell";
#define topMargin 50
#define sectionCount 5
@implementation MainViewController
{
    NSInteger itemsSection;
    DetailViewController *detailVC;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    itemsSection = 6;
}


#pragma mark <UICollectionViewDataSource>
// 边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(topMargin, topMargin, topMargin, topMargin);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sectionCount;
}

// 加载动画，对tableview 好些
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    [(ZXHCollectionView*)self.collectionView animationForWillDisplayCell:cell atIndexPath:indexPath];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemsSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 依附每个cell 和indexPath 计算而实现的 decoration view
    // 没有用到复用，效率不高，但还行
    [ZXHDecorationView setDecorationViewForCollectionView:collectionView cell:cell indexPath:indexPath rightMargin:topMargin itemsForSection:itemsSection shelfImage:@"bookshelf"];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.navigationController.navigationBar.hidden = YES;
    detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.view.frame = self.view.frame;
    detailVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    detailVC.view.alpha = 0;
    [self addChildViewController:detailVC];
    [self.view addSubview:detailVC.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        detailVC.view.transform = CGAffineTransformMakeScale(1, 1);
        detailVC.view.alpha = 1;
    }];
}


@end
