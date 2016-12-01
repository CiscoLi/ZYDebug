//
//  PublicMethods.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicMethods : NSObject

// 计算时间差
+ (NSString *)intervalSinceNow: (NSString *) theDate;

// 消除键盘
+ (void)resignKeyboard;

+ (void)storeArray:(NSArray *)arrayElements atPathComponent:(NSString *)component forKey:(NSString *)key;

+ (NSArray *)fetchArrayAtPathComponent:(NSString *)component forKey:(NSString *)key;

+ (void)storeDictionary:(NSDictionary *)dicInfo atPathComponent:(NSString *)component forKey:(NSString *)key;

+ (NSDictionary *)fetchInfoAtPathComponent:(NSString *)component forKey:(NSString *)key;

@end
