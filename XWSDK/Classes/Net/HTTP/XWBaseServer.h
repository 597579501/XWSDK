//
//  XWAuthServer.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <Foundation/Foundation.h>
#import "XWNetManager.h"
#import "XWCommonModel.h"
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface XWBaseServer : NSObject



+ (NSString *)baseUrl;
+ (NSString *)md5HexDigest:(NSString *)input;
+ (NSString *)signWithParams:(NSMutableDictionary *)params;

@end

NS_ASSUME_NONNULL_END
