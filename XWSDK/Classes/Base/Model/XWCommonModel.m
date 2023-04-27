//
//  XWCommonModel.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWCommonModel.h"
#import <AdSupport/AdSupport.h>

static XWCommonModel *_instance = nil;

@implementation XWCommonModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"appId" : @"app_id"
    };
}

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist
{
    return @[@"appKey"];
}




/// 单利方法
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (NSString *)device
{
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    return idfa;
}

- (NSString *)tag1
{
    ///5个0+1
    return [NSString stringWithFormat:@"%@000001", self.appId];
}

- (NSString *)tag2
{
    return self.appId;
}

- (NSString *)tag3
{
    return @"1";
}

- (NSString *)tag4
{
    return @"";
}


- (NSString *)ver
{
    return @"1.0";
}

- (NSString *)time
{
    NSInteger timeInterval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%zd", timeInterval];
}

@end
