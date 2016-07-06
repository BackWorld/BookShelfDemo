//
//  DetailViewController.m
//  书架Demo
//
//  Created by 朱旭宏 on 15/9/11.
//  Copyright (c) 2015年 朱旭宏. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookImgHeightCons;
@property (weak, nonatomic) IBOutlet UIImageView *bookImgView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleRebuildLayout) name:UIDeviceOrientationDidChangeNotification object:nil];
}

// UI布局问题在 viewDidAppear 中实现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.bookImgHeightCons.constant = self.bookImgView.frame.size.width;
}


// 重新布局
-(void)handleRebuildLayout{
    self.bookImgHeightCons.constant = self.bookImgView.frame.size.width;
}

- (IBAction)dismiss:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.view.alpha = 0;
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    
}


- (IBAction)addDownload:(id)sender {
    
}


@end
