//
//  AppDelegate.m
//  MyToolBox
//
//  Created by 龚宇 on 16/10/16.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "AppDelegate.h"
#import "DDFileLogger.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSMenuItem *buildTimeItem;
@property (weak) IBOutlet NSMenuItem *buildVersionItem;
@property (weak) IBOutlet NSMenuItem *operationItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setLogger];
    [self setBuildTime];
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self configureController];
    [self configureWindow];
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES; //点击窗口左上方的关闭按钮退出应用程序
}

- (void)configureController {
    if (!_currentVC) {
        _currentVC = (ViewController *)[NSApplication sharedApplication].mainWindow.contentViewController;
    }
}
- (void)configureWindow {
    if (!_currentWindow) {
        _currentWindow = [NSApplication sharedApplication].mainWindow;
    }
}

+ (AppDelegate *)defaultDelegate {
    return (AppDelegate *)[[NSApplication sharedApplication] delegate];
}
+ (ViewController *)defaultVC {
    AppDelegate *dele = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [dele configureController];
    
    if (!dele.currentVC) {
        DDLogError(@"-----没有返回正确的contentViewController!-----");
        NSAssert(dele.currentVC, @"-----没有返回正确的contentViewController!-----");
        return nil;
    }
    
    return dele.currentVC;
}
+ (NSWindow *)defaultWindow {
    AppDelegate *dele = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [dele configureWindow];
    
    if (!dele.currentWindow) {
        DDLogError(@"-----没有返回正确的window!-----");
        NSAssert(dele.currentWindow, @"-----没有返回正确的window!-----");
        return nil;
    }
    
    return dele.currentWindow;
}

#pragma mark -- action --
- (IBAction)processingCode:(NSMenuItem *)sender {
    [CodingMethods configMethod:sender.tag - 1];
}
- (IBAction)processingText:(NSMenuItem *)sender {
    [TextToolMethods configMethod:sender.tag - 1];
}
- (IBAction)processingFile:(NSMenuItem *)sender {
    [FileToolMethods configMethod:sender.tag - 1];
}
- (IBAction)processingPhoto:(NSMenuItem *)sender {
    [PhotoToolMethods configMethod:sender.tag - 1];
}
- (IBAction)processingInternet:(NSMenuItem *)sender {
    [InternetToolMethods configMethod:sender.tag - 1];
}
- (IBAction)processingSQLite:(NSMenuItem *)sender {
    [SQLiteToolMethods configMethod:sender.tag - 1];
}
- (IBAction)openLogFie:(NSMenuItem *)sender {
    NSString *logsFolder = [DeviceInfo sharedDevice].path_root_folder;
    NSDate *latestCreationDate = [NSDate dateWithYear:2000 month:1 day:1]; //新建一个NSDate对象，用于判断并查找最新创建的日志文件
    
    NSArray *logsFile = [[FileManager defaultManager] getFilePathsInFolder:logsFolder specificExtensions:@[@"log"]];
    NSString *latestFilePath = @"";
    for (NSString *filePath in logsFile) {
        NSDate *creationDate = [[FileManager defaultManager] getSpecificAttributeOfItemAtPath:filePath attribute:NSFileCreationDate];
        if ([creationDate isLaterThan:latestCreationDate]) {
            latestCreationDate = creationDate;
            latestFilePath = filePath;
        }
    }
    
    if (![[NSWorkspace sharedWorkspace] openFile:latestFilePath]) {
        MyAlert *alert = [[MyAlert alloc] initWithAlertStyle:NSAlertStyleCritical];
        [alert setMessage:@"打开日志文件时发生错误，打开失败" infomation:nil];
        [alert setButtonTitle:@"好" keyEquivalent:@"\r"];
        [alert runModel];
        
        DDLogError(@"打开日志文件时发生错误，打开失败");
    }
}
- (IBAction)openHelpingDocument:(NSMenuItem *)sender {
    if (![[NSWorkspace sharedWorkspace] openFile:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"帮助文档.txt"]]) {
        MyAlert *alert = [[MyAlert alloc] initWithAlertStyle:NSAlertStyleCritical];
        [alert setMessage:@"打开帮助文档文件时发生错误，打开失败" infomation:nil];
        [alert setButtonTitle:@"好" keyEquivalent:@"\r"];
        [alert runModel];
        
        DDLogError(@"打开帮助文档时发生错误，打开失败");
    }
}

#pragma mark -- 辅助方法 --
- (void)setLogger {
    //在系统上保持一周的日志文件
    NSString *logDirectory = [DeviceInfo sharedDevice].path_root_folder;
    DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logDirectory];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.rollingFrequency = 60 * 60 * 24 * 7; // 1 week rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    
    [DDLog addLogger:fileLogger];
}
- (void)setBuildTime {
    NSString *dateStr = [NSString stringWithUTF8String:__DATE__];
    NSString *timeStr = [NSString stringWithUTF8String:__TIME__];
    NSString *str = [NSString stringWithFormat:@"%@ %@", dateStr, timeStr];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    df.dateFormat = @"MMM dd yyyy HH:mm:ss";
    
    NSDate *date = [df dateFromString:str];
    self.buildTimeItem.title = [date formattedDateWithFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.buildVersionItem.title = [NSString stringWithFormat:@"%@ (%@)", version, build];
}

@end
