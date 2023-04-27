//
//  XWHttpResponse.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWHttpResponse.h"



NSString *const XWHTTPServiceResponseCodeKey = @"ret";
NSString *const XWHTTPServiceResponseMsgKey = @"msg";
NSString *const XWHTTPServiceResponseDataKey = @"data";


@interface XWHttpResponse ()



@end

@implementation XWHttpResponse

+ (instancetype)response:(NSDictionary *)responseObject
{
    return [[XWHttpResponse alloc] initWithResponseObject:responseObject];
}

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject
{
    if (self = [super init]) {
        self.code = [responseObject[XWHTTPServiceResponseCodeKey] integerValue];
        self.success = (self.code == XWHTTPResponseCodeSuccess ? YES : NO);
        self.data = responseObject[XWHTTPServiceResponseDataKey];
        self.msg = responseObject[XWHTTPServiceResponseMsgKey];
    }
    return self;
}

@end
