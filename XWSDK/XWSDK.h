//
//  XWSDK.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <Foundation/Foundation.h>
#import <XWSDK/XWUserModel.h>
//! Project version number for XWSDK.
FOUNDATION_EXPORT double XWSDKVersionNumber;

//! Project version string for XWSDK.
FOUNDATION_EXPORT const unsigned char XWSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XWSDK/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

@interface XWSDK : NSObject



+ (instancetype)sharedInstance;


- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;


- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;
- (NSString *)version;

@end

NS_ASSUME_NONNULL_END

