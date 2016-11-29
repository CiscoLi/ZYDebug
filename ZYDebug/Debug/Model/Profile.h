//
//  Profile.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

+ (Profile *)shared;


/**
 从start到end消耗时间
 */
@property (nonatomic, retain, readonly) NSDictionary *lastResult;

- (void)start:(NSString *)name;

- (void)end:(NSString *)name;

@end
