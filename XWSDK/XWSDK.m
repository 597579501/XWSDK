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
#import "XWFloatWindow.h"
#import "XWSDKHeader.h"

static XWSDK *_instance = nil;

//
@interface XWSDK ()

@property (nonatomic, strong) XWSDKViewModel *sdkViewModel;
@property (nonatomic, strong) XWCommonModel *commonModel;
@property (nonatomic, strong) XWFloatWindow *floatWindow;
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



- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel conf:appId appKey:appKey completion:^(XWConfModel * _Nonnull confModel) {
        
    } failure:^(NSString * _Nonnull errorMessage) {
        
    }];
}

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel reg:name password:password code:code completion:^(NSString * _Nonnull userId) {
        if(completion)
        {
            completion(userId);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel login:name password:password completion:^(XWUserModel * _Nonnull userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}


- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel start:^(XWUserModel * _Nonnull userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
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
    [self.sdkViewModel alive:roleModel completion:^(XWUserModel * _Nonnull userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
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
    [self.sdkViewModel open:order completion:^(NSString *orderId, NSString *url) {
        if(completion)
        {
            completion(orderId, url);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}


- (void)initWindow:(NSDictionary *)dictionary
{
//    _canShowController = YES;
    WS(weakSelf);
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIImage *image = [UIImage imageNamed:@"XW_SDK_FloatWindow"];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
    [image drawInRect:rect];
    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIColor *floatWindowBGcolor = [UIColor colorWithPatternImage:lastImage];
    
    if (!_floatWindow)
    {
        _floatWindow = [[XWFloatWindow alloc] initWithFrame:rect mainImageName:@"XW_SDK_FloatIcon"
                                                  imagesAndTitle:dictionary
                                                         bgcolor:floatWindowBGcolor
                                                  animationColor:[UIColor clearColor]] ;
        [_floatWindow dissmissWindow];
        _floatWindow.clickBolcks = ^(NSInteger i){
//            if (weakSelf.canShowController) {
//                [weakSelf userCenter];
//            }
        };
    }
    
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
