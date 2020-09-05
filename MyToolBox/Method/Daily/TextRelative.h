//
//  TextRelative.h
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextRelative : NSObject

/**
 *  单例模式方法
 *
 *  @return 返回一个初始化后的对象
 */
+ (TextRelative *)defaultManager;

- (void)abstractTextWithiBooks;
- (void)convertScripterTextToNSString;
- (void)cleanDuplicateText;

@end
