//
//  XWSDK.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWSDK.h"
#import "XWNetManager.h"
#import "XWGwDomainServer.h"
#import "XWApiDomainServer.h"
#import "XWSDKViewModel.h"
#import "XWCommonModel.h"
#import "XWFloatWindow.h"
#import "XWSDKHeader.h"
#import "XWAutoLoginViewController.h"
#import "XWUserLoginRecordModel.h"
#import "XWDBHelper.h"
#import "XWUserLoginViewController.h"
#import "XWUserCenterViewController.h"
#import "XWUIHelper.h"

static XWSDK *_instance = nil;

//
@interface XWSDK ()

@property (nonatomic, strong) XWSDKViewModel *sdkViewModel;
@property (nonatomic, strong) XWCommonModel *commonModel;
@property (nonatomic, strong) XWFloatWindow *floatWindow;
@property (nonatomic, assign) BOOL          canShowController;
@end

@implementation XWSDK

/// 单利方法
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:_instance selector:@selector(loginSuccessNotification:) name:@"InfoNotification" object:nil];
    });
    return _instance;
}



- (void)conf:(NSString *)appId appKey:(NSString *)appKey completion:(void(^)(void))completion failure:(void(^)(NSString *errorMessage))failure
{
    WS(weakSelf);
    [self.sdkViewModel conf:appId appKey:appKey completion:^(XWConfModel * _Nonnull confModel) {
        NSMutableArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"XS_SDK_PassWord_Update", @"XS_SDK_Account_Bind", @"XS_SDK_Account_Logout", nil];
        NSMutableArray *menuNameArray = [[NSMutableArray alloc] initWithObjects:@"修改密码", @"绑定手机", @"注销", nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:menuNameArray forKeys:imageArray];
        [self initWindow:dictionary];
    } failure:^(NSString * _Nonnull errorMessage) {
        
    }];
}

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code completion:(void(^)(NSString *userId))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel reg:name password:password code:code completion:^(NSString * _Nonnull userId) {
        if(completion)
        {
            completion(userId);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)login:(NSString *)name password:(NSString *)password completion:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel login:name password:password completion:^(XWUserModel *userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}



- (void)login
{
    [self loginSucessCallBack:_loginCallBack];
//    [self.sdkViewModel login:name password:password completion:^(XWUserModel * _Nonnull userModel) {
//        if(completion)
//        {
//            completion(userModel);
//        }
//    } failure:^(NSString * _Nonnull errorMessage) {
//        if (failure)
//        {
//            failure(errorMessage);
//        }
//    }];
}

- (void)loginSucessCallBack:(LoginSuccessBack)callBack{
    
//    if (!self.aInitResponeModel) {
//        return;
//    }
    
    NSNumber *aotuLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"];
    
    if (aotuLogin)
    {
        
        __block BOOL isLogin = YES;
        UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
        XWAutoLoginViewController *autoLoginViewController = [XWAutoLoginViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:autoLoginViewController];
        [rootcontroller addChildViewController:navigationController];
        [rootcontroller.view addSubview:navigationController.view];
        
        XWUserLoginRecordModel *userLoginRecordModel = [self.sdkViewModel getUserInformation];
        
        

        if (userLoginRecordModel) {
            
        }
        else
        {
            userLoginRecordModel = [[XWDBHelper sharedDBHelper] getLastLoginUser];
        }

        
        [[[autoLoginViewController autoLoginView] usernameLabel] setText:[NSString stringWithFormat:@"正在登陆：%@",userLoginRecordModel.username]];
        [[[autoLoginViewController autoLoginView] cancelButton] setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            isLogin = false;
            [autoLoginViewController closeView];
            self -> _currUser = nil;
//            _role = nil;
            [self.floatWindow dissmissWindow];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAotuLogin];
            [[XWSDK sharedInstance] login];
        }];



        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (isLogin) {
                
                
                [self.sdkViewModel login:userLoginRecordModel.username password:userLoginRecordModel.password completion:^(XWUserModel * _Nonnull userModel) {
                    [autoLoginViewController closeView];
                } failure:^(NSString * _Nonnull errorMessage) {
                    
                    [autoLoginViewController closeView];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAotuLogin];
                    [[XWSDK sharedInstance] login];

                    [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:errorMessage];
                }];
                
//                [DHUserSystemManager login:userLoginRecordModel.username passWord:userLoginRecordModel.password phoneNumber:@"" verifyCode:@"" type:userLoginRecordModel.userType success:^(DHUserResponeModel *userResponeModel) {
//                    //                    [DHHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject] text:@"登陆成功"];
//                    [autoLoginViewController closeView];
//
//
//                    //调用了一次· 备注·
////                    DHUser *user = [DHUser new];
////                    user.accessToken = userResponeModel.accessToken;
////                    user.username = userResponeModel.username;
////                    user.userId = userResponeModel.userId;
////
////                    NSInteger loginType = userLoginRecordModel.userType;
////
////                    if (callBack) {
////                        callBack(user, (DHLSS)loginType);
////                    }
////
//
//
//                } failure:^(int errcode, NSString *errorMessage) {
//                    if (errcode == 3002)
//                    {
//
//                    }
//                    [autoLoginViewController closeView];
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAotuLogin];
//                    [dhsdk login];
//
//                    [DHHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject] text:errorMessage];
//
//                }];
            }
        });
    }
    else
    {
        
        UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
        XWUserLoginViewController *userLoginViewController = [XWUserLoginViewController new];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userLoginViewController];
        [rootcontroller addChildViewController:navigationController];
        [rootcontroller.view addSubview:navigationController.view];
        
        _loginCallBack = callBack;
    }
}


