//
//  ZYDebugCenter.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/3.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ZYDebugCenter.h"
#import "ZYDebugStatebar.h"

static ZYDebugCenter *debugCenter = nil;

@interface ZYDebugCenter ()

@end

@implementation ZYDebugCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (id)shared {
    if (!debugCenter) {
        @synchronized (self) {
            debugCenter = [[ZYDebugCenter alloc] init];
        }
    }
    
    return debugCenter;
}

- (void)starObserveDevice {
    if (!stateBar) {
        stateBar = [[ZYDebugStatebar alloc] init];
        [stateBar starScan];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
