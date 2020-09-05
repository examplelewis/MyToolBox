//
//  AppDelegate.h
//  MyToolBox
//
//  Created by 龚宇 on 16/10/16.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) ViewController *currentVC;
@property (strong) NSWindow *currentWindow;

+ (AppDelegate *)defaultDelegate;
+ (ViewController *)defaultVC;
+ (NSWindow *)defaultWindow;

@end
