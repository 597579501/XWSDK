//
//  XWSDK.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWSDK.h"
#import "XWNetManager.h"
#import "XWGwDomainServer.h"
#import "XWApiDomainServer.h"
#import "XWSDKViewModel.h"
#import "XWCommonModel.h"



static XWSDK *_instance = nil;

//
@interface XWSDK ()

@property (nonatomic, strong) XWSDKViewModel *sdkViewModel;
@property (nonatomic, strong) XWCommonModel *commonModel;

@end

@implementation XWSDK

/// 单利方法
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)s
{
    [XWNetManager s];
}

- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel conf:appId appKey:appKey completion:completion failure:failure];
}

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel reg:name password:password code:code completion:^(NSString * _Nonnull userId) {
        
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (NSString *)version
{
    return @"1.0.0";
}
- (XWSDKViewModel *)sdkViewModel
{
    if (!_sdkViewModel)
    {
        _sdkViewModel = [[XWSDKViewModel alloc] init];
    }
    return _sdkViewModel;
}


@end
