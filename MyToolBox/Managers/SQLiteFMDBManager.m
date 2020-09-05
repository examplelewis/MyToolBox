//
//  SQLiteFMDBManager.m
//  iOSLearningBox
//
//  Created by 龚宇 on 15/07/30.
//  Copyright (c) 2015年 softweare. All rights reserved.
//

#import "SQLiteFMDBManager.h"

@implementation SQLitePixivUtilFMDBManager

static SQLitePixivUtilFMDBManager *_sharedPixivUtilDBManager;

// -------------------------------------------------------------------------------
//	单例模式
// -------------------------------------------------------------------------------
+ (SQLitePixivUtilFMDBManager *)defaultDBManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedPixivUtilDBManager = [[SQLitePixivUtilFMDBManager alloc] init];
    });
    
    return _sharedPixivUtilDBManager;
}

// -------------------------------------------------------------------------------
//	创建数据库
// -------------------------------------------------------------------------------
- (void)createDatabase {
    db = [FMDatabase databaseWithPath:@"/Volumes/工具/pixivutil/db.sqlite"];
}

// -------------------------------------------------------------------------------
//	业务逻辑
// -------------------------------------------------------------------------------
- (void)deleteSpecificData {
    [UtilityFile resetCurrentDate];
    [[UtilityFile sharedInstance] showLogWithFormat:@"删除PixivUtil的数据内容：已经准备就绪"];
    
    NSString *pixiv_member_id = [AppDelegate defaultVC].inputTextView.string;
    if (pixiv_member_id.length == 0) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"请输入Pixiv ID"];
        return;
    } else {
        [[UtilityFile sharedInstance] showLogWithFormat:@"需要删除的ID:%@", pixiv_member_id];
    }
    NSString *sqlManga = [NSString stringWithFormat:@"DELETE FROM pixiv_manga_image WHERE image_id IN(select image_id from pixiv_master_image where member_id = %@ and is_manga = 'manga')", pixiv_member_id];
    NSString *sqlMaster = [NSString stringWithFormat:@"DELETE FROM pixiv_master_image where member_id = %@", pixiv_member_id];
    
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self createDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"从数据表:中查询数据时发生错误：%@", [db lastErrorMessage]];
    }
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    if (![db executeUpdate:sqlManga]) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"删除manga内容时发生错误：%@", [db lastErrorMessage]];
    }
    if (![db executeUpdate:sqlMaster]) {
        [[UtilityFile sharedInstance] showLogWithFormat:@"删除master内容时发生错误：%@", [db lastErrorMessage]];
    }
    
    [db close];
    
    [[UtilityFile sharedInstance] showLogWithFormat:@"删除PixivUtil的数据内容：流程已经结束"];
}


@end
