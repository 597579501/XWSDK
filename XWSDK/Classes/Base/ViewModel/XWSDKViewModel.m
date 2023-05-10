//
//  XWSDKViewModel.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWSDKViewModel.h"
#import "XWApiDomainServer.h"
#import "XWGwDomainServer.h"
#import "XWLogDomainServer.h"
#import "XWConfModel.h"
#import "XWUserLoginRecordModel.h"
#import "XWDBHelper.h"
#import "XWSDKHeader.h"
#import "XWHelper.h"
#import <YYKit/YYKit.h>


@implementation XWSDKViewModel

- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(XWConfModel *confModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [XWCommonModel sharedInstance].appId = appId;
    [XWCommonModel sharedInstance].appKey = appKey;
    [XWGwDomainServer conf:^(id data) {
        XWConfModel *confModel = [XWConfModel modelWithJSON:data];
        if (completion && confModel)
        {
            completion(confModel);
        }
    } failure:^(NSString *errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)sendCode:(NSString *)phone name:(NSString *)name codeType:(XWCodeType)codeType completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    [XWGwDomainServer sendCode:phone name:name codeType:codeType success:^(id  _Nullable data) {
        if (completion)
        {
            completion();
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    [XWGwDomainServer reg:name password:password code:code success:^(id data) {
        NSString *userId = data[@"user_id"];
        if (completion && userId)
        {
            
            long currTime = [[NSDate date] timeIntervalSince1970] ;
            XWUserLoginRecordModel *userLoginRecordModel = [XWUserLoginRecordModel new];
            [userLoginRecordModel setUsername:name];
            [userLoginRecordModel setLoginTime:currTime];
            [userLoginRecordModel setUserId:userId];
            [userLoginRecordModel setPassword:password];
    //        if (userType == UserTypeByPhone) {
    //            [userLoginRecordModel setUsername:phoneNumber];
    //        }
    //        else if (userType == UserTypeByNormal)
    //        {
    //            [userLoginRecordModel setUsername:userResponeModel.username];
    //        }
            
            [self saveUserInformation:userLoginRecordModel user:nil isPostNotification:NO];
            completion(userId);
        }
    } failure:^(NSString *errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}


- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    [XWGwDomainServer login:name password:password success:^(id data) {
        XWUserModel *userModel = [XWUserModel modelWithJSON:data];
        long currTime = [[NSDate date] timeIntervalSince1970] ;
        XWUserLoginRecordModel *userLoginRecordModel = [XWUserLoginRecordModel new];
        [userLoginRecordModel setLoginTime:currTime];
        [userLoginRecordModel setUserId:userModel.userId];
        [userLoginRecordModel setUsername:name];
        [userLoginRecordModel setPassword:password];
//        if (userType == UserTypeByPhone) {
//            [userLoginRecordModel setUsername:phoneNumber];
//        }
//        else if (userType == UserTypeByNormal)
//        {
//            [userLoginRecordModel setUsername:userResponeModel.username];
//        }
        
        [self saveUserInformation:userLoginRecordModel user:userModel isPostNotification:YES];
        if (completion && userModel)
        {
            completion(userModel);
        }
    } failure:^(NSString *errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}


- (void)bind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
  completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [XWGwDomainServer bind:name password:password phone:phone code:code success:^(id  _Nullable data) {
        
        XWUserModel *userModel = [XWUserModel modelWithJSON:data];
        
        if (completion && userModel)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)unBind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
    completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [XWGwDomainServer unBind:name password:password phone:phone code:code success:^(id  _Nullable data) {
        XWUserModel *userModel = [XWUserModel modelWithJSON:data];
        if (completion && userModel)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}





- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    
    [XWLogDomainServer start:^(id  _Nullable data) {
        
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)alive:(XWRoleModel *)roleModel
   completion:(void(^)(XWUserModel *userModel))completion
      failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    
    [XWLogDomainServer alive:roleModel success:^(id  _Nullable data) {
            
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)update:(NSString *)name password:(NSString *)password newPassword:(NSString *)newPassword completion:(void(^)(void))completion
       failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    [XWGwDomainServer update:name password:password newPassword:newPassword success:^(id  _Nullable data) {
        if (completion)
        {
            completion();
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)resetPassword:(NSString *)phone code:(NSString *)code newPassword:(NSString *)newPassword completion:(void(^)(void))completion
              failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    [XWGwDomainServer resetPassword:phone newPassword:newPassword code:code success:^(id  _Nullable data) {
        if (completion)
        {
            completion();
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}




- (void)open:(XWOrderModel *)order
   completion:(void(^)(NSString *orderId, NSString *url))completion
      failure:(void(^)(NSString *errorMessage))failure
{
    if (![self checkConf])
    {
        failure(@"未初始化SDK");
        return;
    }
    
    [XWGwDomainServer open:order success:^(id  _Nullable data) {
        NSString *url = data[@"pay_url"];
        NSString *orderId = data[@"order_id"];
        if (url && orderId)
        {
            completion(orderId, url);
        }
    } failure:^(NSString * _Nullable errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)saveUserInformation:(XWUserLoginRecordModel *)userLoginRecordModel  user:(XWUserModel* )user isPostNotification:(BOOL)isPost
{
    [[XWDBHelper sharedDBHelper] deleteUser:userLoginRecordModel.username];
    [[XWDBHelper sharedDBHelper] addUser:userLoginRecordModel];
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLastUserInfo];
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:kAotuLogin];
    
    NSString *userString = [XWHelper tripleDES:[userLoginRecordModel modelToJSONString] encryptOrDecrypt:kCCEncrypt];
    
    [[NSUserDefaults standardUserDefaults] setObject:userString forKey:kLastUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    if (isPost)
    {
        NSNotification *notification = [NSNotification notificationWithName:@"InfoNotification" object:user userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

- (XWUserLoginRecordModel *)getUserInformation
{
    NSString *modelString = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUserInfo];
    if (modelString)
    {
        modelString = [XWHelper tripleDES:modelString encryptOrDecrypt:kCCDecrypt];
        XWUserLoginRecordModel *user = [XWUserLoginRecordModel modelWithJSON:modelString];
        return user;
    }
    return nil;
}


- (BOOL)checkConf
{
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    if (commonModel.appId && commonModel.appKey)
    {
        return YES;
    }
    return NO;
}


@end
