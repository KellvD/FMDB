//
//  FMDBManager.m
//  FMDBD
//
//  Created by changdong on 2019/4/11.
//  Copyright © 2019 baize. All rights reserved.
//

#import "FMDBManager.h"
static FMDatabase *fmda = nil;
@implementation FMDBManager


+(instancetype)instance{
    static FMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc]init];
    });

    return manager;
}

//创建表
-(BOOL)createFMDB{
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)firstObject];
    NSString *fmdbPath = [libPath stringByAppendingPathComponent:@"fmdb.db"];
    fmda = [[FMDatabase alloc]initWithPath:fmdbPath];

    BOOL state = NO;
    if (![fmda open]) {
        return NO;
    }
    //创建表数据
    BOOL sc = [fmda executeUpdate:@"CREATE TABLE IF NOT EXISTS demoList(ids integer ,name text, title text)"];
    if (sc) {
        NSLog(@"表创建成功");
    }else{
        NSLog(@"表创建失败");
    }
    [fmda close];
    return state;
}
//校验表的有效性
-(BOOL)checkFMDBEffective:(NSString *)tableName{
    FMResultSet *set = [fmda executeQuery:@"select count(*) as 'count' from demoList where type ='table' and name = ?",tableName];
    while ([set next]) {
        NSInteger count = [set intForColumn:@"count"];
        if (count == 0) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}
//增
-(BOOL)addOneDataWith:(FMDBModel *)model{
    [fmda open];
    NSString *sql = [NSString stringWithFormat:@"insert into demoList(ids,name,title) values(%d,'%@','%@')",model.ids,model.name,model.title];

    BOOL success = [fmda executeUpdate:sql];
    if (success) {
        NSLog(@"增加数据数据成功");
    }else{
        NSLog(@"新增数据失败");
    }
    [fmda close];
    return success;
}
//删
-(BOOL)deleteOneDataWith:(FMDBModel *)model{
    [fmda open];
    NSString *sql = [NSString stringWithFormat:@"delete from demoList where ids = %d",model.ids];
    BOOL success = [fmda executeUpdate:sql];
    if (success) {
        NSLog(@"删除数据数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
    [fmda close];
    return success;
}
//改
-(BOOL)updateOneDataWith:(FMDBModel *)model{
    [fmda open];
    NSString *sql = nil;
    BOOL success = [fmda executeUpdate:sql];
    if (success) {
        NSLog(@"修改数据数据成功");
    }else{
        NSLog(@"修改数据失败");
    }
    [fmda close];
    return success;
}
//查
//-(FMDBModel *)queryOneDataWith:(FMDBModel *)model;
-(NSMutableArray *)queryAllData{

    [fmda open];
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *fmset = [fmda executeQuery:@"select * from demoList order by ids desc"];
    while ([fmset next]) {
        FMDBModel *model = [[FMDBModel alloc]init];
        model.ids = [fmset intForColumn:@"ids"];
        model.name = [fmset stringForColumn:@"name"];
        model.title = [fmset stringForColumn:@"title"];
        [array addObject:model];
    }
    [fmda close];
    return array;
}

-(int)queryMaxIds{
    [fmda open];
    int ids = 0;
    FMResultSet *fmset = [fmda executeQuery:@"select max(ids) as ids from demoList"];
    while ([fmset next]) {

        if (![fmset columnIndexIsNull:0]) {
            ids = [fmset intForColumn:@"ids"];
        }
    }
    [fmda close];
    return ids;
}
@end
