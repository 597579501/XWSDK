//
//  XWOrderModel.h
//  XWSDK
//
//  Created by Seven on 2023/5/3.
//


#import "XWRoleModel.h"


typedef NS_ENUM(NSInteger, XWOpenType) {
    XWOpenAli = 6,
    XWOpenWX = 5,
    XWOpenI = 30,
};


NS_ASSUME_NONNULL_BEGIN

@interface XWOrderModel : XWRoleModel

@property (nonatomic ,strong) NSString *money;
@property (nonatomic ,strong) NSString *appOrderId;
@property (nonatomic ,strong) NSString *appData;
@property (nonatomic ,strong) NSString *desc;
@property (nonatomic ,assign) BOOL is5P;
@property (nonatomic ,assign) BOOL orderType;
@end

NS_ASSUME_NONNULL_END
