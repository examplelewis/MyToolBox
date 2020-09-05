//
//  MTBAppLogoCutter.m
//  MyToolBox
//
//  Created by 龚宇 on 19/06/11.
//  Copyright © 2019 gongyuTest. All rights reserved.
//

#import "MTBAppLogoCutter.h"

@implementation MTBAppLogoCutter

+ (void)showOpenPanel {
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
                [self startCuttingImageAtPath:filePath];
            });
        }
    }];
}
+ (void)startCuttingImageAtPath:(NSString *)path {
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    NSString *fileName = path.lastPathComponent.stringByDeletingPathExtension;
    
    NSImage *image202x = [self resizedImage:image toPixelDimensions:NSMakeSize(40, 40)];
    NSImage *image203x = [self resizedImage:image toPixelDimensions:NSMakeSize(60, 60)];
    NSImage *image292x = [self resizedImage:image toPixelDimensions:NSMakeSize(58, 58)];
    NSImage *image293x = [self resizedImage:image toPixelDimensions:NSMakeSize(87, 87)];
    NSImage *image402x = [self resizedImage:image toPixelDimensions:NSMakeSize(80, 80)];
    NSImage *image403x = [self resizedImage:image toPixelDimensions:NSMakeSize(120, 120)];
    NSImage *image602x = [self resizedImage:image toPixelDimensions:NSMakeSize(120, 120)];
    NSImage *image603x = [self resizedImage:image toPixelDimensions:NSMakeSize(180, 180)];
    
    NSData *imageData202x = [image202x TIFFRepresentation];
    NSData *imageData203x = [image203x TIFFRepresentation];
    NSData *imageData292x = [image292x TIFFRepresentation];
    NSData *imageData293x = [image293x TIFFRepresentation];
    NSData *imageData402x = [image402x TIFFRepresentation];
    NSData *imageData403x = [image403x TIFFRepresentation];
    NSData *imageData602x = [image602x TIFFRepresentation];
    NSData *imageData603x = [image603x TIFFRepresentation];
    
    NSBitmapImageRep *imageRep202x = [NSBitmapImageRep imageRepWithData:imageData202x];
    NSBitmapImageRep *imageRep203x = [NSBitmapImageRep imageRepWithData:imageData203x];
    NSBitmapImageRep *imageRep292x = [NSBitmapImageRep imageRepWithData:imageData292x];
    NSBitmapImageRep *imageRep293x = [NSBitmapImageRep imageRepWithData:imageData293x];
    NSBitmapImageRep *imageRep402x = [NSBitmapImageRep imageRepWithData:imageData402x];
    NSBitmapImageRep *imageRep403x = [NSBitmapImageRep imageRepWithData:imageData403x];
    NSBitmapImageRep *imageRep602x = [NSBitmapImageRep imageRepWithData:imageData602x];
    NSBitmapImageRep *imageRep603x = [NSBitmapImageRep imageRepWithData:imageData603x];
    
    NSDictionary *imageProperty = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.0], NSImageCompressionFactor, nil];
    
    NSData *imagePngData202x = [imageRep202x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData203x = [imageRep203x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData292x = [imageRep292x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData293x = [imageRep293x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData402x = [imageRep402x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData403x = [imageRep403x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData602x = [imageRep602x representationUsingType:NSPNGFileType properties:imageProperty];
    NSData *imagePngData603x = [imageRep603x representationUsingType:NSPNGFileType properties:imageProperty];
    
    NSString *imageFile202x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-20@2x", fileName]];
    NSString *imageFile203x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-20@3x", fileName]];
    NSString *imageFile292x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-29@2x", fileName]];
    NSString *imageFile293x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-29@3x", fileName]];
    NSString *imageFile402x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-40@2x", fileName]];
    NSString *imageFile403x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-40@3x", fileName]];
    NSString *imageFile602x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-60@2x", fileName]];
    NSString *imageFile603x = [path stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-Small-60@3x", fileName]];
    
    [imagePngData202x writeToFile:imageFile202x atomically:NO];
    [imagePngData203x writeToFile:imageFile203x atomically:NO];
    [imagePngData292x writeToFile:imageFile292x atomically:NO];
    [imagePngData293x writeToFile:imageFile293x atomically:NO];
    [imagePngData402x writeToFile:imageFile402x atomically:NO];
    [imagePngData403x writeToFile:imageFile403x atomically:NO];
    [imagePngData602x writeToFile:imageFile602x atomically:NO];
    [imagePngData603x writeToFile:imageFile603x atomically:NO];
    
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
