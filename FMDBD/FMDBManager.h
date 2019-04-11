//
//  FMDBManager.h
//  FMDBD
//
//  Created by changdong on 2019/4/11.
//  Copyright © 2019 baize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBModel.h"
#import "FMDB.h"
@interface FMDBManager : NSObject
+(instancetype)instance;

//创建表
-(BOOL)createFMDB;
//校验表的有效性
-(BOOL)checkFMDBEffective:(NSString *)tableName;
//增
-(BOOL)addOneDataWith:(FMDBModel *)model;
//删
-(BOOL)deleteOneDataWith:(FMDBModel *)model;
//改
-(BOOL)updateOneDataWith:(FMDBModel *)model;
//查
//-(FMDBModel *)queryOneDataWith:(FMDBModel *)model;
-(NSMutableArray *)queryAllData;

-(int)queryMaxIds;
@end

