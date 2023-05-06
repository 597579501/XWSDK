
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeByNormal   = 1,             //账号密码登陆
    UserTypeByPhone    = 2,             //手机登陆
};

NS_ASSUME_NONNULL_BEGIN



@interface XWUserLoginRecordModel : NSObject

@property (nonatomic, assign) UserType userType;

@property (nonatomic, strong) NSString *accessToken;
/**
 *  用户令牌
 */
@property (nonatomic, strong) NSString *token;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *userId;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  密码
 */
@property (nonatomic, strong) NSString *password;

/**
 *  登陆时间
 */
@property (nonatomic, assign) long loginTime;


@end

NS_ASSUME_NONNULL_END
