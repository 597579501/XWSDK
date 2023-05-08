//
//  XWGwDomainServer.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWGwDomainServer.h"
#import "XWSDK.h"


NSString *const XWConfUrl = @"sdk/conf.php";
NSString *const XWRegisterUrl = @"user/register.php";
NSString *const XWLoginUrl = @"user/login.php";
NSString *const XWUpdateUrl = @"user/update.php";
NSString *const XWSendCodeUrl = @"user/send_code.php";
NSString *const XWIdAuthUrl = @"user/id_auth.php";
NSString *const XWOpenUrl = @"pay/open.php";



@implementation XWGwDomainServer

+ (NSString *)hostUrl
{
    return @"http://gw_gzdky.niiwe.com";
}

+ (NSURLSessionDataTask *)conf:(Success)success
                        failure:(Failure)failure
{
    
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWConfUrl];
    NSDictionary *params = @{@"os" : @"iOS",
                             @"pkg_name" : bundleId,
                             @"pkg_ver" : bundleVersion,
                             @"sdk_ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] postWithUrl:url parameters:params success:success failure:failure];
}




+ (NSURLSessionDataTask *)sendCode:(NSString *)phone
                              name:(NSString *)name
                          codeType:(XWCodeType)codeType
                           success:(Success)success
                           failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWRegisterUrl];
    
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSString *typeString = @"";
    if (codeType == XWRegisterCode)
    {
        typeString = @"register";
        name = phone;
    }
    else if (codeType == XWResetCode)
    {
        typeString = @"reset_passwd";
        name = phone;
    }
    else if (codeType == XWBindCode)
    {
        typeString = @"bind_phone";
    }
    else if (codeType == XWUnbindCode)
    {
        typeString = @"unbind_phone";
    }
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    NSDictionary *params = @{@"phone" : phone,
                             @"name" : name,
                             @"type" : typeString
    };
    
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] postWithUrl:url parameters:commonDictionary success:success failure:failure];
}

+ (NSURLSessionDataTask *)reg:(NSString *)name password:(NSString *)password code:(NSString *)code
                      success:(Success)success
                      failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWRegisterUrl];
    NSString *signPassword = [self md5HexDigest:[NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", password]];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    
    NSDictionary *params = @{@"name" : name,
                             @"passwd" : [self md5HexDigest:signPassword],
                             @"code" : code
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}


+ (NSURLSessionDataTask *)login:(NSString *)name password:(NSString *)password 
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWLoginUrl];
    NSString *signPassword = [self md5HexDigest:[NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", password]];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    
    NSString *token = [self md5HexDigest:[NSString stringWithFormat:@"%@%@%@%@",commonModel.appId, commonModel.appKey, signPassword, commonModel.time]];
    NSDictionary *params = @{@"name" : name,
                             @"token" : token
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}

+ (NSURLSessionDataTask *)update:(NSString *)name newPassword:(NSString *)newPassword code:(NSString *)code
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWUpdateUrl];
    NSString *signNewPassword = [self md5HexDigest:[NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", newPassword]];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    
//    NSString *token = [self md5HexDigest:[NSString stringWithFormat:@"%@%@%@%@",commonModel.appId, commonModel.appKey, signPassword, commonModel.time]];
    NSDictionary *params = @{@"type" : @"reset_passwd",
                             @"code" : code,
                             @"name" : name,
                             @"data" : signNewPassword,
                             @"notoken" : @""
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}


+ (NSURLSessionDataTask *)bind:(NSString *)name newPassword:(NSString *)newPassword code:(NSString *)code
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWUpdateUrl];
    NSString *signNewPassword = [self md5HexDigest:[NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", newPassword]];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    
//    NSString *token = [self md5HexDigest:[NSString stringWithFormat:@"%@%@%@%@",commonModel.appId, commonModel.appKey, signPassword, commonModel.time]];
    NSDictionary *params = @{@"type" : @"reset_passwd",
                             @"code" : code,
                             @"name" : name,
                             @"data" : signNewPassword,
                             @"notoken" : @""
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}


+ (NSURLSessionDataTask *)unBind:(NSString *)name newPassword:(NSString *)newPassword code:(NSString *)code
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWUpdateUrl];
    NSString *signNewPassword = [self md5HexDigest:[NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", newPassword]];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    
//    NSString *token = [self md5HexDigest:[NSString stringWithFormat:@"%@%@%@%@",commonModel.appId, commonModel.appKey, signPassword, commonModel.time]];
    NSDictionary *params = @{@"type" : @"reset_passwd",
                             @"code" : code,
                             @"name" : name,
                             @"data" : signNewPassword,
                             @"notoken" : @""
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}

+ (NSURLSessionDataTask *)idAuth:(NSString *)userId idNumber:(NSString *)idNumber realName:(NSString *)realName
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWIdAuthUrl];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    NSDictionary *params = @{@"idNumber" : idNumber,
                             @"realName" : realName,
                             @"userId" : userId
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}

+ (NSURLSessionDataTask *)open:(XWOrderModel *)order
                        success:(Success)success
                        failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWOpenUrl];
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    NSDictionary *params = @{@"user_id" : order.userId,
                             @"server_id" : order.serverId,
                             @"role_id" : order.roleId,
                             @"role_level" : order.roleLevel,
                             @"money" : order.money,
                             @"app_data" : order.appData,
                             @"app_order_id" : order.appOrderId,
                             @"pay_type" : order.payType,
                             @"desc" : order.desc,
                             @"is_h5_pay" : @"1",
                             @"order_type" : @"1",
                             @"user_coupon_id" : @"0",
                             @"use_platform_currency" : @"0",
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}



@end
