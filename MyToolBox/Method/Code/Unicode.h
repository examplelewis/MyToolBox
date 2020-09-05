//
//  Unicode.h
//  MyToolBox
//
//  Created by 龚宇 on 16/10/20.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Unicode : NSObject

/**
 *  NSString字符串转换为Unicode格式
 */
+ (void)encodeUnicode;
/**
 *  Unicode格式转换为NSString字符串
 */
+ (void)decodeUnicode;

@end
