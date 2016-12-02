//
//  UIView+Utility.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYUtility)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX;

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY;

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin;

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth;

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight;

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize;

@end
