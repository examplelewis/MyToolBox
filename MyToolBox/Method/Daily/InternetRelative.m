//
//  InternetRelative.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/11.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "InternetRelative.h"

@implementation InternetRelative

#pragma mark -- 生命周期方法 --
/**
 *  单例模式方法
 */
static InternetRelative *inputInstance;
+ (InternetRelative *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[InternetRelative alloc] init];
    });
    
    return inputInstance;
}

#pragma mark -- 逻辑方法 --
/**
 * 获取115所有标签页的地址
 */
- (void)getAllUrlsFrom115 {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取115上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取115所有标签页.scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个115窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能115没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取115上所有Tabs的地址：流程已经结束"];
}
/**
 * 获取115所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFrom115 {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取115上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取115所有标签页(带标题).scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个115窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能115没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取115上所有Tabs的地址：流程已经结束"];
}
/**
 * 获取Chrome所有标签页的地址
 */
- (void)getAllUrlsFromChrome {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Chrome上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取Chrome所有标签页.scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个Chrome窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能Chrome没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Chrome上所有Tabs的地址：流程已经结束"];
}
/**
 * 获取Chrome所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFromChrome {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Chrome上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取Chrome所有标签页(带标题).scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个Chrome窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能Chrome没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Chrome上所有Tabs的地址：流程已经结束"];
}
/**
 * 获取Safari所有标签页的地址
 */
- (void)getAllUrlsFromSafari {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Safari上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取Safari所有标签页.scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个Safari窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能Safari没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Safari上所有Tabs的地址：流程已经结束"];
}
/**
 * 获取Safari所有标签页的地址和标题
 */
- (void)getAllUrlsAndTitlesFromSafari {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Safari上所有Tabs的地址：流程准备就绪"];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/获取Safari所有标签页(带标题).scpt"]] error:nil];
    NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
    NSString *result = @"";
    for (int i = 1; i <= descriptor.numberOfItems; i++) {
        NSMutableArray *mArray = [NSMutableArray array];
        NSAppleEventDescriptor *des = [descriptor descriptorAtIndex:i];
        for (int j = 1; j <= des.numberOfItems; j++) {
            NSAppleEventDescriptor *d = [des descriptorAtIndex:j];
            [mArray addObject:d.stringValue];
        }
        
        if (mArray.count > 0) {
            result = [result stringByAppendingFormat:@"第%d个Safari窗口已获取完成：\n%@\n", i, [UtilityFile convertResultArray:mArray]];
        }
    }
    
    if (result.length > 0) {
        [AppDelegate defaultVC].outputTextView.string = result;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有获取到网页地址，可能Safari没有打开"];
    }
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"获取Safari上所有Tabs的地址：流程已经结束"];
}
/**
 *  关闭特定起始URL的Safari标签页
 */
- (void)closeTabsInSafariWithURLHeads {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"关闭特定起始URL的Safari标签页：流程已经开始"];
    
    NSString *urlHead = [AppDelegate defaultVC].inputTextView.string;
    if ([urlHead isEqualToString:@""]) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"本流程需要在输入框内输入URL的规则，例如：http://www.wnacg.org/photos"];
        [[UtilityFile sharedInstance] showLogWithFormat:@"关闭特定起始URL的Safari标签栏：流程已经结束"];
        return;
    }
    
    NSString *scriptString = [NSString stringWithFormat:
                              @"set message to \"\"\n"
                              @"tell application \"Safari\"\n"
                              @"	set windowsCount to count every window\n"
                              @"	repeat with windowsIndex from windowsCount to 1 by -1\n"
                              @"		try\n"
                              @"			set currentWindow to item windowsIndex of every window\n"
                              @"			set tabsCount to count every tab of currentWindow\n"
                              @"			if tabsCount is greater than 0 then\n"
                              @"				repeat with tabIndex from tabsCount to 1 by -1\n"
                              @"					set currentTab to item tabIndex of every tab of currentWindow\n"
                              @"					tell currentTab\n"
                              @"						if (URL as text) starts with \"%@\" then close\n"
                              @"					end tell\n"
                              @"				end repeat\n"
                              @"			end if\n"
                              @"		on error errText number errNum\n"
                              @"			set message to (message & errText)\n"
                              @"		end try\n"
                              @"	end repeat\n"
                              @"end tell", urlHead];
    
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptString];
    [script executeAndReturnError:nil];
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"所有指定URL的标签页已经关闭"];
    [[UtilityFile sharedInstance] showLogWithFormat:@"关闭特定起始URL的Safari标签页：流程已经结束"];
}

@end
