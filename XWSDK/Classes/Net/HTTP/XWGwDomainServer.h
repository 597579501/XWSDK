//
//  XWGwDomainServer.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import <Foundation/Foundation.h>
#import "XWBaseServer.h"
#import "XWOrderModel.h"

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


+ (NSURLSessionDataTask *)XWSendCodeUrl:(NSString *)phone
                                   name:(NSString *)name
                               codeType:(XWCodeType)codeType
                                success:(Success)success
                                failure:(Failure)failure;

+ (NSURLSessionDataTask *)reg:(NSString *)name password:(NSString *)password code:(NSString *)code
                      success:(Success)success
                      failure:(Failure)failure;

+ (NSURLSessionDataTask *)login:(NSString *)name password:(NSString *)password 
                        success:(Success)success
                        failure:(Failure)failure;

+ (NSURLSessionDataTask *)idAuth:(NSString *)userId idNumber:(NSString *)idNumber realName:(NSString *)realName
                        success:(Success)success
                         failure:(Failure)failure;


+ (NSURLSessionDataTask *)open:(XWOrderModel *)order
                        success:(Success)success
                       failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END
