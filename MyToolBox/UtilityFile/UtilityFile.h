//
//  UtilityFile.h
//  iOSToolBox
//
//  Created by 龚宇 on 15/1/5.
//  Copyright (c) 2015年 Mercury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "AppDelegate.h"

@interface UtilityFile : NSObject

// 单例模式
+ (UtilityFile *)sharedInstance;

+ (void)resetCurrentDate;

// -------------------------------------------------------------------------------
//	在界面控制台上显示/清除信息
// -------------------------------------------------------------------------------
- (void)showLogWithFormat:(NSString *)alertFormat, ...;
- (void)showLogWithTitle:(NSString *)alertTitle andFormat:(NSString *)alertFormat, ...;
- (void)showNotAppendLogWithFormat:(NSString *)alertFormat, ...;
- (void)cleanLog;

// -------------------------------------------------------------------------------
//	写入读取文本文件
// -------------------------------------------------------------------------------
+ (void)exportString:(NSString *)string atPath:(NSString *)path;
+ (void)exportArray:(NSArray *)array atPath:(NSString *)path;
+ (void)exportDictionary:(NSDictionary *)dictionary atPath:(NSString *)path;
+ (NSString *)readFileAtPath:(NSString *)path;

// -------------------------------------------------------------------------------
//
// -------------------------------------------------------------------------------
+ (NSColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSString *)convertTimeDifferenceToString:(NSTimeInterval)timeDiff;
+ (NSString *)convertResultArray:(NSArray *)contentArray;
+ (NSString *)convertResultDict:(NSDictionary *)contentDict;

@end
