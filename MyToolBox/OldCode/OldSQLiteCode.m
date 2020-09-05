//
//  OldSQLiteCode.m
//  MyToolBox
//
//  Created by 龚宇 on 16/03/18.
//  Copyright © 2016年 gongyuTest. All rights reserved.
//

#import "OldSQLiteCode.h"

@implementation OldSQLiteCode

static OldSQLiteCode *_sharedDBManager;

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
+ (OldSQLiteCode *)defaultDBManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedDBManager = [[OldSQLiteCode alloc] init];
    });
    
    return _sharedDBManager;
}

// -------------------------------------------------------------------------------
//	创建数据库
// -------------------------------------------------------------------------------
- (void)createDatabase {
    db = [FMDatabase databaseWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"bcyDatabase.sqlite"]];
}
- (void)createTable {
    if (![db tableExists:@"bcyLink"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE bcyLink(id integer PRIMARY KEY AUTOINCREMENT, url text)"];
        
        if (!success) {
            [UtilityFile showLogWithFormat:@"数据表:\"bcyLink\"不存在且建立失败"];
        }
    }
}

// -------------------------------------------------------------------------------
//	通用数据库操作
// -------------------------------------------------------------------------------
- (void)execSqlInFmdb:(BOOL (^)())block description:(NSString *)desc { //适用于增删改
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self createDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库打开失败"]];
        return;
    }
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    //判断所需的数据表是否已经建立，如果未建立，建立对应数据表
    [self createTable];
    
    if (block) {
        BOOL success = block();
        
        if (!success) {
            [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库执行语句错误"]];
        }
    } else {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：block 传入错误"]];
    }
    
    [db close];
}
- (NSMutableArray *)querySqlInFmdb:(NSMutableArray *(^)())block description:(NSString *)desc { //适用于查
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self createDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库打开失败"]];
        return nil;
    }
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    //判断所需的数据表是否已经建立，如果未建立，建立对应数据表
    [self createTable];
    
    if (block) {
        NSMutableArray *array = block();
        if (array.count == 0) {
            //            [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，结果：没有查询到数据"]];
            [db close];
            return nil;
        } else {
            [db close];
            return array;
        }
    } else {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：block 传入错误"]];
        [db close];
        return nil;
    }
}

// -------------------------------------------------------------------------------
//	业务逻辑
// -------------------------------------------------------------------------------
- (BOOL)isDuplicateFromDatabaseWithBCYLink:(NSString *)urlString {
    NSMutableArray *array = [self querySqlInFmdb:^() {
        NSMutableArray *array = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:@"select * from bcyLink where url = ?", urlString];
        while ([rs next]) {
            NSString *result = [rs stringForColumn:@"url"];
            
            [array addObject:result];
        }
        [rs close];
        
        return array;
    } description:@"从数据表:\"bcyLink\"查询数据"];
    
    return array.count != 0;
}
- (void)insertLinkIntoDatabase:(NSString *)urlString {
    [self execSqlInFmdb:^() {
        BOOL success = [db executeUpdate:@"INSERT INTO bcyLink (id, url) values(?, ?)", NULL, urlString];
        return success;
    } description:@"往数据表:\"bcyLink\"插入数据"];
}

@end

//-------------------------------------------------------------------------------------------------------------------------------

@implementation OldSQLiteImageCode

static OldSQLiteImageCode *_sharedImageDBManager;

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
+ (OldSQLiteImageCode *)defaultDBManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedImageDBManager = [[OldSQLiteImageCode alloc] init];
    });
    
    return _sharedImageDBManager;
}

// -------------------------------------------------------------------------------
//	创建数据库
// -------------------------------------------------------------------------------
- (void)createDatabase {
    db = [FMDatabase databaseWithPath:[[DeviceInfo sharedDevice].path_root_folder stringByAppendingPathComponent:@"bcyImageDatabase.sqlite"]];
}
- (void)createTable {
    if (![db tableExists:@"bcyImageLink"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE bcyImageLink(id integer PRIMARY KEY AUTOINCREMENT, url text)"];
        
        if (!success) {
            [UtilityFile showLogWithFormat:@"数据表:\"bcyImageLink\"不存在且建立失败"];
        }
    }
}

// -------------------------------------------------------------------------------
//	通用数据库操作
// -------------------------------------------------------------------------------
- (void)execSqlInFmdb:(BOOL (^)())block description:(NSString *)desc { //适用于增删改
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self createDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库打开失败"]];
        return;
    }
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    //判断所需的数据表是否已经建立，如果未建立，建立对应数据表
    [self createTable];
    
    if (block) {
        BOOL success = block();
        
        if (!success) {
            [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库执行语句错误"]];
        }
    } else {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：block 传入错误"]];
    }
    
    [db close];
}
- (NSMutableArray *)querySqlInFmdb:(NSMutableArray *(^)())block description:(NSString *)desc { //适用于查
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self createDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：数据库打开失败"]];
        return nil;
    }
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    //判断所需的数据表是否已经建立，如果未建立，建立对应数据表
    [self createTable];
    
    if (block) {
        NSMutableArray *array = block();
        if (array.count == 0) {
            //            [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，结果：没有查询到数据"]];
            [db close];
            return nil;
        } else {
            [db close];
            return array;
        }
    } else {
        [UtilityFile showLogWithFormat:[desc stringByAppendingString:@"，错误原因：block 传入错误"]];
        [db close];
        return nil;
    }
}

// -------------------------------------------------------------------------------
//	业务逻辑
// -------------------------------------------------------------------------------
- (BOOL)isDuplicateFromDatabaseWithBCYImageLink:(NSString *)urlString {
    NSMutableArray *array = [self querySqlInFmdb:^() {
        NSMutableArray *array = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:@"select * from bcyImageLink where url = ?", urlString];
        while ([rs next]) {
            NSString *result = [rs stringForColumn:@"url"];
            
            [array addObject:result];
        }
        [rs close];
        
        return array;
    } description:@"从数据表:\"bcyImageLink\"查询数据"];
    
    return array.count != 0;
}
- (void)insertImageLinkIntoDatabase:(NSString *)urlString {
    [self execSqlInFmdb:^() {
        BOOL success = [db executeUpdate:@"INSERT INTO bcyImageLink (id, url) values(?, ?)", NULL, urlString];
        return success;
    } description:@"往数据表:\"bcyImageLink\"插入数据"];
    
}

@end
