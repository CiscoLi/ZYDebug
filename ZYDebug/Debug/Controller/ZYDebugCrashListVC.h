//
//  ZYDebugCrashListVC.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDebugCrashListVC : UIViewController

@property (nonatomic, strong) UITableView *tableViewList;              // CrashInfo列表
@property (nonatomic, strong) NSArray *arrayCrashInfo;                 // CrashInfo数组

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end
