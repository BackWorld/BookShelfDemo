//
//  ZXHDecorationView.h
//  书架Demo
//
//  Created by 朱旭宏 on 15/9/11.
//  Copyright (c) 2015年 朱旭宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXHDecorationView : UIView

/**
 *  实例化
 *
 *  @param cell      cell
 *  @param indexPath indexPath
 *  @param margin    cell右边距
 *  @param items     每个section中item数
 *  @param delegate  代理
 *  @param height    高度
 *  @param offset    内边距
 */
+(void)setDecorationViewForCollectionView:(UICollectionView*)collectionView
                                     cell:(UICollectionViewCell*)cell
                                indexPath:(NSIndexPath*)indexPath
                              rightMargin:(CGFloat)margin
                          itemsForSection:(NSInteger)items
                               shelfImage:(NSString*)shelfImage;

// 默认方法
+(void)setDecorationViewForCollectionView:(UICollectionView *)collectionView
                                     cell:(UICollectionViewCell *)cell
                                indexPath:(NSIndexPath*)indexPath
                              rightMargin:(CGFloat)margin
                          itemsForSection:(NSInteger)items
                                   height:(CGFloat)height
                                   offset:(UIEdgeInsets)offset
                               shelfImage:(NSString *)shelfImage;

@end
