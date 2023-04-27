//
//  XWConfModel.h
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//


#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface XWConfModel : NSObject

///是否开启自动注册
@property (nonatomic, assign) BOOL auto_register;
///是否关闭注册
@property (nonatomic, assign) BOOL close_register;
///关闭注册提示
@property (nonatomic, strong) NSString *close_register_tip;
///红包开关
@property (nonatomic, assign) BOOL *activity_state;
///头条开关
@property (nonatomic, assign) BOOL *toutiao_open;
@property (nonatomic, strong) NSString *toutiao_appname;
@property (nonatomic, strong) NSString *toutiao_channel;
@property (nonatomic, strong) NSString *toutiao_aid;


@end

NS_ASSUME_NONNULL_END
