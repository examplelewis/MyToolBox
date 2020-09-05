//
//  SQLiteRelative.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/27.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "SQLiteRelative.h"
#import "SQLiteFMDBManager.h"

@implementation SQLiteRelative

#pragma mark -- 生命周期方法 --
/**
 *  单例模式方法
 */
static SQLiteRelative *inputInstance;
+ (SQLiteRelative *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[SQLiteRelative alloc] init];
    });
    
    return inputInstance;
}



@end
