//
//  ImportFilesIntoPhotos.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/21.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "ImportFilesIntoPhotos.h"

@interface ImportFilesIntoPhotos () {
    FileManager *fm;
    NSArray *albumScripts;
    NSArray *folders;
    NSArray *importScripts;
    
    NSMutableArray *beforeCounts;
    NSMutableArray *folderCounts;
    NSMutableArray *estimatedCounts;
    NSMutableArray *afterCounts;
}

@end

@implementation ImportFilesIntoPhotos

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
static ImportFilesIntoPhotos *inputInstance;
+ (ImportFilesIntoPhotos *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[ImportFilesIntoPhotos alloc] init];
    });
    
    return inputInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        fm = [FileManager defaultManager];
        [self setupData];
    }
    
    return self;
}
- (void)setupData {
    albumScripts = @[[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/3D-和谐.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/3D-色情.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/3D-性爱.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/3D-诱惑.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/3D-Futa.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-和谐.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-色情.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-私房.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-性爱.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-运动.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-制服.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/真人-足袜.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-动漫.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-腐向.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-和谐.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-角色.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-色情.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-私人.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-武装.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-性爱.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-游戏.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-制服.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/ACG-Futa.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/Cosplay-动漫.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/Cosplay-和谐.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/Cosplay-其他.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/Cosplay-游戏.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/MISC-抱枕.scpt"],
                     [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/获取相册数量/MISC-手办.scpt"]];
    importScripts = @[[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/3D-和谐.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/3D-色情.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/3D-性爱.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/3D-诱惑.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/3D-Futa.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-和谐.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-色情.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-私房.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-性爱.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-运动.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-制服.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/真人-足袜.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-动漫.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-腐向.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-和谐.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-角色.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-色情.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-私人.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-武装.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-性爱.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-游戏.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-制服.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/ACG-Futa.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/Cosplay-动漫.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/Cosplay-和谐.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/Cosplay-其他.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/Cosplay-游戏.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/MISC-抱枕.scpt"],
                      [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/导入图片/MISC-手办.scpt"]];
    folders = @[@"/Users/Mercury/Pictures/网络图片/图库整理/3D/和谐",
                @"/Users/Mercury/Pictures/网络图片/图库整理/3D/色情",
                @"/Users/Mercury/Pictures/网络图片/图库整理/3D/性爱",
                @"/Users/Mercury/Pictures/网络图片/图库整理/3D/诱惑",
                @"/Users/Mercury/Pictures/网络图片/图库整理/3D/Futa",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/和谐",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/色情",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/私房",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/性爱",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/运动",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/制服",
                @"/Users/Mercury/Pictures/网络图片/图库整理/真人/足袜",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/动漫",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/腐向",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/和谐",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/角色",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/色情",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/私人",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/武装",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/性爱",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/游戏",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/制服",
                @"/Users/Mercury/Pictures/网络图片/图库整理/ACG/Futa",
                @"/Users/Mercury/Pictures/网络图片/图库整理/Cosplay/动漫",
                @"/Users/Mercury/Pictures/网络图片/图库整理/Cosplay/和谐",
                @"/Users/Mercury/Pictures/网络图片/图库整理/Cosplay/其他",
                @"/Users/Mercury/Pictures/网络图片/图库整理/Cosplay/游戏",
                @"/Users/Mercury/Pictures/网络图片/图库整理/MISC/抱枕",
                @"/Users/Mercury/Pictures/网络图片/图库整理/MISC/手办"];
}

#pragma mark -- 逻辑方法 --
// -------------------------------------------------------------------------------
// 显示一个警告，提示必须打开Photos图库文件
// -------------------------------------------------------------------------------
- (void)start {
    [UtilityFile resetCurrentDate];
    [UtilityFile showLogWithFormat:@"将整理好的图片导入到图库：已准备就绪"];
    
    MyAlert *alert = [[MyAlert alloc] initWithAlertStyle:NSAlertStyleInformational];
    [alert setMessage:@"是否已打开美图图库文件？" infomation:@"整个流程需要图库文件处于打开状态，否则会崩溃"];
    [alert setButtonTitle:@"已打开，继续" keyEquivalent:MyAlertKeyEquivalentReturnKey];
    
    [alert showAlertAtMainWindowWithCompletionHandler:^(NSModalResponse returnCode) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getAllAlbumContentsCountBefore];
        });
    }];
}
// -------------------------------------------------------------------------------
// 第一步：先获取所有相册内的照片数量
// -------------------------------------------------------------------------------
- (void)getAllAlbumContentsCountBefore {
    beforeCounts = [NSMutableArray array];
    
    for (NSString *scriptPath in albumScripts) {
        NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:scriptPath] error:nil];
        NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
        
        [beforeCounts addObject:descriptor.stringValue];
    }
    
    NSString *result = @"导入之前\n";
    result = [result stringByAppendingString:[self exportArray:beforeCounts]];
    [UtilityFile exportString:result atPath:@"/Users/Mercury/Downloads/ImportPhotos.txt"];
    
    [UtilityFile showLogWithFormat:@"第一次获取相册内的照片数量 成功"];
    [self getAllFoldersCount];
}
// -------------------------------------------------------------------------------
// 第二步：获取所有文件夹中的图片数量
// -------------------------------------------------------------------------------
- (void)getAllFoldersCount {
    folderCounts = [NSMutableArray array];
    estimatedCounts = [NSMutableArray array];
    
    for (NSInteger i = 0; i < folders.count; i++) {
        NSInteger fCounts = [fm getFilePathsInFolder:folders[i]].count;
        NSInteger bCounts = [beforeCounts[i] integerValue];
        NSInteger eCounts = fCounts + bCounts;
        
        [folderCounts addObject:[NSString stringWithFormat:@"%ld", fCounts]];
        [estimatedCounts addObject:[NSString stringWithFormat:@"%ld", eCounts]];
    }
    
    NSString *result = [UtilityFile readFileAtPath:@"/Users/Mercury/Downloads/ImportPhotos.txt"];
    result = [result stringByAppendingString:@"\n\n文件夹内\n"];
    result = [result stringByAppendingString:[self exportArray:folderCounts]];
    result = [result stringByAppendingString:@"\n\n预计结果\n"];
    result = [result stringByAppendingString:[self exportArray:estimatedCounts]];
    [UtilityFile exportString:result atPath:@"/Users/Mercury/Downloads/ImportPhotos.txt"];
    
    [self importFilesIntoLibrary];
}
// -------------------------------------------------------------------------------
// 第三步：将所有图片导入到图库中
// -------------------------------------------------------------------------------
- (void)importFilesIntoLibrary {
    for (NSInteger i = 0; i < importScripts.count; i++) {
        if ([folderCounts[i] integerValue] == 0) { // 对应文件夹内没有文件就忽略
            return;
        }
        
        NSString *string = importScripts[i];
        NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:string] error:nil];
        NSDictionary *errorInfo;
        [script executeAndReturnError:&errorInfo];
        if (errorInfo) { //有错误的话
            [UtilityFile showLogWithFormat:@"导入 %@ 内的图片时, AppleScript 执行错误：%@", string.lastPathComponent.stringByDeletingPathExtension, [UtilityFile convertResultDict:errorInfo]];
        }
    }
    
    [UtilityFile showLogWithFormat:@"导入结束"];
    [self getAllAlbumContentsCountAfter];
}
// -------------------------------------------------------------------------------
// 第四步：再获取所有相册内的照片数量
// -------------------------------------------------------------------------------
- (void)getAllAlbumContentsCountAfter {
    afterCounts = [NSMutableArray array];
    
    for (NSString *scriptPath in albumScripts) {
        NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:scriptPath] error:nil];
        NSAppleEventDescriptor *descriptor = [script executeAndReturnError:nil];
        
        [afterCounts addObject:descriptor.stringValue];
    }
    
    NSString *result = [UtilityFile readFileAtPath:@"/Users/Mercury/Downloads/ImportPhotos.txt"];
    result = [result stringByAppendingString:@"\n\n导入之后\n"];
    result = [result stringByAppendingString:[self exportArray:afterCounts]];
    [UtilityFile exportString:result atPath:@"/Users/Mercury/Downloads/ImportPhotos.txt"];
    
    [UtilityFile showLogWithFormat:@"第二次获取相册内的照片数量 成功"];
    [self done];
}
// -------------------------------------------------------------------------------
// 第五步：给出提示
// -------------------------------------------------------------------------------
- (void)done {
    NSString *message = @"";
    for (NSInteger i = 0; i < albumScripts.count; i++) {
        NSInteger fCount = [folderCounts[i] integerValue];
        NSInteger eCount = [estimatedCounts[i] integerValue];
        NSInteger aCount = [afterCounts[i] integerValue];
        NSString *key = albumScripts[i];
        key = key.lastPathComponent.stringByDeletingPathExtension;
        
        if (fCount == 0) { //文件夹内本身就没有图片文件，跳过
            message = [message stringByAppendingFormat:@"%@ 文件夹内没有图片文件，已跳过\n", key];
        } else if (eCount != aCount) {
            message = [message stringByAppendingFormat:@"%@ 文件夹内有部分图片没有导入，查看上面的错误提示\n", key];
        } else {
            message = [message stringByAppendingFormat:@"%@ 文件夹内所有图片文件已导入成功\n", key];
        }
    }
    message = [message substringToIndex:message.length - 1];
    
    [UtilityFile showLogWithFormat:message];
    [UtilityFile showLogWithFormat:@"将整理好的图片导入到图库：流程结束"];
}
// -------------------------------------------------------------------------------
// 第六步：清理文件夹
// -------------------------------------------------------------------------------
- (void)cleanPhoto {
    [UtilityFile resetCurrentDate];
    [UtilityFile showLogWithFormat:@"清理已导入的图片：已准备就绪"];
    
    NSString *cleanScript = [[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"脚本文件/图片导入到 Photos/Cleanup.scpt"];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath:cleanScript] error:nil];
    NSDictionary *errorInfo;
    [script executeAndReturnError:&errorInfo];
    if (errorInfo) { //有错误的话
        [UtilityFile showLogWithFormat:@"清理文件夹图片时, AppleScript 执行错误：%@", [UtilityFile convertResultDict:errorInfo]];
    }
    
    [UtilityFile showLogWithFormat:@"清理已导入的图片：流程结束"];
}

// -------------------------------------------------------------------------------
// 辅助：数组转换成字符串
// -------------------------------------------------------------------------------
- (NSString *)exportArray:(NSArray *)array {
    NSMutableString *export = [NSMutableString string];
    for (NSInteger i = 0; i < array.count; i++) {
        if (i == 4 || i == 11 || i == 22 || i == 26) {
            [export appendFormat:@"%@\n", array[i]];
        } else if (i == 28) {
            [export appendString:array[i]];
        } else {
            [export appendFormat:@"%@\t", array[i]];
        }
    }
    
    return [export copy];
}

@end
