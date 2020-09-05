//
//  SearchForDuplicateMangaFile.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/22.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "SearchForDuplicateMangaFile.h"

@implementation SearchForDuplicateMangaFile

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
static SearchForDuplicateMangaFile *inputInstance;
+ (SearchForDuplicateMangaFile *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[SearchForDuplicateMangaFile alloc] init];
    });
    
    return inputInstance;
}

- (void)start {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"查找重复的漫画同人文件：已经准备就绪"];
    
    NSString *tempFolderPath = @"/Users/Mercury/Documents/漫画";
    NSString *doujinshiFolderPath = @"/Volumes/Data/和谐资源/漫画/同人";
    
    NSArray *resultArray = [self getAllSubFilesWithOtherInfoPath:tempFolderPath];
    NSArray *tempFilesNames = [NSArray arrayWithArray:resultArray[0]];
    NSArray *tempFilesKeys = [NSArray arrayWithArray:resultArray[1]];
    NSArray *tempFilesFails = [NSArray arrayWithArray:resultArray[2]];
    
    if (tempFilesFails.count > 0) {
        MyAlert *alert = [[MyAlert alloc] initWithAlertStyle:NSAlertStyleInformational];
        [alert setMessage:@"有如下路径的文件没有获取到可用的关键字，请检查并修改文件名" infomation:[UtilityFile convertResultArray:tempFilesFails]];
        [alert setButtonTitle:@"修改好了" keyEquivalent:MyAlertKeyEquivalentReturnKey];
        
        [alert showAlertAtMainWindowWithCompletionHandler:^(NSModalResponse returnCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self start];
            });
        }];
    } else {
        NSArray *doujinshiNames = [self getAllSubFilesPath:doujinshiFolderPath];
        NSMutableArray *founds = [NSMutableArray array];
        
        //查找是不是有重复的内容，如果有把内容数组中的索引存到indexes中
        for (NSInteger i = 0; i < tempFilesKeys.count; i++) {
            NSString *tempFilesKey = tempFilesKeys[i];
            
            for (NSInteger j = 0; j < doujinshiNames.count; j++) {
                NSString *doujinshiName = doujinshiNames[j];
                NSRange range = [doujinshiName rangeOfString:tempFilesKey];
                
                if (range.location != NSNotFound) {
                    [founds addObject:tempFilesNames[i]]; //先添加临时文件夹中的文件路径
                    [founds addObject:doujinshiNames[j]];//再添加TC文件夹中的文件路径
                    [founds addObject:@"\n"]; //最后添加一个换行符
                }
            }
        }
        
        //如果有重复的内容，把TC中的文件路径和临时文件夹中的文件路径写到TXT文件中
        if (founds.count > 0) {
            [[UtilityFile sharedInstance] showLogWithTitle:@"找到了如下重复的内容，请依次检查各文件【第一行为临时文件夹中的文件，第二行为TC中的文件】\n" andFormat:[UtilityFile convertResultArray:founds]];
        } else {
            [[UtilityFile sharedInstance] showLogWithFormat:@"没有找到重复的内容"];
        }
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"查找重复的漫画同人文件：流程已经结束"];
}

