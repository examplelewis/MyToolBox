//
//  DistinguishBlackWhitePicture.m
//  MyToolBox
//
//  Created by 龚宇 on 16/07/25.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "DistinguishBlackWhitePicture.h"
#import "FileManager.h"

@interface DistinguishBlackWhitePicture () {
    NSMutableArray *results;
}

@end

@implementation DistinguishBlackWhitePicture

static NSString * const folderPath = @"/Users/Mercury/Documents/黑白图片";

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
static DistinguishBlackWhitePicture *inputInstance;
+ (DistinguishBlackWhitePicture *)defaultInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputInstance = [[DistinguishBlackWhitePicture alloc] init];
    });
    
    return inputInstance;
}

#pragma mark -- 逻辑方法 --
- (void)start {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"区分黑白和彩色图片：已准备就绪"];
    results = [NSMutableArray array];
    
    //显示NSOpenPanel
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setMessage:@"选择需要区分的文件夹"];
    panel.prompt = @"选择";
    panel.canChooseDirectories = YES;
    panel.canCreateDirectories = NO;
    panel.canChooseFiles = NO;
    panel.allowsMultipleSelection = NO;
    panel.directoryURL = [NSURL fileURLWithPath:@"/Users/Mercury/Downloads"];
    
    [panel beginSheetModalForWindow:[AppDelegate defaultWindow] completionHandler:^(NSInteger result) {
        if (result == 1) {
            NSURL *fileUrl = [panel URLs].firstObject;
            NSString *filePath = [fileUrl path];
            [[UtilityFile sharedInstance] showLogWithFormat:@"已选择路径：%@", filePath];
            [[UtilityFile sharedInstance] showLogWithFormat:@"开始区分已选择的图片"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self distinguishWithFolderPath:filePath];
            });
        }
    }];
}
- (void)distinguishWithFolderPath:(NSString *)folderPath {
    NSArray *contents = [[FileManager defaultManager] getFilePathsInFolder:folderPath];
    
    for (NSString *filePath in contents) {
        if ([self pictureIsBlackWhiteWithFilePath:filePath]) {
            [results addObject:filePath.lastPathComponent];
        }
    }
    
    NSString *newFolderPath = [folderPath stringByAppendingPathComponent:@"黑白图片"];
    [[FileManager defaultManager] createFolderAtPathIfNotExist:newFolderPath];
    for (NSString *path in results) {
        NSString *target = [newFolderPath stringByAppendingPathComponent:path.lastPathComponent];
        [[FileManager defaultManager] moveItemAtPath:path toDestPath:target];
    }
    
    if (!results.count) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有找到黑白图片"];
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"找到了%ld个文件，并且移动到文件夹：%@", results.count, newFolderPath];
        [[UtilityFile sharedInstance] showLogWithFormat:[UtilityFile convertResultArray:results]];
    }
    [[UtilityFile sharedInstance] showLogWithFormat:@"流程已经结束"];
}

#pragma mark -- 辅助方法 --
//使用图片每一个像素的RGB进行判断
- (BOOL)pictureIsBlackWhiteWithFilePath:(NSString *)filePath {
    float threshold = 25.0; //RGB阈值，一旦RGB之间相离的绝对值大于这个数，表明该像素不是黑白的，建议：20 ~ 30
    float ratio = 0.01;
    double over = 0.0; //记录有多少个像素超过RGB阈值
    
    NSImage *resizedImage = [self thumbnailImageFromPath:filePath];
    NSBitmapImageRep *imageRef = [NSBitmapImageRep imageRepWithData:[resizedImage TIFFRepresentation]];
    for (NSInteger x = 0; x < resizedImage.size.width; x++) {
        for (NSInteger y = 0; y < resizedImage.size.height; y++) {
            NSColor *color = [imageRef colorAtX:x y:y];
            CGFloat result = [self getRGBDiffWithNSColor:color];
            
            if (result > threshold) {
                over++;
            }
        }
    }
    
    float overRatio = over / (resizedImage.size.height * resizedImage.size.width);
    
    return overRatio < ratio;
}
- (CGFloat)getRGBDiffWithNSColor:(NSColor *)color {
    CGFloat red = color.redComponent * 256;
    CGFloat green = color.greenComponent * 256;
    CGFloat blue = color.blueComponent * 256;
    
    CGFloat rg = fabs(red - green);
    CGFloat rb = fabs(red - blue);
    CGFloat gb = fabs(green - blue);
    
    if (rg > rb) {
        if (rg > gb) {
            return rg;
        } else {
            return gb;
        }
    } else {
        if (rb > gb) {
            return rb;
        } else {
            return gb;
        }
    }
}
- (NSImage *)thumbnailImageFromPath:(NSString *)path {
    CGFloat scale = 0.05; //缩放的比例，建议：0.05 ~ 0.1
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    NSInteger maxPixel = (NSInteger)image.size.width;
    if (image.size.height > maxPixel) maxPixel = image.size.height;
    maxPixel = maxPixel * scale;
    
    CFURLRef urlRef = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    CGImageSourceRef sourceRef = CGImageSourceCreateWithURL(urlRef, nil);
    NSDictionary *options = @{(NSString *)kCGImageSourceCreateThumbnailFromImageIfAbsent:@(YES), (NSString *)kCGImageSourceThumbnailMaxPixelSize:@(maxPixel)};
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (CFDictionaryRef)options);
    
    return [[NSImage alloc] initWithCGImage:imageRef size:NSZeroSize];
}

@end
