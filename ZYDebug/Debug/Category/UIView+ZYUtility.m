//
//  UIView+Utility.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "UIView+ZYUtility.h"

@implementation UIView (ZYUtility)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX
{
    CGRect viewFrame = [self frame];
    viewFrame.origin.x = newX;
    [self setFrame:viewFrame];
}

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY
{
    CGRect viewFrame = [self frame];
    viewFrame.origin.y = newY;
    [self setFrame:viewFrame];
}

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin
{
    CGRect viewFrame = [self frame];
    viewFrame.origin = newOrigin;
    [self setFrame:viewFrame];
}

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth
{
    CGRect viewFrame = [self frame];
    viewFrame.size.width = newWidth;
    [self setFrame:viewFrame];
}

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight
{
    CGRect viewFrame = [self frame];
    viewFrame.size.height = newHeight;
    [self setFrame:viewFrame];
}

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize
{
    CGRect viewFrame = [self frame];
    viewFrame.size = newSize;
    [self setFrame:viewFrame];
}
@end
