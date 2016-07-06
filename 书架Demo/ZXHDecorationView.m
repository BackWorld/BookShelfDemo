//
//  ZXHDecorationView.m
//  书架Demo
//
//  Created by 朱旭宏 on 15/9/11.
//  Copyright (c) 2015年 朱旭宏. All rights reserved.
//

#import "ZXHDecorationView.h"
@implementation ZXHDecorationView

/**
 *  创建
 */
-(instancetype)initDecorationViewForCollectionView:(UICollectionView*)collectionView
                                              cell:(UICollectionViewCell*)cell
                                         indexPath:(NSIndexPath*)indexPath
                                       rightMargin:(CGFloat)margin
                                   itemsForSection:(NSInteger)items
                                        shelfImage:(NSString*)shelfImage;
{
    if (self = [super init])
    {
        CGFloat w = collectionView.frame.size.width;
        CGFloat x = cell.frame.origin.x + cell.frame.size.width + margin;
        
        if(x >= w || (indexPath.item == items-1))
        {
            CGFloat y = cell.frame.origin.y + cell.frame.size.height;
            CGFloat off = -20;
            CGRect frame = CGRectMake(0, y+off, w, 80);
            
            for (id subView in collectionView.subviews)
            {
                if ([subView isMemberOfClass:[ZXHDecorationView class]]) {
                    ZXHDecorationView *sub = (ZXHDecorationView*)subView;
                    if ([NSStringFromCGRect(sub.frame) isEqualToString:NSStringFromCGRect(frame)]) return nil;
                }
            }
            
            // 创建
            self.frame = frame;
            self.layer.zPosition = -1;
            UIImageView *decView = [[UIImageView alloc]initWithFrame:self.bounds];
            decView.image = [UIImage imageNamed: shelfImage];
            [self addSubview:decView];
        }
    }
    
    return self;
}


-(instancetype)initDecorationViewForCollectionView:(UICollectionView*)collectionView
                                              cell:(UICollectionViewCell*)cell
                                     indexPath:(NSIndexPath*)indexPath
                                       rightMargin:(CGFloat)margin
                                   itemsForSection:(NSInteger)items
                                            height:(CGFloat)height
                                            offset:(UIEdgeInsets)offset
                                        shelfImage: (NSString*)shelfImage;
{
    if (self = [super init])
    {
        CGFloat w = collectionView.frame.size.width;
        CGFloat x = cell.frame.origin.x + cell.frame.size.width + margin;
        
        if(x >= w || (indexPath.item == items-1))
        {
            CGFloat y = cell.frame.origin.y + cell.frame.size.width - 20;
            CGRect frame = CGRectMake(offset.left, y+offset.top, w+offset.left+offset.right, height+offset.bottom);
            
            for (id subView in collectionView.subviews)
            {
                if ([subView isMemberOfClass:[ZXHDecorationView class]]) {
                    ZXHDecorationView *sub = (ZXHDecorationView*)subView;
                    if ([NSStringFromCGRect(sub.frame) isEqualToString:NSStringFromCGRect(frame)]) return nil;
                }
            }
            
            // 创建
            self.frame = frame;
            self.layer.zPosition = -1;
            UIImageView *decView = [[UIImageView alloc]initWithFrame:self.bounds];
            decView.image = [UIImage imageNamed: shelfImage];
            [self addSubview:decView];
        }
    }
    return self;
}

// 对外接口
+(void)setDecorationViewForCollectionView:(UICollectionView*)collectionView
                                     cell:(UICollectionViewCell*)cell
                                indexPath:(NSIndexPath*)indexPath
                              rightMargin:(CGFloat)margin
                          itemsForSection:(NSInteger)items
                               shelfImage:(NSString*)shelfImage{
    
    ZXHDecorationView *dec = [[ZXHDecorationView alloc]initDecorationViewForCollectionView:collectionView cell:cell indexPath:indexPath rightMargin:margin itemsForSection:items shelfImage:shelfImage];
    [collectionView addSubview:dec];
}

+(void)setDecorationViewForCollectionView:(UICollectionView *)collectionView
                                     cell:(UICollectionViewCell *)cell
                                indexPath:(NSIndexPath*)indexPath
                              rightMargin:(CGFloat)margin
                          itemsForSection:(NSInteger)items
                                   height:(CGFloat)height
                                   offset:(UIEdgeInsets)offset
                               shelfImage:(NSString *)shelfImage{
    
    ZXHDecorationView *dec = [[ZXHDecorationView alloc]initDecorationViewForCollectionView:collectionView cell:cell indexPath:indexPath rightMargin:margin itemsForSection:items height:height offset:offset shelfImage:shelfImage];
    [collectionView addSubview:dec];
}

@end
