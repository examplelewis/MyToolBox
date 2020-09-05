//
//  URLCode.h
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLCode : NSObject

+ (void)encodeURL;
+ (void)decodeURL;
/**
 *  GBK格式转换成NSString字符串
 */
+ (void)decodeGBK;

@end
