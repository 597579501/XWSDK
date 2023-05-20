//
//  XWLogDomainServer.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//


#import "XWSDK.h"
#import "XWLogDomainServer.h"
#import "XWCommonModel.h"
#import <AdSupport/AdSupport.h>


NSString *const XWStartUrl = @"log/iosstart.php";
NSString *const XWAliveUrl = @"user/alive.php";


@implementation XWLogDomainServer

+ (NSString *)hostUrl
{
    return @"http://log_gzdky.niiwe.com";
}

+ (NSURLSessionDataTask *)start:(Success)success
                        failure:(Failure)failure
{
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *system = @"iOS";
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *systemName = [[UIDevice currentDevice] systemName];
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *bundleShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *sdkVersion = [[XWSDK sharedInstance] version];
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *mac = @"00:00:00:00:00:00";
    
    NSString *data = [NSString stringWithFormat:@"start|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",
                       commonModel.tag1, commonModel.tag2, commonModel.tag3, commonModel.tag4,
                       uuid, system, systemVersion, systemName, bundleId, bundleVersion, bundleShortVersion,
                      sdkVersion, idfa, idfv, mac];
          
    
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWStartUrl];
    NSDictionary *params = @{@"data" : data,
                             @"ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:params success:success failure:failure];
}



+ (NSURLSessionDataTask *)sd:(NSString *)userId
                        success:(Success)success
                        failure:(Failure)failure
{
    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *system = @"iOS";
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *systemName = [[UIDevice currentDevice] systemName];
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *bundleShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *sdkVersion = [[XWSDK sharedInstance] version];
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *mac = @"00:00:00:00:00:00";
    
    NSString *data = [NSString stringWithFormat:@"start|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",
                       commonModel.tag1, commonModel.tag2, commonModel.tag3, commonModel.tag4,
                       uuid, system, systemVersion, systemName, bundleId, bundleVersion, bundleShortVersion,
                      sdkVersion, idfa, idfv, mac];
          
    
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWAliveUrl];
    NSDictionary *params = @{@"data" : data,
                             @"ver" : [[XWSDK sharedInstance] version]
    };
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:params success:success failure:failure];
}


+ (NSURLSessionDataTask *)alive:(XWRoleModel *)roleModel
                      success:(Success)success
                      failure:(Failure)failure
{
    NSString *url = [[self hostUrl] stringByAppendingFormat:@"/%@", XWAliveUrl];
    

    XWCommonModel *commonModel = [XWCommonModel sharedInstance];
    NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
    NSString *userId = [XWSDK sharedInstance].currUser.userId;
    NSDictionary *params = @{@"user_id" : userId ? userId : @"",
                             @"server_id" : roleModel.serverId ? roleModel.serverId : @"",
                             @"server_name" : roleModel.serverName ? roleModel.serverName : @"",
                             @"role_id" : roleModel.roleId ? roleModel.roleId : @"",
                             @"role_name" : roleModel.roleName ? roleModel.roleName : @"",
                             @"role_level" : roleModel.roleLevel ? roleModel.roleLevel : @"",
    };
    [commonDictionary addEntriesFromDictionary:params];
    NSString *signString = [self signWithParams:commonDictionary];
    [commonDictionary setObject:signString forKey:@"sign"];
    return [[XWNetManager sharedInstance] getWithUrl:url parameters:commonDictionary success:success failure:failure];
}


@end