#pragma mark -- 辅助方法 --
- (NSArray *)getAllSubFilesPath:(NSString *)dirString {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *subpaths = [fm subpathsOfDirectoryAtPath:dirString error:nil]; //所有的文件【递归】
    
    NSMutableArray *mutNames = [NSMutableArray array];
    
    for (NSInteger i = 0; i < subpaths.count; i++) {
        NSString *name = subpaths[i];
        
        BOOL folderFlag = YES;
        [fm fileExistsAtPath:[dirString stringByAppendingPathComponent:name] isDirectory:&folderFlag];
        
        if (![name hasSuffix:@".DS_Store"] && !folderFlag) { //排除.DS_Store文件和文件夹
            [mutNames addObject:name];
        }
    }
    
    return [NSArray arrayWithArray:mutNames];
}
- (NSArray *)getAllSubFilesWithOtherInfoPath:(NSString *)dirString {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *subpaths = [fm subpathsOfDirectoryAtPath:dirString error:nil]; //所有的文件【递归】
    
    NSMutableArray *mutNames = [NSMutableArray array];
    NSMutableArray *mutKeys = [NSMutableArray array];
    NSMutableArray *mutFails = [NSMutableArray array];
    
    for (NSInteger i = 0; i < subpaths.count; i++) {
        NSString *name = subpaths[i];
        NSString *fileName = [name pathComponents].lastObject;
        NSString *path = [dirString stringByAppendingPathComponent:name];
        
        BOOL folderFlag = YES;
        [fm fileExistsAtPath:path isDirectory:&folderFlag];
        
        if (![name hasSuffix:@".DS_Store"] && !folderFlag) { //排除.DS_Store文件和文件夹
            [mutNames addObject:name];
            
            NSString *key = [self getStringKeyword:fileName];
            if ([self checkKeywordIsClear:key]) {
                key = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
                key = [key stringByDeletingPathExtension];
                [mutKeys addObject:key];
            } else {
                [mutFails addObject:path];
            }
        }
    }
    
    NSArray *names = [NSArray arrayWithArray:mutNames];
    NSArray *keys = [NSArray arrayWithArray:mutKeys];
    NSArray *fails = [NSArray arrayWithArray:mutFails];
    
    return @[names, keys, fails];
}
- (NSString *)getStringKeyword:(NSString *)string {
    string = [self removeAllOtherWordsInString:string left:@"[" right:@"]"];
    string = [self removeAllOtherWordsInString:string left:@"(" right:@")"];
    string = [self removeAllOtherWordsInString:string left:@"【" right:@"】"];
    string = [self removeAllOtherWordsInString:string left:@"（" right:@"）"];
    
    return string;
}
- (NSString *)removeAllOtherWordsInString:(NSString *)string left:(NSString *)left right:(NSString *)right {
    NSRange leftRange = [string rangeOfString:left];
    if (leftRange.location != NSNotFound) { //如果找到了，那么删除匹配的内容，接着递归循环
        NSRange rightRange = [string rangeOfString:right]; //既然找到左侧字符的也一定都会有右侧字符(),（）,[],【】
        
        //如果 没有配对的字符 或者 右侧字符的匹配位置小于左侧字符的匹配位置 时忽略掉
        if (rightRange.location != NSNotFound && rightRange.location > leftRange.location) {
            NSRange deleteRange = NSMakeRange(leftRange.location, rightRange.location - leftRange.location + 1);
            
            string = [string stringByReplacingCharactersInRange:deleteRange withString:@""];
            //            NSLog(@"%@", string);
            return [self removeAllOtherWordsInString:string left:left right:right];
        } else {
            return string;
        }
    } else {
        return string;
    }
}
- (BOOL)checkKeywordIsClear:(NSString *)string {
    NSRange range1 = [string rangeOfString:@"["];
    NSRange range2 = [string rangeOfString:@"]"];
    NSRange range3 = [string rangeOfString:@"("];
    NSRange range4 = [string rangeOfString:@")"];
    NSRange range5 = [string rangeOfString:@"【"];
    NSRange range6 = [string rangeOfString:@"】"];
    NSRange range7 = [string rangeOfString:@"（"];
    NSRange range8 = [string rangeOfString:@"）"];
    
    if (range1.location != NSNotFound) {
        return NO;
    }
    if (range2.location != NSNotFound) {
        return NO;
    }
    if (range3.location != NSNotFound) {
        return NO;
    }
    if (range4.location != NSNotFound) {
        return NO;
    }
    if (range5.location != NSNotFound) {
        return NO;
    }
    if (range6.location != NSNotFound) {
        return NO;
    }
    if (range7.location != NSNotFound) {
        return NO;
    }
    if (range8.location != NSNotFound) {
        return NO;
    }
    
    return YES;
}

@end
