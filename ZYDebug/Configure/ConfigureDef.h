//
//  ConfigureDef.h
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#ifndef ConfigureDef_h
#define ConfigureDef_h

#endif

// crash文件信息
#define kSystemLaunchTimeKey                    @"systemLaunchTime"

// 文件保存名
#define kServerListFile                         @"serverList.dat"
#define kCrashInfoFile                          @"CrashInfo.dat"

// 文件保存key
#define kServerListArchiverKey                  @"ArrayServerList"
#define kCrashInfoArchiverKey                   @"CrashInfo"

// 服务端链接Key
#define SERVERURL                               @"SERVERURL"


/*
 注意：
 上线或者不需要统计时改为NO
 */
#define DEBUGBAR_SWITCH     YES       // 上线或者不需要统计时改为NO


/*
 测试服务器
 */
#define kTestNetworkServer					 @"http://"

/*
 线上测试环境
 */
#define kFormalTestNetworkServer               @"http://"

#pragma mark - 线上正式环境地址
// =========================!!!!!!!线上正式环境地址!!!!!!================
/*
 注意：
 线上服务器地址
 */
// ==================================================================
#define kFormalNetworkServer					   @"http://"
