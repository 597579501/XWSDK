//
//  XWHttpResponse.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import <Foundation/Foundation.h>
/// 请求数据返回的状态码
typedef NS_ENUM(NSUInteger, XWHTTPResponseCode) {
    XWHTTPResponseCodeSuccess  = 0,                     /// 请求成功
    ErrorCode = 1
};


NS_ASSUME_NONNULL_BEGIN

@interface XWHttpResponse : NSObject

@property (nonatomic, readwrite, assign) BOOL success;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, readwrite, assign) XWHTTPResponseCode code;
@property (nonatomic, readwrite, assign) NSTimeInterval timestamp;
@property (nonatomic, readwrite, strong) id data;

+ (instancetype)response:(NSDictionary *)responseObject;

@end

NS_ASSUME_NONNULL_END
