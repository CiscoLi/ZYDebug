//
//  Profile.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "Profile.h"

static Profile *instance = nil;

@interface Profile()

@property (nonatomic ,strong, readonly) NSMutableArray *segmentStack;

@end

@implementation Profile


/**
 单例

 @return 本身
 */
+ (Profile *)shared
{
    if (instance == nil) {
        instance = [[Profile alloc]init];
    }
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _segmentStack = [NSMutableArray array];
    }
    return  self;
}

- (void)start:(NSString *)name
{
    NSDictionary *begin = [NSDictionary dictionaryWithObject:[NSDate date] forKey:name];
    [_segmentStack addObject:begin];
}

- (void)end:(NSString *)name
{
    NSDate *date = [NSDate date];
    NSDictionary *begin = [_segmentStack lastObject];
    NSDate *beginDate = [begin objectForKey:name];
    if (beginDate) {
        NSTimeInterval timeElased = [date timeIntervalSince1970] - [beginDate timeIntervalSince1970];
        _lastResult = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:timeElased],@"Time",name,@"Name", nil];
    }
}
@end
