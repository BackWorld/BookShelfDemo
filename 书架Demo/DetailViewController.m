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
    if (_closeBlock) {
        _closeBlock();
    }
}


- (IBAction)addDownload:(id)sender {
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


@end
