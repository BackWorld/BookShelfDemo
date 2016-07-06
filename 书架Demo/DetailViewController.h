//
//  DetailViewController.h
//  书架Demo
//
//  Created by 朱旭宏 on 15/9/11.
//  Copyright (c) 2015年 朱旭宏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CloseCallBackBlock)(void);

@interface DetailViewController : UIViewController

@property(nonatomic, copy) CloseCallBackBlock closeBlock;

@end
