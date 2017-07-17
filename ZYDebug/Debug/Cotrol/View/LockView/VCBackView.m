//
//  VCBackView.m
//  ZYDebug
//
//  Created by zhaoyang on 2017/7/17.
//  Copyright © 2017年 zhaoyang. All rights reserved.
//

#import "VCBackView.h"

@implementation VCBackView

- (void)drawRect:(CGRect)rect
{
    UIImage *bgImage = [UIImage imageNamed:@"Home_refresh_bg"];
    
    [bgImage drawInRect:rect];
}

@end
