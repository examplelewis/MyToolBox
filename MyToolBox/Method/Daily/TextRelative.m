//
//  TextRelative.m
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "TextRelative.h"

@implementation TextRelative

#pragma mark -- 生命周期方法 --
/**
 *  单例模式方法
 */
static TextRelative *inputInstance;
+ (TextRelative *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[TextRelative alloc] init];
    });
    
    return inputInstance;
}

#pragma mark -- 逻辑方法 --
- (void)abstractTextWithiBooks {
    [UtilityFile resetCurrentDate];
    
    NSArray *listArray = [[AppDelegate defaultVC].inputTextView.string componentsSeparatedByString:@"\n"];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSString *string in listArray) {
        if ([string hasPrefix:@"“"]) {
            NSString *aString = [string substringFromIndex:1];
            aString = [aString substringToIndex:aString.length - 1];
            [resultArray addObject:aString];
        }
    }
    
    [[UtilityFile sharedInstance] showLogWithTitle:@"提取完成" andFormat:@"一共提取到%ld条数据", resultArray.count];
    [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
}

- (void)convertScripterTextToNSString {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"转换脚本编辑器内的文字内容：流程已经开始"];
    
    NSArray *comp = [[AppDelegate defaultVC].inputTextView.string componentsSeparatedByString:@"\n"];
    NSString *result = @"";
    
    for (NSInteger i = 0; i < comp.count; i++) {
        NSString *string = comp[i];
        NSString *period = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        period = [@"@\"" stringByAppendingString:period];
        if (i != comp.count - 1) {
            period = [period stringByAppendingString:@"\\n"];
        }
        period = [period stringByAppendingString:@"\""];
        
        result = [result stringByAppendingString:period];
        if (i != comp.count - 1) {
            result = [result stringByAppendingString:@"\n"];
        }
    }
    
    [AppDelegate defaultVC].outputTextView.string = result;
    [[UtilityFile sharedInstance] showLogWithFormat:@"已完成转换，请复制输出框中的内容"];
    [[UtilityFile sharedInstance] showLogWithFormat:@"转换脚本编辑器内的文字内容：流程已经结束"];
}
- (void)cleanDuplicateText {
    [UtilityFile resetCurrentDate];
    
    NSString *content = [AppDelegate defaultVC].inputTextView.string;
    NSArray *allArray = [content componentsSeparatedByString:@"\n"];
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:allArray];
    NSArray *array = [NSArray arrayWithArray:set.array];
    NSInteger duplicateSum = allArray.count - array.count;
    
    NSString *tempString = @"";
    if (duplicateSum == 0) {
        tempString = [NSString stringWithFormat:@"没有重复的记录"];
    } else {
        tempString = [NSString stringWithFormat:@"共有重复的记录：%ld条", duplicateSum];
    }
    [[UtilityFile sharedInstance] showLogWithTitle:@"操作已经完成" andFormat:tempString];
    
    [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:array];
}

@end
