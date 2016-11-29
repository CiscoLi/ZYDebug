//
//  CommonDef.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#ifndef CommonDef_h
#define CommonDef_h

// 判断字符串是否有值
#define STRINGHASVALUE(str)		(str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)

// 判断字典是否有值
#define DICTIONARYHASVALUE(dic)    (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)

// 判断数组是否有值
#define ARRAYHASVALUE(array)    (array && [array isKindOfClass:[NSArray class]] && [array count] > 0)

// 判断NSNumber是否有值
#define NUMBERHASVALUE(number)    (number && [number isKindOfClass:[NSNumber class]])

// 获取合法字符串
#define GETVALIDSTRING(str) (STRINGHASVALUE(str) ? str : @"")

// 获取合法字典
#define GETVALIDDICTIONARY(dic) (DICTIONARYHASVALUE(dic) ? dic : @{})

// 获取合法数组
#define GETVALIDARRAY(array) (ARRAYHASVALUE(array) ? array : @[])

// 获取合法Number
#define GETVALIDNUMBER(number) (NUMBERHASVALUE(number) ? number : @"")


// 字符串本地化
#define _string(x)  NSLocalizedString(x, nil)

#endif /* CommonDef_h */
