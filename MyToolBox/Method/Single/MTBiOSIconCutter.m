//
//  MTBiOSIconCutter.m
//  MyToolBox
//
//  Created by 龚宇 on 19/06/11.
//  Copyright © 2019 gongyuTest. All rights reserved.
//

#import "MTBiOSIconCutter.h"
#import "AppDelegate.h"

@implementation MTBiOSIconCutter

+ (void)showOpenPanel {
    NSString *inputString = [AppDelegate defaultVC].inputTextView.string;
    NSInteger size = [inputString integerValue];
    if (size == 0) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"请检查输入框输入的内容，必须为数字"];
        return;
    }
    
    
    // 显示NSOpenPanel
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setMessage:@"选择需要生成的 App Logo"];
    panel.prompt = @"确定";
    panel.canChooseDirectories = NO;
    panel.canCreateDirectories = NO;
    panel.canChooseFiles = YES;
    panel.allowsMultipleSelection = NO;
    panel.allowedFileTypes = @[@"png"];
    
    [panel beginSheetModalForWindow:[AppDelegate defaultWindow] completionHandler:^(NSInteger result) {
        if (result == 1) {
            NSURL *fileUrl = [panel URLs].firstObject;
            NSString *filePath = [fileUrl path];
            [[UtilityFile sharedInstance] showLogWithFormat:@"已选择路径：%@", filePath];
            [[UtilityFile sharedInstance] showLogWithFormat:@"开始剪切图片"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startCuttingImageAtPath:filePath WithSize:size];
            });
        }
    }];
}
+ (void)startCuttingImageAtPath:(NSString *)path WithSize:(NSInteger)size {
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    NSString *fileName = path.lastPathComponent.stringByDeletingPathExtension;
    
    NSImage *image1x = [self resizedImage:image toPixelDimensions:NSMakeSize(size, size)];
    NSImage *image2x = [self resizedImage:image toPixelDimensions:NSMakeSize(size * 2, size * 2)];
    NSImage *image3x = [self resizedImage:image toPixelDimensions:NSMakeSize(size * 3, size * 3)];
    
    NSData *imageData1x = [image1x TIFFRepresentation];
    NSData *imageData2x = [image2x TIFFRepresentation];
    NSData *imageData3x = [image3x TIFFRepresentation];
    
    NSBitmapImageRep *imageRep1x = [NSBitmapImageRep imageRepWithData:imageData1x];
    NSBitmapImageRep *imageRep2x = [NSBitmapImageRep imageRepWithData:imageData2x];
    NSBitmapImageRep *imageRep3x = [NSBitmapImageRep imageRepWithData:imageData3x];
    
    NSDictionary *imageProperty = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.0], NSImageCompressionFactor, nil];
    
    NSData *imagePngData1x = [imageRep1x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData2x = [imageRep2x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData3x = [imageRep3x representationUsingType:NSPNGFileType properties:imageProperty];
    
    NSString *imageFile1x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-%ld", fileName, size]];
    NSString *imageFile2x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-%ld@2x", fileName, size]];
    NSString *imageFile3x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-%ld@3x", fileName, size]];
    
    [imagePngData1x writeToFile:imageFile1x atomically:NO];
    [imagePngData2x writeToFile:imageFile2x atomically:NO];
    [imagePngData3x writeToFile:imageFile3x atomically:NO];
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"剪切图片结束"];
}


+ (NSImage *)resizedImage:(NSImage *)sourceImage toPixelDimensions:(NSSize)newSize {
    if (!sourceImage.isValid) {
        return nil;
    }
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes:NULL
                             pixelsWide:newSize.width
                             pixelsHigh:newSize.height
                             bitsPerSample:8
                             samplesPerPixel:4
                             hasAlpha:YES
                             isPlanar:NO
                             colorSpaceName:NSCalibratedRGBColorSpace
                             bytesPerRow:0
                             bitsPerPixel:0];
    rep.size = newSize;
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    [sourceImage drawInRect:NSMakeRect(0, 0, newSize.width, newSize.height) fromRect:NSZeroRect operation:NSCompositingOperationCopy fraction:1.0];
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage *newImage = [[NSImage alloc] initWithSize:newSize];
    [newImage addRepresentation:rep];
    
    return newImage;
}

@end
