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

typedef NS_ENUM(NSInteger, XWInfoType) {
    XWCreateOrderFail      = 1,    //创建订单失败
    XWDoesNotExistProduct  = 2,    //商品信息不存在
    XWUnknowFail           = 3,    //未知错误
    XWVerifyReceiptSucceed = 4,    //验证成功
    XWVerifyReceiptFail    = 5,    //验证失败
    XWURLFail              = 6     //未能连接苹果商店
};


typedef void (^LoginSuccessBack)(XWUserModel * _Nonnull user);
typedef void (^LogoutCallBack)(void);
typedef void (^ColseBack)(void);
typedef void (^InfoCallBack)(XWInfoType type);


NS_ASSUME_NONNULL_BEGIN



@interface XWSDK : NSObject



+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) XWUserModel *currUser;
@property (nonatomic, copy) LoginSuccessBack loginCallBack;
@property (nonatomic, copy) LogoutCallBack logoutCallBack;
@property (nonatomic, copy) ColseBack colseBack; //支付关闭回调
@property (nonatomic, copy) InfoCallBack infoCallBack; //支付成功相关


- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure;


- (void)login;

- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure;

- (void)alive:(XWRoleModel *)roleModel
   completion:(void(^)(XWUserModel *userModel))completion
      failure:(void(^)(NSString *errorMessage))failure;

- (void)open:(XWOrderModel *)order
   completion:(void(^)(NSString *orderId, NSString *url))completion
     failure:(void(^)(NSString *errorMessage))failure;

/**
 *  展示浮动按钮
 */
- (void)showFloatBtn;

/**
 *  隐藏浮动按钮
 */
- (void)disFloatBtn;

- (NSString *)version;


@end

NS_ASSUME_NONNULL_END

