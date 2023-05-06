//
//  XWDBHelper.m
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import "XWDBHelper.h"
#import <FMDB/FMDB.h>

static DHDBHelper *_dbHelper = nil;
static FMDatabase *_fmdb;

@implementation XWDBHelper

+ (instancetype)sharedDBHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbHelper = [[DHDBHelper alloc] init];
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
    
    NSString *createSql = @"CREATE table if not exists MKUsers(userid varchar(30) primary key not null, token varchar(30) not null, accessToken varchar(32) not null, username varchar(30)  not null,password varchar(30)  not null, userType int  not null, loginTime BIGINT not null)";
    [_fmdb executeUpdate:createSql];
}


- (NSMutableArray *)getAllUsers
{
    //执行查询SQL语句，返回查询结果   陈煦说这里只查询最新的三条记录
    FMResultSet *result = [_fmdb executeQuery:@"select * from MKUsers order by loginTime desc limit 3"];
//    FMResultSet *result = [_fmdb executeQuery:@"select * from MKUsers order by loginTime desc"];
    NSMutableArray *userArray = [NSMutableArray array];
    //获取查询结果的下一个记录
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        DHUserLoginRecordModel *user = [DHUserLoginRecordModel new];
        user.token = [DHHelper tripleDES:[result stringForColumn:@"token"] encryptOrDecrypt:kCCDecrypt];
        user.accessToken = [DHHelper tripleDES:[result stringForColumn:@"accessToken"] encryptOrDecrypt:kCCDecrypt];
        user.userType = [result intForColumn:@"userType"];
        user.userId = [result stringForColumn:@"userid"];
        user.username = [DHHelper tripleDES:[result stringForColumn:@"username"] encryptOrDecrypt:kCCDecrypt];
        user.password  = [DHHelper tripleDES:[result stringForColumn:@"passWord"] encryptOrDecrypt:kCCDecrypt];
        user.loginTime = [result longForColumn:@"loginTime"];
        //把字典添加进数组中
        [userArray addObject:user];
    }
    return userArray;
}

- (DHUserLoginRecordModel *)getLastLoginUser
{
    FMResultSet *result = [_fmdb executeQuery:@"select * from MKUsers order by loginTime desc limit 1"];
    DHUserLoginRecordModel *user = [DHUserLoginRecordModel new];
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        user.token = [DHHelper tripleDES:[result stringForColumn:@"token"] encryptOrDecrypt:kCCDecrypt];;
        user.accessToken = [DHHelper tripleDES:[result stringForColumn:@"accessToken"] encryptOrDecrypt:kCCDecrypt];;
        user.userType = [result intForColumn:@"userType"];
        user.userId = [result stringForColumn:@"userid"];
        user.username = [DHHelper tripleDES:[result stringForColumn:@"username"] encryptOrDecrypt:kCCDecrypt];;
        user.password  = [DHHelper tripleDES:[result stringForColumn:@"passWord"] encryptOrDecrypt:kCCDecrypt];;
        user.loginTime = [result longForColumn:@"loginTime"];
        //把字典添加进数组中
        break;
    }
    return user;
}



- (void)addUser:(DHUserLoginRecordModel *)user
{
    
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO MKUsers(userid, token, accessToken, username,password,userType,loginTime) VALUES('%@','%@','%@','%@','%@','%ld','%ld')",
                           user.userId,
                           [DHHelper tripleDES:user.token encryptOrDecrypt:kCCEncrypt],
                           [DHHelper tripleDES:user.accessToken  encryptOrDecrypt:kCCEncrypt],
                           [DHHelper tripleDES:user.username encryptOrDecrypt:kCCEncrypt],
                           [DHHelper tripleDES:user.password encryptOrDecrypt:kCCEncrypt]
                           , (long)user.userType, user.loginTime];
    [_fmdb executeUpdate:insertSql] ;

    
    NSUInteger count = [_dbHelper getAllUsers].count;
    if (count > 3) {
        NSString *deleteSql = [NSString stringWithFormat:@"delete from MKUsers order by loginTime limit 1"];
        [_fmdb executeUpdate:deleteSql];
    }
}


- (void)deleteUser:(NSString *)username
{
    NSString *deleteSql = [NSString stringWithFormat:@"delete from MKUsers where username = '%@'",[DHHelper tripleDES:username encryptOrDecrypt:kCCEncrypt]];
    [_fmdb executeUpdate:deleteSql];
}


@end


@end
