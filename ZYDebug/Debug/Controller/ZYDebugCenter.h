//
//  ZYDebugCenter.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/3.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYDebugStatebar;

@interface ZYDebugCenter : UIViewController
{
    ZYDebugStatebar *stateBar;
}

+ (id)shared;

- (void)starObserveDevice;       // 在window上显示debug信息(CPU,RAM,ROM...)

@end
