//
//  PhotoRelative.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/21.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "PhotoRelative.h"
#import "MethodLink.h"
#import "SQLiteFMDBManager.h"

@implementation PhotoRelative

#pragma mark -- 生命周期方法 --
/**
 *  单例模式方法
 */
static PhotoRelative *inputInstance;
+ (PhotoRelative *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[PhotoRelative alloc] init];
    });
    
    return inputInstance;
}



@end
