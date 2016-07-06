//
//  ZXHCollectionView.m
//  书架Demo
//
//  Created by zhuxuhong on 16/7/6.
//  Copyright © 2016年 朱旭宏. All rights reserved.
//

#import "ZXHCollectionView.h"
#import "ZXHDecorationView.h"

@implementation ZXHCollectionView 
{
    NSMutableArray *_showedIndexPaths;
}
// 代码初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _showedIndexPaths = [NSMutableArray new];
        // 转屏通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleRebuildDecorationViewLayout:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

// xib初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _showedIndexPaths = [NSMutableArray new];
        // 转屏通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleRebuildDecorationViewLayout) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}



// cell load 动画
-(void)animationForWillDisplayCell: (UICollectionViewCell*)cell
                       atIndexPath: (NSIndexPath*)indexPath{
    //indexpath第一次加载的有动画  否则没有
    if ([_showedIndexPaths containsObject:indexPath]) {
        return;
    }
    else
    {
        [_showedIndexPaths addObject:indexPath];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        CGFloat y = indexPath.item * 100;

        cell.frame = CGRectMake(self.bounds.size.width, y, cell.bounds.size.width, cell.bounds.size.height);
        
        [UIView animateWithDuration:(indexPath.item)*0.01 animations:^{
            cell.frame = CGRectMake(0, y, cell.bounds.size.width, cell.bounds.size.height);
        }];
    }
}


/**
 *  重新布局
 */
-(void)handleRebuildDecorationViewLayout{
    [_showedIndexPaths removeAllObjects];
    // 移除
    for (id subView in self.subviews) {
        if ([subView isMemberOfClass:[ZXHDecorationView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    // 刷新创建
    [self reloadData];
}

-(void)dealloc{
    // 转屏通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
