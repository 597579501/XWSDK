//
//  XWUserModel.h
//  XWSDK
//
//  Created by Seven on 2023/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWUserModel : NSObject

///是否完成绑定手机
@property (nonatomic ,assign) NSInteger isBindphone;
///是否开启实名弹窗
@property (nonatomic ,assign) NSInteger isAdult;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *userPhone;
///是否完成实名
@property (nonatomic ,assign) NSInteger isIdauth;
@property (nonatomic ,assign) NSInteger idAuth;
///是否开启绑定手机弹窗
@property (nonatomic ,assign) NSInteger isPhonePop;
@property (nonatomic ,strong) NSString *userName;
///弹出公告数量
@property (nonatomic ,assign) NSInteger noticePopup;
///不弹窗公告数量（横幅公告）
@property (nonatomic ,assign) NSInteger noticeNoPopup;
@property (nonatomic ,strong) NSString *auditVersion;
@property (nonatomic ,assign) NSInteger remainingTime;
@property (nonatomic ,strong) NSString *sessionId;

@end


NS_ASSUME_NONNULL_END
