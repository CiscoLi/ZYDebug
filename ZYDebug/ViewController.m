//
//  ViewController.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/28.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
#import "VCBackView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VCBackView *backVC = [[VCBackView alloc]init];
    backVC.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    LockView *view = [LockView lockView];
    view.frame = CGRectMake(0, 75, 375,460);
    
    [self.view addSubview:backVC];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
