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
    detailVC = nil;
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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.view.frame = window.bounds;
    [self.view addSubview:detailVC.view];
    
    __weak typeof(self) weakSelf = self;
    __block typeof(DetailViewController) *vc = detailVC;
    detailVC.closeBlock = ^(void){
        [weakSelf pagePositionZoomCloseAnimationWithCell:cell view:vc.view];
    };

    [self pagePositionZoomOpenAnimationWithCell:cell view:detailVC.view];
}

#pragma mark 动画
// point缩放动画
// open
-(void)pagePositionZoomOpenAnimationWithCell:(UICollectionViewCell*)cell view:(UIView*)view{
    view.transform = CGAffineTransformMakeScale(cell.frame.size.width/view.frame.size.width, cell.frame.size.height/view.frame.size.height);
    
    CGFloat x = cell.center.x;
    CGFloat y = cell.frame.origin.y - self.collectionView.contentOffset.y + cell.frame.size.height/2;
    view.center = CGPointMake(x, y);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1, 1);
        view.center = window.center;
    } completion:^(BOOL finished) {
        [self addChildViewController:detailVC];
    }];
}

// close
-(void)pagePositionZoomCloseAnimationWithCell:(UICollectionViewCell*)cell view:(UIView*)view{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    view.transform = CGAffineTransformMakeScale(1, 1);
    view.center = window.center;
    
    CGFloat x = cell.center.x;
    CGFloat y = cell.frame.origin.y - self.collectionView.contentOffset.y + cell.frame.size.height/2;
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(cell.frame.size.width/view.frame.size.width, cell.frame.size.height/view.frame.size.height);
        view.center = CGPointMake(x, y);
    } completion:^(BOOL finished) {
        [detailVC.view removeFromSuperview];
        [detailVC removeFromParentViewController];
    }];
}

// 水波动画
-(void)pageRippleAnimation:(UIView*)view{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.8;
    transition.type = @"rippleEffect";
    // rippleEffect | cube | pageCurl | pageUnCurl | suckEffect | oglFlip | moveIn | fade | reveal
    [view.layer addAnimation:transition forKey:nil];
}

// center缩放动画
-(void)pageCenterScaleAnimation:(UIView*)view{
    view.frame = self.view.frame;
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    view.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(1, 1);
        view.alpha = 1;
    }];
}

@end
