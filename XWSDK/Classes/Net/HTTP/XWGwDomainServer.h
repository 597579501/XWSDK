//
//  XWGwDomainServer.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import <Foundation/Foundation.h>
#import "XWBaseServer.h"


NS_ASSUME_NONNULL_BEGIN


/** 请求类型 */
typedef NS_ENUM(NSInteger, XWCodeType) {
    XWRegisterCode,
    XWResetCode,
    XWBindCode,
    XWUnbindCode
};

@interface XWGwDomainServer : XWBaseServer

+ (NSURLSessionDataTask *)conf:(Success)success
                       failure:(Failure)failure;


+ (NSURLSessionDataTask *)reg:(NSString *)name password:(NSString *)password code:(NSString *)code
                      success:(Success)success
                      failure:(Failure)failure;

+ (NSURLSessionDataTask *)login:(NSString *)name password:(NSString *)password 
                        success:(Success)success
                        failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
