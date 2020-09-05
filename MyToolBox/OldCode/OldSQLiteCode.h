//
//  OldSQLiteCode.h
//  MyToolBox
//
//  Created by 龚宇 on 16/03/18.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface OldSQLiteCode : NSObject {
    FMDatabase *db;
}

+ (OldSQLiteCode *)defaultDBManager;

- (BOOL)isDuplicateFromDatabaseWithBCYLink:(NSString *)anObject;
- (void)insertLinkIntoDatabase:(NSString *)anObject;

@end

// -------------------------------------------------------------------------------

@interface OldSQLiteImageCode : NSObject {
    FMDatabase *db;
}

+ (OldSQLiteImageCode *)defaultDBManager;

- (BOOL)isDuplicateFromDatabaseWithBCYImageLink:(NSString *)anObject;
- (void)insertImageLinkIntoDatabase:(NSString *)anObject;

@end