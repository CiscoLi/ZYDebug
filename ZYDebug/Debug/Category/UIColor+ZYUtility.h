//
//  UIColor+ZYUtility.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/30.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZYUtility)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
