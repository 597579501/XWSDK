//
//  XWSDKViewModel.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWSDKViewModel.h"
#import "XWApiDomainServer.h"
#import "XWGwDomainServer.h"
#import "XWConfModel.h"
#import <YYModel/YYModel.h>

@implementation XWSDKViewModel

- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    [XWCommonModel sharedInstance].appId = appId;
    [XWCommonModel sharedInstance].appKey = appKey;
    [XWGwDomainServer conf:^(id data) {
        XWConfModel *confModel = [XWConfModel yy_modelWithJSON:data];
        
    } failure:^(NSString *errorMessage) {
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
        XWUserModel *userModel = [XWUserModel yy_modelWithJSON:data];
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
