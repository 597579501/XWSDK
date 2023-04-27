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
    NSString *bundleShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  
    
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWConfUrl];
    NSDictionary *params = @{@"os" : @"iOS",
                             @"pkg_name" : bundleId,
                             @"pkg_ver" : bundleVersion,
                             @"sdk_ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] postWithUrl:url parameters:params success:success failure:failure];
}




+ (NSURLSessionDataTask *)XWSendCodeUrl:(NSString *)phone
                               codeType:(XWCodeType)codeType
                                success:(Success)success
                                failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWRegisterUrl];
    
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *bundleShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  
    
    
    NSDictionary *params = @{@"os" : @"iOS",
                             @"pkg_name" : bundleId,
                             @"pkg_ver" : bundleVersion,
                             @"sdk_ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] postWithUrl:url parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)reg:(NSString *)name password:(NSString *)password code:(NSString *)code
                      success:(Success)success
                      failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWRegisterUrl];

    
  
    NSString *signPassword = [NSString stringWithFormat:@"%@346c2844386d77463ae227063f2c2b9e", password];
    
    
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel yy_modelToJSONObject];
    
    NSDictionary *params = @{@"name" : name,
                             @"passwd" : [self md5HexDigest:signPassword],
                             @"code" : code
    };
    [commonDictionary addEntriesFromDictionary:params];
   
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}


+ (NSURLSessionDataTask *)conf1:(Success)success
                        failure:(Failure)failure
{
    
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *bundleShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  
    
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWConfUrl];
    NSDictionary *params = @{@"os" : @"iOS",
                             @"pkg_name" : bundleId,
                             @"pkg_ver" : bundleVersion,
                             @"sdk_ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] postWithUrl:url parameters:params success:success failure:failure];
}

@end
