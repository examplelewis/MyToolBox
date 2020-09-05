//
//  InternetRelative.h
//  MyToolBox
//
//  Created by 龚宇 on 16/07/11.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternetRelative : NSObject

/**
 *  单例模式方法
 *
 *  @return 返回一个初始化后的对象
 */
+ (InternetRelative *)defaultManager;

/**
 * 获取115所有标签页的地址
 */
- (void)getAllUrlsFrom115;
/**
 * 获取115所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFrom115;
/**
 * 获取Chrome所有标签页的地址
 */
- (void)getAllUrlsFromChrome;
/**
 * 获取Chrome所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFromChrome;
/**
 * 获取Safari所有标签页的地址
 */
- (void)getAllUrlsFromSafari;
/**
 * 获取Safari所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFromSafari;
/**
 *  关闭特定起始URL的Safari标签页
 */
- (void)closeTabsInSafariWithURLHeads;

@end
