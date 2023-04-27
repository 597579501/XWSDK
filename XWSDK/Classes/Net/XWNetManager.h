//
//  XWNet.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>


FOUNDATION_EXTERN NSInteger const XWHTTPServiceTimeoutInterval;

/** 请求类型 */
typedef NS_ENUM(NSInteger, HTTPType) {
    HTTPTypeGET,
    HTTPTypePOST
};

typedef NS_ENUM(NSInteger, XWEncryptType) {
    XWEncryptTypeNone,
    XWEncryptTypeRSA,
    XWEncryptTypeAES,
};

typedef NS_ENUM(NSInteger, HttpParamType) {
    HttpParamTypeBody,
    HttpParamTypeQuery,
    HttpParamTypePath,
};
/** Content-Type类型 */
typedef enum : NSUInteger {
    HttpContentTypeFrom,        //application/x-www-form-urlencoded
    HttpContentTypeJson,        //application/json
    HttpContentTypeStream,      //application/octet-stream
} HttpContentType;


typedef void(^Success)(id data);
typedef void(^ResponseSuccess)(id data,NSString *msg);

typedef void(^Failure)(NSString *errorMessage);


NS_ASSUME_NONNULL_BEGIN

@interface XWNetManager : NSObject

+ (XWNetManager *)sharedInstance;
+ (void)s;

- (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                           parameters:(id)params
                              success:(Success)success
                              failure:(Failure)failure;

- (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                          parameters:(id)params
                             success:(Success)success
                             failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
