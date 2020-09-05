//
//  MorseCode.m
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "MorseCode.h"

@implementation MorseCode

+ (void)decodeMorseCode {
    [UtilityFile resetCurrentDate];
    
    NSString *content = [AppDelegate defaultVC].inputTextView.string;
    NSArray *contents = [content componentsSeparatedByString:@"\n"];
    NSMutableArray *singles = [NSMutableArray array];
    
    //文字替换
    for (NSString *string in contents) {
        NSString *single = [string stringByReplacingOccurrencesOfString:@"_" withString:@"-"]; //把所有的“_”全部换成“-”
        single = [single stringByReplacingOccurrencesOfString:@"/" withString:@" "]; //把所有的“/”全部换成“ ”
        [singles addObject:single];
    }
    
    NSMutableArray *allLetters = [NSMutableArray array]; //所有行的字母集合
    for (NSString *string in singles) {
        NSString *letters = @""; //每一行的字母集合
        NSArray *comps = [string componentsSeparatedByString:@" "];
        
        for (NSString *comp in comps) {
            letters = [letters stringByAppendingString:[MorseCode convertToLetterWithMorseCode:comp]];
        }
        
        [allLetters addObject:letters];
    }
    
    [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:allLetters];
    [[UtilityFile sharedInstance] showLogWithTitle:@"解码完成" andFormat:@"请在输出框中复制内容"];
}
+ (void)encodeMorseCode {
    [UtilityFile resetCurrentDate];
    
    NSString *content = [AppDelegate defaultVC].inputTextView.string;
    NSArray *contents = [content componentsSeparatedByString:@"\n"];
    NSMutableArray *results = [NSMutableArray array];
    
    for (NSString *string in contents) {
        NSString *result = @"";
        
        for (int i = 0; i < string.length; i++) {
            NSString *chari = [string substringWithRange:NSMakeRange(i, 1)];
            
            result = [result stringByAppendingString:[MorseCode convertToMorseCodeWithLetter:chari]];
            if (i != string.length - 1) {
                result = [result stringByAppendingString:@" "];
            }
        }
        
        [results addObject:result];
    }
    
    [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:results];
    [[UtilityFile sharedInstance] showLogWithTitle:@"编码完成" andFormat:@"请在输出框中复制内容"];
}

#pragma mark -- 辅助方法 --
+ (NSDictionary *)makingUpMorseDictionary {
    NSString *dictPath = [[NSBundle mainBundle] pathForResource:@"MorseCodeInfo" ofType:@"plist"];
    
    return [NSDictionary dictionaryWithContentsOfFile:dictPath];
}
+ (NSString *)convertToLetterWithMorseCode:(NSString *)origin {
    NSDictionary *infoDict = [MorseCode makingUpMorseDictionary];
    NSArray *allKeys = [infoDict allKeysForObject:origin];
    if (allKeys.count == 0) {
        [[UtilityFile sharedInstance] showLogWithTitle:[NSString stringWithFormat:@"无法解析短语:   %@", origin] andFormat:@"已转译成 \\n[ERROR]\\n"];
        return @"\n[ERROR]\n";
    } else {
        NSString *key = (NSString *)allKeys.firstObject;
        return key;
    }
}
+ (NSString *)convertToMorseCodeWithLetter:(NSString *)origin {
    if ([origin isEqualToString:@" "]) {
        [[UtilityFile sharedInstance] showLogWithTitle:@"正在解析短语 空格" andFormat:@"已转译成 [SPACE]"];
        return @"[SPACE]";
    }
    
    NSDictionary *infoDict = [MorseCode makingUpMorseDictionary];
    NSString *value = [infoDict objectForKey:origin];
    
    if (value) {
        return value;
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:[NSString stringWithFormat:@"无法解析短语:   %@", origin] andFormat:@"已转译成 \\n[ERROR]\\n"];
        return @"\n[ERROR]\n";
    }
}

@end
