//
//  OldUselessCode.m
//  MyToolBox
//
//  Created by 龚宇 on 15/12/08.
//  Copyright © 2015年 gongyuTest. All rights reserved.
//

#import "OldUselessCode.h"

#import "ViewController.h"
#import "SQLiteFMDBManager.h"

@implementation OldUselessCode

+ (void)configMethod:(NSInteger)cellRow {
//    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"currentDate"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    switch (cellRow) {
//        case 0:
//            [OldUselessCode processWorldCosplayDiv];
//            break;
//        case 1:
//            [OldUselessCode deleteWorldCosplay100Suffix];
//            break;
//        case 2:
//            [OldUselessCode processCureCOSDiv];
//            break;
//        case 3:
//            [OldUselessCode getLinkFromEHentai];
//            break;
//        case 4:
//            [OldUselessCode getLinkFromUmei];
//            break;
//        case 5:
//            [OldUselessCode getLinkFromBCY];
//            break;
//        case 6:
//            [OldUselessCode getLinkFromBCYLink];
//            break;
//        case 7:
//            [OldUselessCode getLinkFromLofter];
//            break;
//        case 1001:
//            [OldUselessCode saveLinkIntoDatabase];
//            break;
//        default:
//            break;
//    }
}

//#pragma mark -- 和网络解析无关的操作方法 --
////从WorldCosplay网页中获取Div片段，处理成 http://worldcosplay.net/photo/xxxxxx 的数据类型
//+ (void)processWorldCosplayDiv {
//    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
//    
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSArray *componentArray = [content componentsSeparatedByString:@"\n"];
//    for (NSString *string in componentArray) {
//        NSRange range = [string rangeOfString:@"<a href="]; //判断字符串是否包含
//        if (range.length > 0) {
//            NSArray *tempArray = [string componentsSeparatedByString:@"\""];
//            NSString *tempString = [NSString stringWithFormat:@"http://worldcosplay.net%@", [tempArray objectAtIndex:1]];
//            [stringArray addObject:tempString];
//        }
//        //        if (range.location == NSNotFound) //不包含
//    }
//    
//    if (stringArray.count > 0) {
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:stringArray];
//        NSString *tempString = [NSString stringWithFormat:@"以获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", (unsigned long)stringArray.count];
//        [UtilityFile showLogWithTitle:@"成功获取到Div数据" andContent:tempString clean:111];
//    } else {
//        [UtilityFile showLogWithTitle:@"没有获得任何数据" andFormat:@"请查看tempTest.txt文件" clean:111];
//    }
//}
////处理从WorldCosplay解析来的图片地址，去掉以xxxx100.jpg结尾的类型
//+ (void)deleteWorldCosplay100Suffix {
//    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
//    
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSArray *componentArray = [content componentsSeparatedByString:@"\n"];
//    for (NSString *string in componentArray) {
//        if (![string hasSuffix:@"-100.jpg"]) {
//            [stringArray addObject:string];
//        }
//    }
//    
//    if (stringArray.count > 0) {
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:stringArray];
//        NSString *tempString = [NSString stringWithFormat:@"剩余%lu个地址\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", (unsigned long)stringArray.count];
//        [UtilityFile showLogWithTitle:@"成功去除以-100.jpg结尾的地址" andContent:tempString clean:111];
//    } else {
//        [UtilityFile showLogWithTitle:@"没有获得任何数据" andFormat:@"请查看tempTest.txt文件" clean:111];
//    }
//}
////从CureCOS网页中获取Div片段，处理成 http://en.curecos.com/picture/detail?id=xxxxxx 的数据类型
//+ (void)processCureCOSDiv {
//    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
//    
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSArray *componentArray = [content componentsSeparatedByString:@"\n"];
//    for (NSString *string in componentArray) {
//        NSRange range = [string rangeOfString:@"<a class="]; //判断字符串是否包含
//        if (range.length > 0) {
//            NSArray *tempArray = [string componentsSeparatedByString:@"\""];
//            NSString *tempString = [NSString stringWithFormat:@"http://en.curecos.com/picture/%@", [tempArray objectAtIndex:3]];
//            [stringArray addObject:tempString];
//        }
//        //        if (range.location == NSNotFound) //不包含
//    }
//    
//    if (stringArray.count > 0) {
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:stringArray];
//        NSString *tempString = [NSString stringWithFormat:@"以获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", (unsigned long)stringArray.count];
//        [UtilityFile showLogWithTitle:@"成功获取到Div数据" andContent:tempString clean:111];
//    } else {
//        [UtilityFile showLogWithTitle:@"没有获得任何数据" andFormat:@"请查看tempTest.txt文件" clean:111];
//    }
//}
//+ (void)getLinkFromLofter {
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSArray *componentArray = [content componentsSeparatedByString:@"						"];
//    NSMutableArray *finalArray = [NSMutableArray array];
//    
//    for (NSString *string in componentArray) {
//        NSRange range = [string rangeOfString:@"src=\"http://"];
//        if (range.location != NSNotFound) {
//            NSArray *array = [string componentsSeparatedByString:@"src=\""];
//            NSString *aString = array.lastObject;
//            NSArray *anArray = [aString componentsSeparatedByString:@"?"];
//            [finalArray addObject:anArray.firstObject];
//        }
//    }
//    
//    if (finalArray.count > 0) {
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:finalArray];
//        NSString *tempString = [NSString stringWithFormat:@"剩余%lu个地址\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", (unsigned long)finalArray.count];
//        [UtilityFile showLogWithTitle:@"获取到所有Lofter地址" andContent:tempString clean:111];
//    } else {
//        [UtilityFile showLogWithTitle:@"没有获得任何数据" andFormat:@"请查看tempTest.txt文件" clean:111];
//    }
//}
//
//#pragma mark -- 和网络解析相关的操作方法 --
//+ (void)getLinkFromEHentai {
//    [UtilityFile showLogWithTitle:@"启动" andFormat:@"开始获取网页" clean:111];
//    
//    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
//    
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSMutableArray *componentArray = [NSMutableArray array];
//    //    componentArray = [NSMutableArray arrayWithArray:[content componentsSeparatedByString:@"\n"]];
//    
//    NSArray *constTempArray = [content componentsSeparatedByString:@"\n"];
//    for (NSString *string in constTempArray) {
//        NSArray *constArray = [string componentsSeparatedByString:@"|"];
//        if (constArray.count == 2) {
//            int page = [constArray[1] intValue];
//            NSString *constString = constArray[0];
//            
//            [componentArray addObject:constString];
//            for (int i = 1; i < page; i++) {
//                constString = constArray[0];
//                constString = [constString stringByAppendingString:[NSString stringWithFormat:@"?p=%d", i]];
//                [componentArray addObject:constString];
//            }
//        } else {
//            int startPage = [constArray[1] intValue];
//            int endPage = [constArray[2] intValue];
//            NSString *constString = @"";
//            for (int i = startPage; i <= endPage; i++) {
//                if (i == 1) {
//                    constString = constArray[0];
//                    [componentArray addObject:constString];
//                    continue;
//                }
//                constString = constArray[0];
//                constString = [constString stringByAppendingString:[NSString stringWithFormat:@"?p=%d", i - 1]];
//                [componentArray addObject:constString];
//            }
//        }
//    }
//    
//    for (NSString *string in componentArray) {
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//        NSArray *aArray = [xpathParser searchWithXPathQuery:@"//a"];
//        
//        for (TFHppleElement *elemnt in aArray) {
//            NSDictionary *aDic = [elemnt attributes];
//            NSString *string = [aDic objectForKey:@"href"];
//            if ([string hasPrefix:@"http://g.e-hentai.org/s/"]) {
//                [stringArray addObject:string];
//            }
//        }
//    }
//    NSString *webViewString = [NSString stringWithFormat:@"获取到%lu项网页", stringArray.count];
//    [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:webViewString];
//    
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    NSMutableArray *failedArray = [[NSMutableArray alloc] init];
//    for (NSString *string in stringArray) {
//        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//            if (!data) {
//                [failedArray addObject:string];
//            } else {
//                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//                NSArray *aArray = [xpathParser searchWithXPathQuery:@"//img"];
//                
//                for (TFHppleElement *elemnt in aArray) {
//                    NSDictionary *aDic = [elemnt attributes];
//                    NSString *string = [aDic objectForKey:@"src"];
//                    if ([string hasPrefix:@"http://1"] || [string hasPrefix:@"http://2"] || [string hasPrefix:@"http://3"] || [string hasPrefix:@"http://4"] || [string hasPrefix:@"http://5"] || [string hasPrefix:@"http://6"] || [string hasPrefix:@"http://7"] || [string hasPrefix:@"http://8"] || [string hasPrefix:@"http://9"]) {
//                        [resultArray addObject:string];
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *tempString = [NSString stringWithFormat:@"已获取到第%lu条记录 | 共%lu条记录", resultArray.count, stringArray.count];
//                    [UtilityFile showLogWithFormat:tempString];
//                });
//            }
//        });
//    }
//    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
//        if (failedArray.count > 0) {
//            [OldUselessCode afterGetOnceGroupDown:failedArray andResult:resultArray andTrytimes:0];
//        } else {
//            NSString *tempString = [NSString stringWithFormat:@"已获取到%lu项数据\n请前往上方的结果框查看", resultArray.count];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//                [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//            });
//        }
//    });
//}
//+ (void)getLinkFromUmei {
//    [UtilityFile showLogWithTitle:@"启动" andFormat:@"开始获取网页" clean:111];
//    
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSString *addressString = [[content componentsSeparatedByString:@"|"] objectAtIndex:0];
//    NSString *timesString = [[content componentsSeparatedByString:@"|"] objectAtIndex:1];
//    
//    NSMutableArray *stringArray = [NSMutableArray arrayWithArray:[OldUselessCode addSuffixToUmeiURLString:addressString forTimes:timesString.intValue]];
//    
//    NSString *webViewString = [NSString stringWithFormat:@"获取到%lu项网页", stringArray.count];
//    [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:webViewString];
//    
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    NSMutableArray *failedArray = [[NSMutableArray alloc] init];
//    for (NSString *string in stringArray) {
//        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//            if (!data) {
//                [failedArray addObject:string];
//            } else {
//                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//                NSArray *aArray = [xpathParser searchWithXPathQuery:@"//img"];
//                
//                for (TFHppleElement *elemnt in aArray) {
//                    NSDictionary *aDic = [elemnt attributes];
//                    NSString *string = [aDic objectForKey:@"src"];
//                    if ([string hasPrefix:@"http://i"]) {
//                        [resultArray addObject:string];
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *tempString = [NSString stringWithFormat:@"以获取到第%lu条记录", resultArray.count];
//                    [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//                });
//            }
//        });
//    }
//    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
//        if (failedArray.count > 0) {
//            //            [imageResource afterGetOnceGroupDown:failedArray andResult:resultArray andTrytimes:0];
//        } else {
//            NSString *tempString = [NSString stringWithFormat:@"以获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", resultArray.count];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//                [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//            });
//        }
//    });
//}
//+ (void)getLinkFromBCY {
//    NSString *content = [AppDelegate defaultVC].inputTextView.string;
//    
//    NSMutableArray *allArray = [NSMutableArray array];
//    //使用NSSet，去掉在收藏到Safari时就存在的重复页面
//    NSSet *set = [NSSet setWithArray:[content componentsSeparatedByString:@"\n"]];
//    [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
//        [allArray addObject:obj];
//    }];
//    
//    NSMutableArray *componentArray = [NSMutableArray array];
//    NSMutableArray *duplicateArray = [NSMutableArray array];
//    [allArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString *url = (NSString *)obj;
//        BCYLink *aLink = [[BCYLink alloc] initWithBCYLink:url];
//        
//        if ([[SQLiteFMDBManager defaultDBManager] isDuplicateFromDatabaseWithBCYLink:aLink]) {
//            [duplicateArray addObject:url];
//        } else {
//            [componentArray addObject:url];
//            [[SQLiteFMDBManager defaultDBManager] insertLinkIntoDatabase:aLink];
//        }
//    }];
//    [UtilityFile showLogWithTitle:[NSString stringWithFormat:@"一共有%ld个链接重复：", duplicateArray.count] andContent:[UtilityFile convertResultArray:duplicateArray]];
//    
//    NSMutableArray *bcyCosersID = [[NSMutableArray alloc] init];
//    
//    for (NSString *stirng in componentArray) {
//        NSArray *array = [stirng componentsSeparatedByString:@"/"];
//        [bcyCosersID addObject:array[array.count - 2]];
//    }
//    
//    
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    NSMutableArray *failedArray = [[NSMutableArray alloc] init];
//    for (NSString *string in componentArray) {
//        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//            if (!data) {
//                //                [failedArray addObject:string];
//            } else {
//                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//                NSArray *aArray = [xpathParser searchWithXPathQuery:@"//img"];
//                
//                for (TFHppleElement *elemnt in aArray) {
//                    NSDictionary *aDic = [elemnt attributes];
//                    NSString *string = [aDic objectForKey:@"src"];
//                    
//                    if ([OldUselessCode isCoserIDNeeded:string withArray:bcyCosersID]) {
//                        NSString *test = [string substringFromIndex:string.length - 5];
//                        if ([test hasPrefix:@"/w"]) {
//                            string = [string substringToIndex:string.length - 5];
//                        }
//                        if ([test hasPrefix:@"g/"] || [test hasPrefix:@"f/"]) {
//                            string = [string substringToIndex:string.length - 4];
//                        }
//                        
//                        //判断url地址是否为所需的地址
//                        NSArray *compontArray = [string componentsSeparatedByString:@"/"];
//                        NSString *stirng = compontArray[compontArray.count - 2];
//                        
//                        if (![OldUselessCode isUselessImageTagInBCYLink:string]) {
//                            if (stirng.length != 1) {
//                                [resultArray addObject:string];
//                            }
//                        }
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *tempString = [NSString stringWithFormat:@"已获取到第%lu条记录", resultArray.count];
//                    [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//                });
//            }
//        });
//    }
//    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
//        if (failedArray.count > 0) {
//            //            [OldUselessCode afterGetOnceGroupDown:failedArray andResult:resultArray andTrytimes:0];
//        } else {
//            //去除可能在获取到的网址中存在重复地址的情况
//            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:resultArray];
//            [resultArray removeAllObjects];
//            NSSet *set = [NSSet setWithArray:tempArray];
//            [set enumerateObjectsUsingBlock:^(NSString *obj, BOOL *stop) {
//                [resultArray addObject:obj];
//            }];
//            
//            NSString *tempString = [NSString stringWithFormat:@"已获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", resultArray.count];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//                [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//            });
//        }
//    });
//}
//+ (void)getLinkFromBCYLink {
//    NSData *data = [NSData dataWithContentsOfFile:@"/Users/Mercury/Downloads/Safari 书签.html"];
//    if (data) {
//        NSMutableArray *results = [NSMutableArray array];
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//        NSArray *aArray = [xpathParser searchWithXPathQuery:@"//a"];
//        
//        for (TFHppleElement *elemnt in aArray) {
//            NSDictionary *dict = [elemnt attributes];
//            NSString *url = [dict objectForKey:@"href"];
//            NSArray *array = [url componentsSeparatedByString:@"/"];
//            if ([array containsObject:@"bcy.net"] && [array containsObject:@"detail"]) {
//                [results addObject:url];
//            }
//        }
//        
//        if (results.count > 0) {
//            [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:results];
//            [UtilityFile showLogWithTitle:@"获取成功" andContent:[NSString stringWithFormat:@"获取到%lu个地址", (unsigned long)results.count] clean:111];
//        } else {
//            [UtilityFile showLogWithTitle:@"获取失败" andFormat:@"没有获得任何数据，请查看书签文件" clean:111];
//        }
//        
//    } else {
//        [UtilityFile showLogWithTitle:@"文件不存在" andFormat:@"路径地址：/Users/Mercury/Downloads/Safari 书签.html"];
//    }
//}
//+ (void)saveLinkIntoDatabase {
//    NSArray *temps = [[AppDelegate defaultVC].outputTextView.string componentsSeparatedByString:@"\n"];
//    
//    NSMutableArray *comps = [NSMutableArray array];
//    for (NSString *url in temps) {
//        if (![url isEqualToString:@""]) {
//            [comps addObject:url];
//        }
//    }
//    
//    [UtilityFile showLogWithFormat:@"一共有%ld条链接", comps.count] clean:111];
//    
//    NSMutableArray *duplicateArray = [NSMutableArray array];
//    NSMutableArray *resultArray = [NSMutableArray array];
//    for (NSString *url in comps) {
//        BCYImageLink *aLink = [[BCYImageLink alloc] initWithBCYImageLink:url];
//        
//        if ([[SQLiteImageFMDBManager defaultDBManager] isDuplicateFromDatabaseWithBCYImageLink:aLink]) {
//            [duplicateArray addObject:url];
//        } else {
//            [resultArray addObject:url];
//            [[SQLiteImageFMDBManager defaultDBManager] insertImageLinkIntoDatabase:aLink];
//        }
//    }
//    
//    if (duplicateArray.count + resultArray.count == comps.count) {
//        [UtilityFile showLogWithTitle:@"所有链接全部存入数据库" andContent:[NSString stringWithFormat:@"成功：%ld条，重复：%ld条", resultArray.count, duplicateArray.count]];
//        [UtilityFile showLogWithFormat:@"所有未重复的结果，已在上方结果框中显示"];
//        
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//    } else {
//        [UtilityFile showLogWithFormat:@"存取数据库时出现错误"];
//        NSMutableArray *missingArray = [NSMutableArray array];
//        
//        for (NSString *url in comps) {
//            if (![duplicateArray containsObject:url] && ![resultArray containsObject:url]) {
//                [missingArray addObject:url];
//            }
//        }
//        
//        [UtilityFile showLogWithTitle:@"出错的链接如下：" andContent:[UtilityFile convertResultArray:missingArray]];
//        [UtilityFile showLogWithFormat:@"所有未重复的结果，已在上方结果框中显示"];
//        
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//    }
//}
//
//#pragma mark -- 辅助方法 --
////如果E-Hentai的部分链接获取失败，那么循环获取
//+ (void)afterGetOnceGroupDown:(NSMutableArray *)failedArray andResult:(NSMutableArray *)resultArray andTrytimes:(int)tryTimes {
//    tryTimes++;
//    if (tryTimes == 4) {
//        [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//        NSString *tempString = [NSString stringWithFormat:@"以获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", resultArray.count];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//        });
//        NSString *tempStrings = [NSString stringWithFormat:@"还有%lu项数据没有获取到\n已在控制台输出所有未获取到的地址", failedArray.count];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [UtilityFile showLogWithTitle:@"有部分网页没有获取到" andContent:tempStrings];
//        });
//        NSLog(@"未获取到的地址：%@", failedArray);
//        return;
//    }
//    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:failedArray];
//    [failedArray removeAllObjects];
//    dispatch_group_t group = dispatch_group_create();
//    
//    for (NSString *string in tempArray) {
//        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//            if (!data) {
//                [failedArray addObject:string];
//            } else {
//                TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
//                NSArray *aArray = [xpathParser searchWithXPathQuery:@"//img"];
//                
//                for (TFHppleElement *elemnt in aArray) {
//                    NSDictionary *aDic = [elemnt attributes];
//                    NSString *string = [aDic objectForKey:@"src"];
//                    if ([string hasPrefix:@"http://1"] || [string hasPrefix:@"http://2"] || [string hasPrefix:@"http://3"] || [string hasPrefix:@"http://4"] || [string hasPrefix:@"http://5"] || [string hasPrefix:@"http://6"] || [string hasPrefix:@"http://7"] || [string hasPrefix:@"http://8"] || [string hasPrefix:@"http://9"]) {
//                        [resultArray addObject:string];
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *tempString = [NSString stringWithFormat:@"已获取到第%lu条记录 | 共%lu条记录", resultArray.count, resultArray.count + failedArray.count];
//                    [UtilityFile showLogWithFormat:tempString];
//                });
//            }
//        });
//    }
//    
//    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
//        if (failedArray.count > 0) {
//            [OldUselessCode afterGetOnceGroupDown:failedArray andResult:resultArray andTrytimes:tryTimes];
//        } else {
//            [AppDelegate defaultVC].outputTextView.string = [UtilityFile convertResultArray:resultArray];
//            NSString *tempString = [NSString stringWithFormat:@"已获取到%lu项数据\n所有数据已经写入到result.txt文件中\n请前往控制台输出的目录中查看", resultArray.count];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [UtilityFile showLogWithTitle:@"成功获取到网页" andContent:tempString];
//            });
//        }
//    });
//}//给umei.cc的链接加上后缀
//+ (NSMutableArray *)addSuffixToUmeiURLString:(NSString *)addressString forTimes:(int)times {
//    NSString *modelString = [addressString substringToIndex:addressString.length - 4];
//    
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    [tempArray addObject:addressString];
//    
//    for (int i = 2; i <= times; i++) {
//        NSString *addString = [NSString stringWithFormat:@"_%d.htm", i];
//        NSString *string = [modelString stringByAppendingString:addString];
//        [tempArray addObject:string];
//    }
//    
//    
//    return tempArray;
//}
////判断bcy地址中的CoserID是否是所需要的ID
//+ (BOOL)isCoserIDNeeded:(NSString *)urlString withArray:(NSMutableArray *)array {
//    for (NSString *idString in array) {
//        NSRange range = [urlString rangeOfString:idString];
//        if (range.length > 0) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}
//// 判断bcy地址中是否含有"/avatar/" "/editor/"
//+ (BOOL)isUselessImageTagInBCYLink:(NSString *)urlString {
//    NSRange aRange = [urlString rangeOfString:@"/avatar/"];
//    if (aRange.location != NSNotFound) {
//        return YES;
//    }
//    
//    NSRange bRange = [urlString rangeOfString:@"/editor/"];
//    if (bRange.location != NSNotFound) {
//        return YES;
//    }
//    
//    NSRange cRange = [urlString rangeOfString:@"/Public/"];
//    if (cRange.location != NSNotFound) {
//        return YES;
//    }
//    
//    NSRange dRange = [urlString rangeOfString:@"/cover/"];
//    if (dRange.location != NSNotFound) {
//        return YES;
//    }
//    
//    return NO;
//}

@end
