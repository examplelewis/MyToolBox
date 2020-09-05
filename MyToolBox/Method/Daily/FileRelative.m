//
//  FileRelative.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/11.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "FileRelative.h"
#import "MethodLink.h"
#import "FileManager.h"

@implementation FileRelative

#pragma mark -- 生命周期方法 --
/**
 *  单例模式方法
 */
static FileRelative *inputInstance;
+ (FileRelative *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[FileRelative alloc] init];
    });
    
    return inputInstance;
}

#pragma mark -- 逻辑方法 --
/**
 *  整理GIF文件夹
 */
- (void)arrangeGIFFile {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"整理GIF文件夹：已经准备就绪"];
    
    NSString *original = @"/Users/Mercury/CloudStation/网络图片/图库整理/GIF";
    NSString *dest = @"/Users/Mercury/Pictures/收藏图片/动图";
    
    //获取原始文件夹中的子文件夹
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *subpaths = [fm subpathsOfDirectoryAtPath:original error:nil]; //所有的文件【递归】
    NSArray *removeArray = @[@"3D", @"动漫", @"真人", @"3D/性爱", @"动漫/性爱", @"真人/性爱"];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < subpaths.count; i++) {
        NSString *name = subpaths[i];
        
        BOOL folderFlag = YES;
        [fm fileExistsAtPath:[original stringByAppendingPathComponent:name] isDirectory:&folderFlag];
        
        if (folderFlag && ![removeArray containsObject:name]) {
            [array addObject:name];
        }
    }
    
    //将子文件夹内容移动到目标文件夹中的对应文件夹；如果是因为文件已存在而导致的错误，那么删除要移动的文件
    __block NSString *message = @""; //Log语句
    NSMutableArray<NSURL *> *recycles = [NSMutableArray array]; // 要删除的内容
    for (NSString *name in array) {
        NSString *oriPath = [original stringByAppendingPathComponent:name];
        NSString *destPath = [dest stringByAppendingPathComponent:name];
        NSMutableArray *failed = [NSMutableArray array];
        
        NSArray *contents = [fm contentsOfDirectoryAtPath:oriPath error:nil];
        for (NSString *file in contents) {
            if ([file isEqualToString:@".DS_Store"]) {
                continue;
            }
            NSString *oriFile = [oriPath stringByAppendingPathComponent:file];
            NSString *destFile = [destPath stringByAppendingPathComponent:file];
            
            NSError *error;
            if (![fm moveItemAtPath:oriFile toPath:destFile error:&error]) {
                [failed addObject:[NSString stringWithFormat:@"移动文件：%@ 时发生错误：%@\n", file, [error localizedDescription]]];
                
                // 如果是因为文件已存在而导致的错误，那么删除要移动的文件
                if ([[error localizedDescription] hasSuffix:@"the same name already exists."]) {
                    [failed addObject:[NSString stringWithFormat:@"%@ 文件已经在目标文件夹中存在，所以即将移动该文件至废纸篓", file]];
                    [recycles addObject:[NSURL fileURLWithPath:oriFile]];
                }
            }
        }
        
        // 使Log语句对齐
        BOOL needTab = name.length < 8;
        if (failed.count == 0) {
            message = [message stringByAppendingFormat:@"文件夹：%@%@处理完毕，没有发生错误\n", name, needTab ? @"\t\t\t": @"\t\t"];
        } else {
            message = [message stringByAppendingFormat:@"文件夹：%@%@处理完毕，错误日志：\n%@\n", name, needTab ? @"\t\t\t": @"\t\t", [UtilityFile convertResultArray:failed]];
        }
    }
    
    // 如果是因为文件已存在而导致的错误，那么删除要移动的文件
    if (recycles.count > 0) {
        [[NSWorkspace sharedWorkspace] recycleURLs:recycles completionHandler:^(NSDictionary<NSURL *,NSURL *> * _Nonnull newURLs, NSError * _Nullable error) {
            if (error) {
                message = [message stringByAppendingFormat:@"将重复的图片文件移动至废纸篓出错：%@", error.localizedDescription];
            } else {
                message = [message stringByAppendingString:@"将重复的图片文件移动至废纸篓成功"];
            }
            
            //显示Log语句
            [[UtilityFile sharedInstance] showLogWithFormat:message];
            [[UtilityFile sharedInstance] showLogWithFormat:@"整理GIF文件夹：流程已经结束"];
        }];
    } else {
        //显示Log语句
        message = [message substringToIndex:message.length - 1];
        [[UtilityFile sharedInstance] showLogWithFormat:message];
        [[UtilityFile sharedInstance] showLogWithFormat:@"整理GIF文件夹：流程已经结束"];
    }
}
/**
 *  整理下载好的漫画文件
 */
- (void)moveMangaFileToTC {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"整理下载好的漫画文件：已经准备就绪"];
    
    NSString *origin = @"/Users/Mercury/Documents/漫画";
    NSString *dest = @"/Volumes/Data/和谐资源/漫画/同人";
    
    NSArray *subFolders = [[FileManager defaultManager] getSubFoldersPathInFolder:origin];
    for (NSString *folderPath in subFolders) {
        //如果是动漫和游戏文件夹则跳过，因为这两个文件夹不包含单个文件
        if ([folderPath hasSuffix:@"动漫"] || [folderPath hasSuffix:@"游戏"]) {
            continue;
        }
        
        NSString *destFolderPath = [folderPath stringByReplacingOccurrencesOfString:origin withString:dest];
        if (![[FileManager defaultManager] isContentExistAtPath:destFolderPath]) {
            [[UtilityFile sharedInstance] showLogWithFormat:@"文件夹：%@ 不存在，已跳过", folderPath];
            continue;
        }
        
        [[UtilityFile sharedInstance] showLogWithFormat:@"文件夹：%@，状态：开始整理", folderPath];
        NSArray *filePaths = [[FileManager defaultManager] getFilePathsInFolder:folderPath];
        for (NSString *filePath in filePaths) {
            NSString *destFilePath = [filePath stringByReplacingOccurrencesOfString:origin withString:dest];
            [[FileManager defaultManager] moveItemAtPath:filePath toDestPath:destFilePath];
        }
        [[UtilityFile sharedInstance] showLogWithFormat:@"文件夹：%@，状态：结束整理，整理了%ld个文件", folderPath, filePaths.count];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"整理下载好的漫画文件：流程已经结束"];
}

@end
