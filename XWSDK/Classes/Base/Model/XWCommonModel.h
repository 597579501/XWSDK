//
//  XWCommonModel.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWCommonModel : XWModel

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *tag1;
@property (nonatomic, strong) NSString *tag2;
@property (nonatomic, strong) NSString *tag3;
@property (nonatomic, strong) NSString *tag4;
///接口版本
@property (nonatomic, strong) NSString *ver;
@property (nonatomic, strong) NSString *time;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
