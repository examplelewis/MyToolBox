//
//  PhotoRelative.h
//  MyToolBox
//
//  Created by 龚宇 on 16/07/21.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoRelative : NSObject

/**
 *  单例模式方法
 *
 *  @return 返回一个初始化后的对象
 */
+ (PhotoRelative *)defaultManager;

@end