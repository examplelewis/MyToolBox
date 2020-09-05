//
//  URLCode.m
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "URLCode.h"

@implementation URLCode

+ (void)encodeURL {
    [UtilityFile resetCurrentDate];
    NSString *content = [AppDelegate defaultVC].inputTextView.string;
    
    NSString *escapedString = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    if (escapedString) {
        [AppDelegate defaultVC].outputTextView.string = escapedString;
        [[UtilityFile sharedInstance] showLogWithTitle:@"编码完成" andFormat:@"请在输出框中复制内容"];
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:@"编码出错" andFormat:@"请检查输入框中的内容"];
    }
    
}
+ (void)decodeURL {
    [UtilityFile resetCurrentDate];
    NSString *content = [AppDelegate defaultVC].inputTextView.string;
    
    NSString *decodedString = [content stringByRemovingPercentEncoding];
    
    if (decodedString) {
        [AppDelegate defaultVC].outputTextView.string = decodedString;
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码完成" andFormat:@"请在输出框中复制内容"];
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码出错" andFormat:@"请检查输入框中的内容"];
    }
}

/**
 *  GBK格式转换成NSString字符串
 */
+ (void)decodeGBK {
    [UtilityFile resetCurrentDate];
    NSString *GBKString = [AppDelegate defaultVC].inputTextView.string;
    
    NSURL *url = [NSURL URLWithString:GBKString];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:enc];
    
    if (responseString) {
        [AppDelegate defaultVC].outputTextView.string = responseString;
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码完成" andFormat:@"请在输出框中复制内容"];
    } else {
        [[UtilityFile sharedInstance] showLogWithTitle:@"解码出错" andFormat:@"请检查输入框中的内容"];
    }
}

@end
