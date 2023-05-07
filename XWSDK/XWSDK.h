//
//  XWSDK.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <Foundation/Foundation.h>
#import <XWSDK/XWUserModel.h>
#import <XWSDK/XWRoleModel.h>
#import <XWSDK/XWOrderModel.h>


//! Project version number for XWSDK.
FOUNDATION_EXPORT double XWSDKVersionNumber;

//! Project version string for XWSDK.
FOUNDATION_EXPORT const unsigned char XWSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XWSDK/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

@interface XWSDK : NSObject



+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) XWUserModel *currUser;


- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;


- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)alive:(XWRoleModel *)roleModel
   completion:(void(^)(XWUserModel *userModel))completion
      failure:(void(^)(NSString *errorMessage))failure;

- (void)open:(XWOrderModel *)order
   completion:(void(^)(NSString *orderId, NSString *url))completion
     failure:(void(^)(NSString *errorMessage))failure;

- (NSString *)version;

@end

NS_ASSUME_NONNULL_END

