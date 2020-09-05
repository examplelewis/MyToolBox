//
//  ImportFilesIntoPhotos.h
//  MyToolBox
//
//  Created by 龚宇 on 16/07/21.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImportFilesIntoPhotos : NSObject

+ (ImportFilesIntoPhotos *)defaultInstance;
- (void)start;

// -------------------------------------------------------------------------------
// 第六步：清理文件夹
// -------------------------------------------------------------------------------
- (void)cleanPhoto;

@end
