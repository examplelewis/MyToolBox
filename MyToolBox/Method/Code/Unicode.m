//
//  Unicode.m
//  MyToolBox
//
//  Created by 龚宇 on 16/10/20.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "Unicode.h"

@implementation Unicode

/**
 *  NSString字符串转换为Unicode格式
 */
+ (void)encodeUnicode {
    [UtilityFile resetCurrentDate];
    NSString *str = [AppDelegate defaultVC].inputTextView.string;
    
    NSData *dataenc = [str dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *encodevalue = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    if (encodevalue) {
        [AppDelegate defaultVC].outputTextView.string = encodevalue;
        [[UtilityFile sharedInstance] showLogWithTitle:@"编码完成" andFormat:@"请在输出框中复制内容"];
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:@"编码出错" andFormat:@"请检查输入框中的内容"];
    }
}
/**
 *  Unicode格式转换为NSString字符串
 */
+ (void)decodeUnicode {
    [UtilityFile resetCurrentDate];
    NSString *unicodeStr = [AppDelegate defaultVC].inputTextView.string;
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
    if (returnStr) {
        [AppDelegate defaultVC].outputTextView.string = returnStr;
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码完成" andFormat:@"请在输出框中复制内容"];
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码出错" andFormat:@"请检查输入框中的内容"];
    }
    
    return ;
}

@end
