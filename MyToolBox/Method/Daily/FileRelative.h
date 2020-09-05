//
//  FileRelative.h
//  MyToolBox
//
//  Created by 龚宇 on 16/07/11.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileRelative : NSObject

/**
 *  单例模式方法
 *
 *  @return 返回一个初始化后的对象
 */
+ (FileRelative *)defaultManager;
/**
 *  整理GIF文件夹
 */
- (void)arrangeGIFFile;
/**
 *  整理下载好的漫画文件
 */
- (void)moveMangaFileToTC;

@end
