//
//  XWSDKViewModel.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWViewModel.h"
#import "XWCommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWSDKViewModel : XWViewModel

@property (nonatomic, strong) NSString *appKey;


- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;


- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;
@end

NS_ASSUME_NONNULL_END