- (void)start:(void(^)(XWUserModel *userModel))completion failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel start:^(XWUserModel * _Nonnull userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}

- (void)alive:(XWRoleModel *)roleModel
   completion:(void(^)(XWUserModel *userModel))completion
      failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel alive:roleModel completion:^(XWUserModel * _Nonnull userModel) {
        if(completion)
        {
            completion(userModel);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];

}


- (void)open:(XWOrderModel *)order
   completion:(void(^)(NSString *orderId, NSString *url))completion
      failure:(void(^)(NSString *errorMessage))failure
{
    [self.sdkViewModel open:order completion:^(NSString *orderId, NSString *url) {
        if(completion)
        {
            completion(orderId, url);
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        if (failure)
        {
            failure(errorMessage);
        }
    }];
}


- (void)initWindow:(NSDictionary *)dictionary
{
    _canShowController = YES;
    WS(weakSelf);
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIImage *image = [UIImage imageNamed:@"XW_SDK_FloatWindow"];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
    [image drawInRect:rect];
    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIColor *floatWindowBGcolor = [UIColor colorWithPatternImage:lastImage];
    
    if (!_floatWindow)
    {
        _floatWindow = [[XWFloatWindow alloc] initWithFrame:rect mainImageName:@"XW_SDK_FloatIcon"
                                                  imagesAndTitle:dictionary
                                                         bgcolor:floatWindowBGcolor
                                                  animationColor:[UIColor clearColor]] ;
        [_floatWindow dissmissWindow];
        _floatWindow.clickBolcks = ^(NSInteger i){
            if (weakSelf.canShowController) {
                [weakSelf userCenter];
            }
        };
    }
}



/**
 *  用户中心
 */
- (void)userCenter{
    
    if (_currUser != nil)
    {
        [self.floatWindow dissmissWindow];
        
        UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
        XWUserCenterViewController *userCenterViewController = [XWUserCenterViewController new];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userCenterViewController];
        [rootcontroller addChildViewController:navigationController];
        [rootcontroller.view addSubview:navigationController.view];
        [userCenterViewController setCloseButtonClickBlock:^{
            if (_currUser != nil)
            {
                [self.floatWindow showWindow];
            }
        }];
    }
    else
    {
        [XWUIHelper showAlertView:nil message:@"用户未登陆" cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }
    
}

- (void)loginSuccessNotification:(NSNotification *)notification
{
    //登陆成功过移除标识
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLogin"];
    XWUserModel *user = (XWUserModel *)notification.object;
    [self.floatWindow showWindow];
    _currUser = user;
    if (_loginCallBack) {
        //        if (lSS == MKLSBL) {
        //            [reyun setLoginWithAccountID:user.userId andGender:o andage:@"" andServerId:@"" andlevel:0 andRole:@""];
        //            [TrackingIO setLoginWithAccountID:user.userId];
        //        }
        //        else if (lSS == MKLSBR)
        //        {
        //            [reyun setRegisterWithAccountID:user.userId andGender:o andage:@"" andServerId:@"" andAccountType:@"" andRole:@""];
        //            [TrackingIO setRegisterWithAccountID:user.userId];
        //        }
        [self showFloatBtn];
        _loginCallBack(user);
    }
    
}

- (void)showFloatBtn
{
    [self.floatWindow showWindow];
}

- (void)disFloatBtn
{
    [self.floatWindow dissmissWindow];
}



- (NSString *)version
{
    return @"1.0.0";
}



- (XWSDKViewModel *)sdkViewModel
{
    if (!_sdkViewModel)
    {
        _sdkViewModel = [[XWSDKViewModel alloc] init];
    }
    return _sdkViewModel;
}


@end
