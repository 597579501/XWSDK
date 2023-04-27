//
//  XWNetManager.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWNetManager.h"
#import "XWHttpResponse.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <YYModel/YYModel.h>


NSInteger const XWHTTPServiceTimeoutInterval = 30;

@interface XWNetManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation XWNetManager

+ (XWNetManager *)sharedInstance;
{
    static XWNetManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.completionQueue = [self completionQueue];
        
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy = securityPolicy;
        
        
        [self setupRequestSerializerWithManager:_manager contentType:HttpContentTypeFrom timeoutInterval:XWHTTPServiceTimeoutInterval];
        [self setupResponseSerializerWithManager:_manager];
        [_manager setTaskDidFinishCollectingMetricsBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLSessionTaskMetrics * _Nullable metrics) {
//            SWLogInfo(@"metrics %@", metrics);
        }];
    }
    return _manager;
}

/** 设置请求解析器 */
- (void)setupRequestSerializerWithManager:(AFHTTPSessionManager *)sessionManager contentType:(HttpContentType)contentType timeoutInterval:(NSTimeInterval)timeoutInterval
{
    AFHTTPRequestSerializer *requestSerializer = nil;
    // 请求序列化设置
    if (contentType == HttpContentTypeFrom) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    } else if (contentType == HttpContentTypeJson) {
        requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    } else if(contentType == HttpContentTypeStream) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    }
  
    /// 调整UA
//    NSString *userAgent = [requestSerializer valueForHTTPHeaderField:@"User-Agent"];
//    userAgent = _Tf(@"%@-%@_%@_%@_%@_%@_%@", userAgent, @"iOS", [SWDevice device_model], [SWDevice device_system], [SWDevice app_display_name], [SWDevice app_version], [SWDevice api_version_num]);
//    SWLogInfo(@"+++++++++++++UserAgent : %@", userAgent);
//    [requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
  
    // 禁用cookie
    requestSerializer.HTTPShouldHandleCookies = NO;
    // 默认超时时间
    [requestSerializer setTimeoutInterval:timeoutInterval];
    // 禁用本地缓存
    requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    sessionManager.requestSerializer = requestSerializer;
}


/** 设置响应解析器 */
- (void)setupResponseSerializerWithManager:(AFHTTPSessionManager *)sessionManager {
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    // 设置接受类型(为了添加 @"text/html", @"text/plain" @"image...")
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/tiff", @"image/jpeg", @"image/gif", @"image/png", @"image/ico", @"image/x-icon", @"image/bmp", @"image/x-bmp", @"image/x-xbitmap", @"image/x-win-bitmap", nil];
    sessionManager.responseSerializer = responseSerializer;
}


- (dispatch_queue_t)completionQueue {
    static dispatch_queue_t _completionQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _completionQueue = dispatch_queue_create("com.XWSDK", DISPATCH_QUEUE_SERIAL);
    });
    return _completionQueue;
}

/** 证书鉴权 */
- (void)setupSessionTrustWithManager:(AFHTTPSessionManager *)sessionManager {
    
}

/** 设置请求头 */
//- (void)setupHeaderField:(AFHTTPSessionManager *)sessionManager {
//    [self customHeaderField:sessionManager];
//}

//- (void)setupHeaderField:(AFHTTPSessionManager *)sessionManager params:(id)params
//{
//    // 请求头设置
//    NSDictionary *headerParams = [SWDevice device_info];
//    for (NSString *itemKey in [headerParams allKeys]) {
//        NSString *itemValue = [headerParams objectForKey:itemKey];
//        [sessionManager.requestSerializer setValue:itemValue forHTTPHeaderField:itemKey];
//    }
//
//    NSString *timestamp = params[@"timestamp"];
//
//    NSString *token = [SWUserManager sharedInstance].userInfo.token;
//
//    if (SWStringIsNotEmpty(token) && SWStringIsNotEmpty(timestamp)) {
//        NSString *signature = [self signatureWithToken:token timestamp:timestamp];
//        [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//        [sessionManager.requestSerializer setValue:signature forHTTPHeaderField:@"token-signature"];
//    }
//
//    if (timestamp) {
//        [sessionManager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
//    }
//    NSString *signParam = [self signatureWithParams:params];
//    [sessionManager.requestSerializer setValue:signParam forHTTPHeaderField:@"param-signature"];
//
//}
//
//- (NSDictionary *) requestHeadersWithParams:(id)params
//{
//    // 请求头设置
//    NSMutableDictionary *headerParams = [NSMutableDictionary dictionaryWithDictionary:[SWDevice device_info]];
//
//    NSString *timestamp = params[@"timestamp"];
//
//    NSString *token = [SWUserManager sharedInstance].userInfo.token;
//    //TODO后台header设置有改动，还需修改
//    if (SWStringIsNotEmpty(token) && SWStringIsNotEmpty(timestamp)) {
//        NSString *signature = [self signatureWithToken:token timestamp:timestamp];
//        [headerParams setObject:token forKey:@"token"];
//        [headerParams setObject:signature forKey:@"token-signature"];
//    }
//
//    if (timestamp) {
//        [headerParams setObject:timestamp forKey:@"timestamp"];
//    }
//    NSString *signParam = [self signatureWithParams:params];
//    [headerParams setObject:signParam forKey:@"param-signature"];
//    return [headerParams copy];
//}

