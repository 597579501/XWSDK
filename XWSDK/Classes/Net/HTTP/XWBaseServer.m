//
//  XWAuthServer.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWBaseServer.h"
#import <CommonCrypto/CommonDigest.h>
#import "XWCommonModel.h"
#import "XWSDK.h"
@implementation XWBaseServer


+ (NSString *)signWithParams:(NSMutableDictionary *)params
{
 
    NSString *appKey = params[@"appKey"];
    
    [params removeObjectForKey:@"appKey"];
    
    NSArray *keyArray = [params allKeys];
    keyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    
    NSMutableString *string = [[NSMutableString alloc] init];
    
    for (NSString *key in keyArray) {
//        [string appendString:key];
//        [string appendString:@"="];
        NSString *value = params[key];
        if (value)
        {
            [string appendString:value];
//            if (![keyArray.lastObject isEqual:key]) {
//                [string appendString:@"&"];
//            }
        }
    }
    
//    NSString *paramSignature = [string stringByAppendingString:SWApiRequestSalt];
    return [self md5HexDigest:[NSString stringWithFormat:@"%@%@", string, appKey]];
    
}


+ (NSString *)md5HexDigest:(NSString *)input
{
//    const char* str = [input UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, (CC_LONG)strlen(str), result);
//    NSMutableString* ret = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH*2];
//    for(int i=0; i< CC_MD5_DIGEST_LENGTH; i++){
//        [ret appendFormat:@"%2s", result];
//    }
//    return ret;
    
    const char *cStr = input.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
    
}



@end
