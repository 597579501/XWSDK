//
//  XWLogDomainServer.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import <Foundation/Foundation.h>
#import "XWBaseServer.h"
#import "XWRoleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWLogDomainServer : XWBaseServer

+ (NSURLSessionDataTask *)start:(Success)success
                        failure:(Failure)failure;

+ (NSURLSessionDataTask *)alive:(XWRoleModel *)roleModel
                      success:(Success)success
                        failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
