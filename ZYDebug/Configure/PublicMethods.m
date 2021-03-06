//
//  PublicMethods.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "PublicMethods.h"

@implementation PublicMethods

// 计算时间差
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=(now-late);
    
    if (cha/60<1) {
        timeString = [NSString stringWithFormat:@"%.1f", cha];
        timeString=[NSString stringWithFormat:@"%@秒", timeString];
        
    }
    if (cha/60>1&&cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%.1f", (cha*1.0)/60];
        timeString=[NSString stringWithFormat:@"%@分钟", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%.1f", (cha*1.0)/3600];
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%.1f", (cha*1.0)/86400];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return timeString;
}

// 消除键盘
+ (void)resignKeyboard
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

#pragma mark Storage Tools

+ (void)storeArray:(NSArray *)arrayElements atPathComponent:(NSString *)component forKey:(NSString *)key {
    if (arrayElements != nil)
    {
        // 获取document文件夹位置
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *attentionPath = [documentDirectory stringByAppendingPathComponent:component];
        
        // 写入文件
        NSMutableData * data = [[NSMutableData alloc] init];
        // 这个NSKeyedArchiver是进行编码用的
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:arrayElements forKey:key];
        [archiver finishEncoding];
        // 编码完成后的NSData，使用其写文件接口写入文件存起来
        [data writeToFile:attentionPath atomically:YES];
    }
}

+ (NSArray *)fetchArrayAtPathComponent:(NSString *)component forKey:(NSString *)key
{
    NSArray *arrayList = [NSMutableArray arrayWithCapacity:0];
    
    // 获取document文件夹位置
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    // 加载attention文件
    NSString *attentionPath = [documentDirectory stringByAppendingPathComponent:component];
    
    // 文件存在
    if([[NSFileManager defaultManager] fileExistsAtPath:attentionPath] == YES)
    {
        NSData *decoderdata = [[NSData alloc] initWithContentsOfFile:attentionPath];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:decoderdata];
        
        //解档出数据模型
        NSMutableArray *attentionFromFile = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
        
        arrayList = [NSArray arrayWithArray:attentionFromFile];
        
    }
    
    return arrayList;
}

+ (void)storeDictionary:(NSDictionary *)dicInfo atPathComponent:(NSString *)component forKey:(NSString *)key {
    if (dicInfo != nil)
    {
        // 获取document文件夹位置
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *attentionPath = [documentDirectory stringByAppendingPathComponent:component];
        
        // 写入文件
        NSMutableData * data = [[NSMutableData alloc] init];
        // 这个NSKeyedArchiver是进行编码用的
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:dicInfo forKey:key];
        
        [archiver finishEncoding];
        // 编码完成后的NSData，使用其写文件接口写入文件存起来
        [data writeToFile:attentionPath atomically:YES];
    }
}

+ (NSDictionary *)fetchInfoAtPathComponent:(NSString *)component forKey:(NSString *)key {
    NSDictionary *dicInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    
    // 获取document文件夹位置
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    // 加载attention文件
    NSString *attentionPath = [documentDirectory stringByAppendingPathComponent:component];
    
    // 文件存在
    if([[NSFileManager defaultManager] fileExistsAtPath:attentionPath] == YES)
    {
        NSData *decoderdata = [[NSData alloc] initWithContentsOfFile:attentionPath];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:decoderdata];
        
        //解档出数据模型
        NSMutableDictionary *attentionFromFile = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
        
        dicInfo = [NSDictionary dictionaryWithDictionary:attentionFromFile];
    }
    
    return dicInfo;
}


@end
