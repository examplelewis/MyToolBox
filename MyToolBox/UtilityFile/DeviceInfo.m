//
//  DeviceInfo.m
//  MyToolBox
//
//  Created by 龚宇 on 16/11/01.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "DeviceInfo.h"
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceInfo

/**
 *  单例方法
 *
 *  @return 返回的单例
 */
+ (DeviceInfo *)sharedDevice {
    static DeviceInfo *sharedDevice = nil;
    if (!sharedDevice) {
        sharedDevice = [[DeviceInfo alloc] init];
        [sharedDevice getInfo];
    }
    
    return sharedDevice;
}

- (void)getInfo {
    // 获取设备的Model
    size_t len = 0;
    sysctlbyname("hw.model", NULL, &len, NULL, 0);
    if (len) {
        char *model = malloc(len * sizeof(char));
        sysctlbyname("hw.model", model, &len, NULL, 0);
        _model = [NSString stringWithUTF8String:model];
        [self convertMacModel];
        free(model);
    } else {
        _model = @"Undefined";
        _modelType = MacModelTypeUndefined;
    }
}

- (void)convertMacModel {
    if ([_model isEqualToString:@"Macmini7,1"]) {
        _modelType = MacModelTypeMacMini2014;
    } else if ([_model isEqualToString:@"MacBookAir5,2"]) {
        _modelType = MacModelTypeMacBookAir2012;
    } else if ([_model isEqualToString:@"MacBookPro11,3"]) {
        _modelType = MacModelTypeMacBookPro2014;
    } else {
        _modelType = MacModelTypeUndefined;
    }
}

- (NSString *)path_root_folder {
    if (!_path_root_folder) {
        if ([DeviceInfo sharedDevice].modelType == MacModelTypeMacMini2014) {
            _path_root_folder = @"/Users/Mercury/SynologyDrive/~同步文件夹/同步文档/MyToolBox";
        } else {
            _path_root_folder = @"/Users/Mercury/SynologyDrive/~同步文件夹/同步文档/MyToolBox";
        }
    }
    
    return _path_root_folder;
}

@end
