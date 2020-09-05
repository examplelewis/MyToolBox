//
//  OrganizingDayFolder.m
//  MyToolBox
//
//  Created by 龚宇 on 16/08/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "OrganizingDayFolder.h"
#import "FileManager.h"
#import "ImageManager.h"

@interface OrganizingDayFolder () {
    NSInteger done;
}

@end

@implementation OrganizingDayFolder

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
static OrganizingDayFolder *inputInstance;
+ (OrganizingDayFolder *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[OrganizingDayFolder alloc] init];
    });
    
    return inputInstance;
}

#pragma mark -- 逻辑方法 --
- (void)start {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"整理Day文件夹：流程准备开始"];
    
    [self moveGIFFileToProperFolder];
    [self moveFilesToSpecificFolder];
    [self trashSmallSizedPhotos];
}

#pragma mark -- 辅助方法 --
- (void)moveGIFFileToProperFolder {
    [[UtilityFile sharedInstance] showLogWithFormat:@"将GIF文件移动到特定的文件夹：流程准备开始"];
    
    NSArray<NSString *> *gifFilePaths = [[FileManager defaultManager] getFilePathsInFolder:@"/Users/Mercury/Pictures/整理/Day" specificExtensions:@[@"gif"]];
    
    for (NSString *oriPath in gifFilePaths) {
        NSString *destPath = [oriPath stringByReplacingOccurrencesOfString:@"/Users/Mercury/Pictures/整理/Day" withString:@"/Users/Mercury/CloudStation/网络图片/动图"];
        
        [[FileManager defaultManager] moveItemAtPath:oriPath toDestPath:destPath];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"将GIF文件移动到特定的文件夹：流程已经结束"];
}
- (void)moveFilesToSpecificFolder {
    [[UtilityFile sharedInstance] showLogWithFormat:@"将图片文件移动到特定的文件夹：流程准备开始"];
    
    NSArray<NSString *> *imageFilePaths = [[FileManager defaultManager] getFilePathsInFolder:@"/Users/Mercury/Pictures/整理/Day" specificExtensions:@[@"jpg", @"jpeg", @"png"]];
    for (NSString *imageFilePath in imageFilePaths) {
        NSDate *creationDate = (NSDate *)[[FileManager defaultManager] getSpecificAttributeOfItemAtPath:imageFilePath attribute:NSFileCreationDate];
        NSInteger integer = [creationDate weekday];
        integer--;
        if (integer == 0) integer = 7;
        
        NSString *destFilePath = [NSString stringWithFormat:@"/Users/Mercury/Pictures/整理/Day/%ld/%@", integer, imageFilePath.lastPathComponent];
        [[FileManager defaultManager] moveItemAtPath:imageFilePath toDestPath:destFilePath];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"将图片文件移动到特定的文件夹：流程已经结束"];
}
- (void)trashSmallSizedPhotos {
    [[UtilityFile sharedInstance] showLogWithFormat:@"删除文件夹中尺寸小的图片：流程准备开始"];
    done = 0;
    
    for (NSInteger i = 1; i <= 7; i++) {
        NSString *dayFolder = [NSString stringWithFormat:@"/Users/Mercury/Pictures/整理/Day/%ld", i];
        NSArray<NSString *> *imageFilePaths = [[FileManager defaultManager] getFilePathsInFolder:dayFolder specificExtensions:@[@"jpg", @"jpeg", @"png"]];
        NSMutableArray<NSURL *> *trashes = [NSMutableArray array];
        
        for (NSString *filePath in imageFilePaths) {
            NSSize size = [[ImageManager defaultManager] getActualImageSizeWithPhotoAtPath:filePath];
            if (size.width < 801 && size.height < 801) {
                [trashes addObject:[NSURL fileURLWithPath:filePath]];
            }
        }
        
        [[NSWorkspace sharedWorkspace] recycleURLs:trashes completionHandler:^(NSDictionary<NSURL *,NSURL *> * _Nonnull newURLs, NSError * _Nullable error) {
            NSString *folderPath = [[newURLs allKeys].firstObject.path stringByDeletingLastPathComponent];
            [self didFinishTrashingFolderAtPath:folderPath fileCount:[newURLs allKeys].count error:error];
        }];
    }
}
- (void)didFinishTrashingFolderAtPath:(NSString *)path fileCount:(NSInteger)count error:(NSError *)error {
    done++;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (path) { //如果trashes数组内没有元素，那么path传回的是nil，因此需要在这里进行一次判断
            if (error) {
                [[UtilityFile sharedInstance] showLogWithFormat:@"处理 %@ 文件夹时遇到错误：\n%@", path, [error localizedDescription]];
            } else {
                [[UtilityFile sharedInstance] showLogWithFormat:@"%@ 文件夹中共删除：%ld 个文件", path, count];
            }
        }
    });
    
    if (done == 7) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UtilityFile sharedInstance] showLogWithFormat:@"删除文件夹中尺寸小的图片：流程已经结束"];
            [[UtilityFile sharedInstance] showLogWithFormat:@"整理Day文件夹：流程已经结束"];
        });
    }
}

@end
