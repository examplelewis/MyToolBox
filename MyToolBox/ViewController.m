//
//  ViewController.m
//  MyToolBox
//
//  Created by 龚宇 on 16/10/16.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -- 控件方法 --
- (IBAction)processingExport:(NSButton *)sender {
    NSString *output = self.outputTextView.string;
    if (output.length > 0) {
        [UtilityFile exportString:output atPath:@"/Users/Mercury/Downloads/Result.txt"];
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有可导出的结果"];
    }
}
- (IBAction)processingExportInput:(NSButton *)sender {
    NSString *input = self.inputTextView.string;
    if (input.length > 0) {
        [UtilityFile exportString:input atPath:@"/Users/Mercury/Downloads/Input.txt"];
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"没有可导出的输入"];
    }
}

- (IBAction)processingTemp:(NSButton *)sender {
    [[UtilityFile sharedInstance] showLogWithTitle:@"临时方法执行失败" andFormat:@"该方法没有实现"];
    
//    NSString *content = self.inputTextView.string;
//    NSArray *components = [content componentsSeparatedByString:@"\n"];
//    NSMutableArray *result = [NSMutableArray array];
//    for (NSString *string in components) {
//
//    }
//    self.outputTextView.string = [UtilityFile convertResultArray:result];
}

@end
