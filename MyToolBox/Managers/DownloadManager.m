//
//  DownloadManager.m
//  MyResourceBox
//
//  Created by 龚宇 on 16/11/02.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "DownloadManager.h"

static NSInteger const maxRedownloadTimes = 3;

@interface DownloadManager () {
    AFURLSessionManager *manager;
    
    NSInteger downloaded;
    NSMutableArray *failure;
    NSInteger redownloadTimes;
}

@end

@implementation DownloadManager

- (instancetype)initWithUrls:(NSArray<NSString *> *)urls {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.operationQueue.maxConcurrentOperationCount = 10;
        
        downloaded = 0;
        redownloadTimes = 0;
        _downloadPath = @"/Users/Mercury/Downloads";
        _urls = [NSArray arrayWithArray:urls];
        failure = [NSMutableArray array];
    }
    
    return self;
}

- (void)queueDownload {
    [UtilityFile resetCurrentDate];
    
    [self startDownload];
}
- (void)startDownload {
    downloaded = 0;
    [failure removeAllObjects];
    [[UtilityFile sharedInstance] showLogWithFormat:@"下载开始，共%ld个文件", self.urls.count];
    
    for (NSInteger i = 0; i < self.urls.count; i++) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urls[i]]];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSString *filePath = [self.downloadPath stringByAppendingPathComponent:[response suggestedFilename]];
            return [NSURL fileURLWithPath:filePath];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (error) {
                NSString *url = error.userInfo[NSURLErrorFailingURLStringErrorKey];
                if (!url) {
                    url = error.userInfo[@"NSErrorFailingURLKey"];
                    if (!url) {
                        url = error.userInfo[@"NSErrorFailingURLStringKey"];
                        if (!url) {
                            url = @"";
                        }
                    }
                }
                
                [[UtilityFile sharedInstance] showLogWithFormat:@"【%@】下载内容失败，原因：%@", url, [error localizedDescription]];
                
                [failure addObject:url];
            }
            
            [self didFinishDownloadingSingleURL];
        }];
        [downloadTask resume];
    }
}

- (void)didFinishDownloadingSingleURL {
    downloaded++;
    [[UtilityFile sharedInstance] showNotAppendLogWithFormat:@"已下载了第%lu张图片 | 共%lu张图片", downloaded, self.urls.count];
    
    if (downloaded != self.urls.count) {
        return;
    }
    
    if (failure.count > 0 && redownloadTimes < maxRedownloadTimes) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"3秒后重新下载失败的图片"];
        [self performSelector:@selector(redownloadFailure) withObject:nil afterDelay:3.0];
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"下载完成"];
        if (failure.count > 0) {
            [UtilityFile exportArray:failure atPath:@"/Users/Mercury/Downloads/failure.txt"];
            [[UtilityFile sharedInstance] showLogWithFormat:@"有%ld个文件仍然无法下载，已导出到下载文件夹的failure.txt文件中", failure.count];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishDownloading)]) {
                [self.delegate didFinishDownloading];
            }
        });
    }
}

- (void)redownloadFailure {
    redownloadTimes++;
    _urls = [NSArray arrayWithArray:failure];
    [UtilityFile exportArray:failure atPath:@"/Users/Mercury/Downloads/failure.txt"];
    [[UtilityFile sharedInstance] showLogWithFormat:@"第%ld次重新下载失败的图片，共%ld个文件", redownloadTimes, self.urls.count];
    
    [self startDownload];
}

- (void)setDownloadPath:(NSString *)downloadPath {
    _downloadPath = downloadPath;
    
    // 如果目标文件夹不存在，那么创建该文件夹
    FileManager *fm = [FileManager defaultManager];
    if (![fm isContentExistAtPath:downloadPath]) {
        [fm createFolderAtPathIfNotExist:downloadPath];
    }
}

@end
