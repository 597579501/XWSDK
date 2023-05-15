//
//  XWGwDomainServer.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import <Foundation/Foundation.h>
#import "XWBaseServer.h"
#import "XWOrderModel.h"
#import "XWSDKEnumHeader.h"

NS_ASSUME_NONNULL_BEGIN




@interface XWGwDomainServer : XWBaseServer

+ (NSURLSessionDataTask *)conf:(Success)success
                       failure:(Failure)failure;


+ (NSURLSessionDataTask *)sendCode:(NSString *)phone
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

+ (NSURLSessionDataTask *)update:(NSString *)name password:(NSString *)password newPassword:(NSString *)newPassword
                        success:(Success)success
                         failure:(Failure)failure;

+ (NSURLSessionDataTask *)resetPassword:(NSString *)phone newPassword:(NSString *)newPassword code:(NSString *)code
                                success:(Success)success
                                failure:(Failure)failure;

+ (NSURLSessionDataTask *)bind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
                        success:(Success)success
                       failure:(Failure)failure;

+ (NSURLSessionDataTask *)unBind:(NSString *)name password:(NSString *)password phone:(NSString *)phone code:(NSString *)code
                        success:(Success)success
                         failure:(Failure)failure;


+ (NSURLSessionDataTask *)idAuth:(NSString *)userId idNumber:(NSString *)idNumber realName:(NSString *)realName
                        success:(Success)success
                         failure:(Failure)failure;


+ (NSURLSessionDataTask *)open:(XWOrderModel *)order
                        success:(Success)success
                       failure:(Failure)failure;

+ (NSURLSessionDataTask *)cashi:(XWOrderModel *)order
                        success:(Success)success
                        failure:(Failure)failure;

+ (NSURLSessionDataTask *)check:(NSString *)orderId
                        receipt:(NSString *)receipt
                  transactionId:(NSString *)transactionId
                        success:(Success)success
                        failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
