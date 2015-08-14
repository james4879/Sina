//
//  StatusCacheTool.m
//  Sina
//
//  Created by James on 3/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusCacheTool.h"
#import "FMDB.h"
#import "AccountTool.h"
#import "Account.h"
#import "StatusParameter.h"
#import "Status.h"

@implementation StatusCacheTool

static FMDatabase *_db;

/** 初始化 */
+ (void)initialize
{
    // 获取缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"status.sqlite"];
    // 获取数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    // 打开数据库
    if ([_db open]) {
        NSLog(@"数据库打开成功");
    } else {
        NSLog(@"数据库打开失败");
    }
    // 创建数据库表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, idstr text, access_token text, dict blob);"];
    if (flag) {
        NSLog(@"创建数据库表成功");
    } else {
        NSLog(@"创建数据库表失败");
    }
}

/** 模型数组 */
+ (void)saveStatus:(NSMutableArray *)status
{
    // 遍历模型数组
    for (NSDictionary *statusDic in status) {
        NSString *idstr = statusDic[@"idstr"];
        NSString *accessToken = [AccountTool account].access_token;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDic];
        // 插入数据库
        BOOL insert = [_db executeUpdate:@"insert into t_status (idstr, access_token, dict) values (?, ?, ?);", idstr, accessToken, data];
        if (insert) {
            NSLog(@"插入数据成功");
        } else {
            NSLog(@"插入数据失败");
        }
    }
}

/** 参数模型 */
+ (NSMutableArray *)statusWithParam:(StatusParameter *)param
{
    // 第一次进入程序的查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;", param.access_token];
    if (param.since_id) {// 加载最新的
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;", param.access_token, param.since_id];
    } else if (param.max_id) {// 加载更多
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;", param.access_token, param.max_id];
    }
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *tmpArray = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"dict"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        Status *status = [Status objectWithKeyValues:dic];
        [tmpArray addObject:status];
    }
    return tmpArray;
}

@end
