//
//  DownloadManager.h
//  MyResourceBox
//
//  Created by 龚宇 on 16/11/02.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadManagerDelegate <NSObject>

@required
- (void)didFinishDownloading;

@optional
- (void)didFinishDownloadOneFile:(NSString *)urlString error:(NSError *)error;

@end

@interface DownloadManager : NSObject

@property (weak) id <DownloadManagerDelegate> delegate;
@property (nonatomic, copy) NSString *downloadPath;
@property (copy, readonly) NSArray<NSString *> *urls;

- (instancetype)initWithUrls:(NSArray<NSString *> *)urls;
- (void)startDownload;
- (void)queueDownload;

@end
