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
