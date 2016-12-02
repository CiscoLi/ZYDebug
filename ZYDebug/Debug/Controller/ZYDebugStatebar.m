//
//  ZYDebugStatebar.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ZYDebugStatebar.h"
#import "UIDevice+ZYHardware.h"
#import "ZYDebugServerListVC.h"
#import "ZYDebugCrashListVC.h"

#define kDebugStatBarBgColor   RGBACOLOR(212, 209, 207, 1)

@interface ZYDebugStatebar ()
{
    UILabel *cpuLabel;
    UILabel *ramLabel;
    UILabel *profileLabel;
    
    NSTimer *timer;
    BOOL displaySelf;
    UITabBarController *tabBarController;
}

@end

@implementation ZYDebugStatebar

- (id)init
{
    if (self = [super initWithFrame:CGRectMake((SCREEN_WIDTH - 216) * 0.5, 0, 216, 20)]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.rootViewController = appDelegate.window.rootViewController;
        
        //注册内容警告通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarningTip:) name:@"UIApplicationDidReceiveMemoryWarningNotification" object:nil];
        
        self.backgroundColor = kDebugStatBarBgColor;
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        displaySelf = YES;
        
        UILabel *label = nil;
        UIDevice *device = [UIDevice currentDevice];
        
        // 添加cpu显示
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 73, 19)];
        NSArray *usage = [device cpuUsage];
        NSMutableString *usageStr = [NSMutableString stringWithFormat:@""];
        for (NSNumber *u in usage) {
            [usageStr appendString:[NSString stringWithFormat:@"%.1f%% ", [u floatValue]]];
        }
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.font = kCurNormalFontOfSize(10);
        label.textAlignment = NSTextAlignmentRight;
        label.text = usageStr;
        [self addSubview:label];
        cpuLabel = label;
        
        // 添加ram显示
        label = [[UILabel alloc] initWithFrame:CGRectMake(73, 0, 73, 19)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.font = kCurNormalFontOfSize(10);
        label.textAlignment = NSTextAlignmentRight;
        label.text = [NSString stringWithFormat:@"%.1f / %luM", [device freeMemoryBytes] / 1024.0 / 1024.0, [device totalMemoryBytes] / 1024 / 1024];
        [self addSubview:label];
        ramLabel = label;
        
        // 添加性能分析显示
        label = [[UILabel alloc] initWithFrame:CGRectMake(142, 0, 73, 19)];
        label.text = @"秒";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.font = kCurNormalFontOfSize(10);
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        profileLabel = label;
        
        // 添加长按手势出配置界面
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(popConfigView)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

// 推出配置页面
- (void)popConfigView
{
    // 服务器列表
    ZYDebugServerListVC *serverListVC = [[ZYDebugServerListVC alloc] init];
    UINavigationController *serverNav = [[UINavigationController alloc] initWithRootViewController:serverListVC];
    
    
    // crash列表
    ZYDebugCrashListVC *crashListVC = [[ZYDebugCrashListVC alloc] init];
    
    NSArray *arrayCrashInfo = [PublicMethods fetchArrayAtPathComponent:kCrashInfoFile forKey:kCrashInfoArchiverKey];
    if (ARRAYHASVALUE(arrayCrashInfo))
    {
        [crashListVC setArrayCrashInfo:arrayCrashInfo];
    }
    UINavigationController *crashListNav = [[UINavigationController alloc] initWithRootViewController:crashListVC];

    
    
    serverListVC.title = @"服务指向";
    serverListVC.tabBarItem.image = [UIImage imageNamed:@"debug_item_0_ico.png"];
    crashListVC.title = @"Crash日志";
    crashListVC.tabBarItem.image = [UIImage imageNamed:@"debug_item_3_ico.png"];
    
    
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:serverNav,crashListNav,nil];
    
}


- (void)memoryWarningTip:(NSNotification *)noti {
    NSLog(@"noti:%@", [noti object]);
    NSLog(@"noti:%@", [noti userInfo]);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAutoreverse animations:^{
                            self.backgroundColor = [UIColor yellowColor];
                        }
                     completion:^(BOOL finished){
                         if (finished) {
                             self.backgroundColor = kDebugStatBarBgColor;
                         }
                     }];
}


- (void)starScan {
    self.hidden = NO;
    
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshInfo) userInfo:nil repeats:YES];
    }
}


- (void)refreshInfo {
    // 实时更新资源使用情况
    UIDevice *device = [UIDevice currentDevice];
    NSArray *usage = [device cpuUsage];
    
    NSMutableString *usageStr = [NSMutableString stringWithFormat:@""];
    for (NSNumber *u in usage) {
        [usageStr appendString:[NSString stringWithFormat:@"%.1f%% ", [u floatValue]]];
    }
    cpuLabel.text = usageStr;
    
    ramLabel.text = [NSString stringWithFormat:@"%.1f / %luM", [device freeMemoryBytes] / 1024.0 / 1024.0, [device totalMemoryBytes] / 1024 / 1024];
    
    profileLabel.text = [NSString stringWithFormat:@"%.3f秒", [[[Profile shared].lastResult objectForKey:@"Time"] doubleValue]];
}


@end
