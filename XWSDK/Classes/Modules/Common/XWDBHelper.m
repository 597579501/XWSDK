//
//  XWDBHelper.m
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import "XWDBHelper.h"
#import <FMDB/FMDB.h>
#import "XWUserLoginRecordModel.h"
#import "XWHelper.h"

static XWDBHelper *_dbHelper = nil;
static FMDatabase *_fmdb;

@implementation XWDBHelper

+ (instancetype)sharedDBHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbHelper = [[XWDBHelper alloc] init];
        [_dbHelper initialize];
    });
    return _dbHelper;
}

- (void)initialize{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"MK.DB"];
    // 实例化FMDataBase对象
    _fmdb = [FMDatabase databaseWithPath:filePath];
    [_fmdb open];
    
    NSString *createSql = @"CREATE table if not exists XWUsers(userid varchar(30) primary key not null, username varchar(30)  not null,password varchar(30)  not null, userType int  not null, loginTime BIGINT not null)";
    [_fmdb executeUpdate:createSql];
}


- (NSMutableArray *)getAllUsers
{
    //执行查询SQL语句，返回查询结果   陈煦说这里只查询最新的三条记录
    FMResultSet *result = [_fmdb executeQuery:@"select * from XWUsers order by loginTime desc limit 3"];
//    FMResultSet *result = [_fmdb executeQuery:@"select * from MKUsers order by loginTime desc"];
    NSMutableArray *userArray = [NSMutableArray array];
    //获取查询结果的下一个记录
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        XWUserLoginRecordModel *user = [XWUserLoginRecordModel new];
        user.userType = [result intForColumn:@"userType"];
        user.userId = [result stringForColumn:@"userid"];
        user.username = [XWHelper tripleDES:[result stringForColumn:@"username"] encryptOrDecrypt:kCCDecrypt];
        user.password  = [XWHelper tripleDES:[result stringForColumn:@"passWord"] encryptOrDecrypt:kCCDecrypt];
        user.loginTime = [result longForColumn:@"loginTime"];
        //把字典添加进数组中
        [userArray addObject:user];
    }
    return userArray;
}

- (XWUserLoginRecordModel *)getLastLoginUser
{
    FMResultSet *result = [_fmdb executeQuery:@"select * from XWUsers order by loginTime desc limit 1"];
    XWUserLoginRecordModel *user = [XWUserLoginRecordModel new];
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        user.userType = [result intForColumn:@"userType"];
        user.userId = [result stringForColumn:@"userid"];
        user.username = [XWHelper tripleDES:[result stringForColumn:@"username"] encryptOrDecrypt:kCCDecrypt];;
        user.password  = [XWHelper tripleDES:[result stringForColumn:@"passWord"] encryptOrDecrypt:kCCDecrypt];;
        user.loginTime = [result longForColumn:@"loginTime"];
        //把字典添加进数组中
        break;
    }
    return user;
}



- (void)addUser:(XWUserLoginRecordModel *)user
{
    
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO XWUsers(userid, username,password,userType,loginTime) VALUES('%@','%@','%@','%ld','%ld')",
                           user.userId,
//                           [XWHelper tripleDES:user.token encryptOrDecrypt:kCCEncrypt],
//                           [XWHelper tripleDES:user.accessToken  encryptOrDecrypt:kCCEncrypt],
                           [XWHelper tripleDES:user.username encryptOrDecrypt:kCCEncrypt],
                           [XWHelper tripleDES:user.password encryptOrDecrypt:kCCEncrypt]
                           , (long)user.userType, user.loginTime];
    bool s = [_fmdb executeUpdate:insertSql] ;
    

    
    NSUInteger count = [_dbHelper getAllUsers].count;
    if (count > 3) {
        NSString *deleteSql = [NSString stringWithFormat:@"delete from XWUsers order by loginTime limit 1"];
        [_fmdb executeUpdate:deleteSql];
    }
}


- (void)deleteUser:(NSString *)username
{
    NSString *deleteSql = [NSString stringWithFormat:@"delete from XWUsers where username = '%@'",[XWHelper tripleDES:username encryptOrDecrypt:kCCEncrypt]];
    [_fmdb executeUpdate:deleteSql];
}


@end

