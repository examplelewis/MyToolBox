//
//  MethodLink.m
//  MyToolBox
//
//  Created by 龚宇 on 16/03/15.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "MethodLink.h"

#import "TextRelative.h"
#import "FileRelative.h"
#import "PhotoRelative.h"
#import "InternetRelative.h"
#import "SQLiteRelative.h"

//#import "ImportFilesIntoPhotos.h"
#import "SearchForDuplicateMangaFile.h"
#import "DistinguishBlackWhitePicture.h"
#import "OrganizingDayFolder.h"

#import "MorseCode.h"
#import "URLCode.h"
#import "Unicode.h"

#import "SQLiteFMDBManager.h"

#import "MTBAppLogoCutter.h"
#import "MTBiOSIconCutter.h"

// -------------------------------------------------------------------------------
//	CodingMethods
// -------------------------------------------------------------------------------
@implementation CodingMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [MorseCode encodeMorseCode];
        }
            break;
        case 1: {
            [MorseCode decodeMorseCode];
        }
            break;
        case 2: {
            [URLCode encodeURL];
        }
            break;
        case 3: {
            [URLCode decodeURL];
        }
            break;
        case 4: {
            [URLCode decodeGBK];
        }
            break;
        case 5: {
            [Unicode encodeUnicode];
        }
            break;
        case 6: {
            [Unicode decodeUnicode];
        }
            break;
        default:
            break;
    }
}

@end

// -------------------------------------------------------------------------------
//	TextToolMethods
// -------------------------------------------------------------------------------
@implementation TextToolMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [[TextRelative defaultManager] abstractTextWithiBooks];
        }
            break;
        case 1: {
            [[TextRelative defaultManager] cleanDuplicateText];
        }
            break;
        case 2: {
            [[TextRelative defaultManager] convertScripterTextToNSString];
        }
            break;
        default:
            break;
    }
}

@end

// -------------------------------------------------------------------------------
//	FileToolMethods
// -------------------------------------------------------------------------------
@implementation FileToolMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [[OrganizingDayFolder defaultInstance] start];
        }
            break;
        case 1: {
            [[SearchForDuplicateMangaFile defaultInstance] start];
        }
            break;
        case 2: {
            [[FileRelative defaultManager] arrangeGIFFile];
        }
            break;
        case 3: {
            [[FileRelative defaultManager] moveMangaFileToTC];
        }
            break;
        default:
            break;
    }
}

@end

// -------------------------------------------------------------------------------
//	PhotoToolMethods
// -------------------------------------------------------------------------------
@implementation PhotoToolMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [[DistinguishBlackWhitePicture defaultInstance] start];
        }
            break;
        case 10: {
            [MTBAppLogoCutter showOpenPanel];
        }
            break;
        case 11: {
            [MTBiOSIconCutter showOpenPanel];
        }
            break;
        default:
            break;
    }
}

@end

// -------------------------------------------------------------------------------
//	InternetToolMethods
// -------------------------------------------------------------------------------
@implementation InternetToolMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [[InternetRelative defaultManager] getAllUrlsFromSafari];
        }
            break;
        case 1: {
            [[InternetRelative defaultManager] getAllUrlsAndTitlesFromSafari];
        }
            break;
        case 2: {
            [[InternetRelative defaultManager] getAllUrlsFrom115];
        }
            break;
        case 3: {
            [[InternetRelative defaultManager] getAllUrlsAndTitlesFrom115];
        }
            break;
        case 4: {
            [[InternetRelative defaultManager] getAllUrlsFromChrome];
        }
            break;
        case 5: {
            [[InternetRelative defaultManager] getAllUrlsAndTitlesFromChrome];
        }
            break;
        case 6: {
            [[InternetRelative defaultManager] closeTabsInSafariWithURLHeads];
        }
            break;
        default:
            break;
    }
}

@end

// -------------------------------------------------------------------------------
//	SQLiteToolMethods
// -------------------------------------------------------------------------------
@implementation SQLiteToolMethods

+ (void)configMethod:(NSInteger)cellRow {
    switch (cellRow) {
        case 0: {
            [[SQLitePixivUtilFMDBManager defaultDBManager] deleteSpecificData];
        }
            break;
        default:
            break;
    }
}

@end