- (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                           parameters:(id)params
                              success:(Success)success
                              failure:(Failure)failure
{
    return [self sendRequestWithUrl:url httpType:HTTPTypePOST parameters:params paramsType:HttpParamTypeBody httpHeaderparameters:nil requestEncrypt:nil responseEncrypt:nil success:success failure:failure];;
}

- (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                          parameters:(id)params
                             success:(Success)success
                             failure:(Failure)failure
{
    return [self sendRequestWithUrl:url httpType:HTTPTypeGET parameters:params paramsType:HttpParamTypePath httpHeaderparameters:nil requestEncrypt:nil responseEncrypt:nil success:success failure:failure];
}




- (NSURLSessionDataTask *)sendRequestWithUrl:(NSString *)url
                                    httpType:(HTTPType)httpType
                                  parameters:(id)params
                                  paramsType:(HttpParamType)paramsType
                        httpHeaderparameters:(NSDictionary *)headerParams
                              requestEncrypt:(XWEncryptType (^)(void))requestEncrypt
                             responseEncrypt:(XWEncryptType (^)(void))responseEncrypt
                                     success:(Success)success
                                     failure:(Failure)failure
{
    
    
    AFHTTPSessionManager *manager = [XWNetManager sharedInstance].manager;
    NSString *urlI = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@""].invertedSet];
    NSMutableDictionary *finalParams = [NSMutableDictionary dictionaryWithDictionary:params];
//    finalParams[@"timestamp"] = [self getCurrentTime];
    // 请求参数加密 TODO
//    [self setupHeaderField:manager params:finalParams];
//    NSDictionary *headers = [self requestHeadersWithParams:finalParams];
    NSDictionary *headers = @{};
//    NSLog(@"headers %@", headers);
    NSLog(@"sendRequestWithUrl %@", url);
    NSLog(@"params %@", finalParams);
    
    /// 每次请求接口，都要检测IP是否变化
//    [self checkIPAddressChanged];
  
    // GET请求
    if (httpType == HTTPTypeGET)
    {
        return [manager GET:urlI parameters:finalParams headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successBlockMethod:success failure:failure task:task responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self errorBlockMethod:failure task:task error:error];
        }];
        
    }
    else
    {
        return [manager POST:urlI parameters:finalParams headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successBlockMethod:success failure:failure task:task responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self errorBlockMethod:failure task:task error:error];
        }];
    }
    
}

- (void)successBlockMethod:(Success)success failure:(Failure)failure task:(NSURLSessionDataTask *)task responseObject:(id)responseObject
{
    NSLog(@"successBlockMethod %@", [responseObject yy_modelToJSONString]);
    XWHttpResponse *response = [XWHttpResponse response:responseObject];
    if (response.success)
    {
        if (success)
        {
            id data = response.data;
            dispatch_async(dispatch_get_main_queue(), ^{
                success(data);
            });
        }
    }
    else
    {
        if (failure)
        {
            NSString *errorMessage = [self parsedSuccesWithError:response];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(errorMessage);
            });
            
        }
    }
}

- (void)errorBlockMethod:(Failure)failure task:(NSURLSessionDataTask *)task error:(NSError *)error
{
    NSString *errorMessage = @"网络异常，请检查网络";
    if (failure) {
        failure(errorMessage);
    }
}

- (NSString *)parsedSuccesWithError:(XWHttpResponse *)response
{
    NSString *errorMessage = response.msg;
    return errorMessage;
}

@end
