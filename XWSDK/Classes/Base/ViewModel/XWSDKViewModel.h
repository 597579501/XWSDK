//
//  XWSDKViewModel.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWViewModel.h"
#import "XWCommonModel.h"
#import "XWUserModel.h"
#import "XWOrderModel.h"
#import "XWConfModel.h"
#import "XWSDKEnumHeader.h"
#import "XWUserLoginRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWSDKViewModel : XWViewModel


@property (nonatomic, strong) NSString *appKey;


- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(XWConfModel *confModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)sendCode:(NSString *)phone name:(NSString *)name codeType:(XWCodeType)codeType completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)update:(NSString *)name password:(NSString *)password newPassword:(NSString *)newPassword completion:(void(^)(void))completion
       failure:(void(^)(NSString *errorMessage))failure;

- (void)bind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
  completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)unBind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
    completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)resetPassword:(NSString *)phone code:(NSString *)code newPassword:(NSString *)newPassword completion:(void(^)(void))completion
              failure:(void(^)(NSString *errorMessage))failure;

- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)alive:(XWRoleModel *)roleModel
   completion:(void(^)(XWUserModel *userModel))completion
      failure:(void(^)(NSString *errorMessage))failure;


- (void)open:(XWOrderModel *)order
   completion:(void(^)(NSString *orderId, NSString *url))completion
     failure:(void(^)(NSString *errorMessage))failure;

- (XWUserLoginRecordModel *)getUserInformation;

@end

NS_ASSUME_NONNULL_END
