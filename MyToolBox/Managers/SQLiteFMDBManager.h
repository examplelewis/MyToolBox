//
//  SQLiteFMDBManager.h
//  iOSLearningBox
//
//  Created by 龚宇 on 15/07/30.
//  Copyright (c) 2015年 softweare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SQLiteFMDBManager : NSObject {
    FMDatabase *db;
}

+ (SQLiteFMDBManager *)defaultDBManager;

- (BOOL)isDuplicateFromDatabaseWithBCYLink:(NSString *)urlString;
- (void)insertLinkIntoDatabase:(NSString *)urlString;
- (void)removeDuplicatesFromDatabase;

@end

// -------------------------------------------------------------------------------

@interface SQLiteImageFMDBManager : NSObject {
    FMDatabase *db;
}

+ (SQLiteImageFMDBManager *)defaultDBManager;

- (BOOL)isDuplicateFromDatabaseWithBCYImageLink:(NSString *)urlString;
- (void)insertImageLinkIntoDatabase:(NSString *)urlString;
- (void)removeDuplicatesFromDatabase;

@end

// -------------------------------------------------------------------------------

@interface SQLitePixivUtilFMDBManager : NSObject {
    FMDatabase *db;
}

+ (SQLitePixivUtilFMDBManager *)defaultDBManager;

- (void)deleteSpecificData;

@end
