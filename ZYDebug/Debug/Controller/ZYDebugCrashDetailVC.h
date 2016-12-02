//
//  ZYDebugCrashDetailVC.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDebugCrashDetailVC : UIViewController

@property (nonatomic, strong) NSString *crashTime;                      // Crash时间

@property (nonatomic, strong) NSDictionary *crashDetail;                 // Crash详情

@end
