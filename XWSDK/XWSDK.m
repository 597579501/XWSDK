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
#import "XWWebViewController.h"
#import "XWStore.h"




static XWSDK *_instance = nil;


@interface XWSDK ()

@property (nonatomic, strong) XWSDKViewModel *sdkViewModel;
@property (nonatomic, strong) XWCommonModel *commonModel;
@property (nonatomic, strong) XWFloatWindow *floatWindow;
@property (nonatomic, assign) BOOL          canShowController;
@property (nonatomic, strong) XWUserModel *currUser;
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
        if (completion)
        {
            completion();
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
}

- (void)logoutAccount
{
    [self logoutAccountCallBack:_logoutCallBack];
}

- (void)logoutAccountCallBack:(LogoutCallBack )callBack{
    
  
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAotuLogin];
    [self.floatWindow dissmissWindow];
    _instance.currUser = nil;
    if (callBack) {
        callBack();
    }
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
            _instance.currUser = nil;
//            _role = nil;
            [self.floatWindow dissmissWindow];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAotuLogin];
            [[XWSDK sharedInstance] login];
        }];



        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

- (void)showIdAuth:(XWUserModel *)user
{
    if (!user.isIdauth)
    {
        
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
    WS(weakSelf);
    
    XWProgressHUD *hud = [XWHUD showHUD:[[UIApplication sharedApplication] windows].firstObject];
    
    [self.sdkViewModel cashier:order completion:^(NSString * _Nonnull orderId, NSString * _Nonnull url) {
            
    } failure:^(NSString * _Nonnull errorMessage) {
        
    }];
    
    [self.sdkViewModel open:order completion:^(NSString *state, NSString *orderId, NSString *url) {
        if ([state isEqualToString:@"success"])
        {
            NSString *productIdString = url;
            NSSet *productsList = [NSSet setWithArray:@[productIdString]];
            [[XWStore defaultStore] requestProducts:productsList success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
                SKProduct *skProduct = nil;
                if (products.count > 0)
                {
                    skProduct = products[0];
                    NSLog(@"weewlocalizedDescription----%@",skProduct.localizedDescription);
                    NSLog(@"weewlocalizedTitle----%@",skProduct.localizedTitle);
                    NSLog(@"weewNSDecimalNumber----%@",skProduct.price);
                    NSLog(@"weewproductIdentifier----%@",skProduct.productIdentifier);
                    
                    
                    [[XWStore defaultStore] addPayment:productIdString success:^(SKPaymentTransaction *transaction) {
                        NSString *transactionID = transaction.transactionIdentifier;
                        NSLog(@"transactionIdentifier----%@",transaction.transactionIdentifier);
                        //这里orderId为请求返回的sdkXXXXXXXX的不是CP传值进来的
                        NSURL *url = [[NSBundle mainBundle] appStoreReceiptURL];
                        NSData *receiptData = [NSData dataWithContentsOfURL:url];
                        NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                        [weakSelf.sdkViewModel check:orderId receipt:encodeStr transactionId:transactionID completion:^(NSString * _Nonnull orderId) {
                            [XWHUD hideHUD:hud];
                            [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"支付成功"];
                        } failure:^(NSString * _Nonnull errorMessage) {
                            [XWHUD hideHUD:hud];
                            [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:errorMessage];
                        }];
                    } failure:^(SKPaymentTransaction *transaction, NSError *error) {
                        [XWHUD hideHUD:hud];
                        [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:error.localizedDescription];
//                        if (SDHSDK.dhInfoCallBack) {
//                            SDHSDK.dhInfoCallBack(DHZURLFail);
//                        }
                    }];
                }
                else
                {
                    [XWHUD hideHUD:hud];
                    [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"商品信息不存在"];
//                    if (SDHSDK.dhInfoCallBack) {
//                        SDHSDK.dhInfoCallBack(DHZDoesNotExistProduct);
//                    }
                }
            } failure:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [XWHUD hideHUD:hud];
                    [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"未知错误"];
                });
            }];
        }
        else
        {
            
            [XWHUD hideHUD:hud];
//            [weakSelf.floatWindow dissmissWindow];
            UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
            
            XWWebViewController *webViewController = nil;
            
            webViewController = [[XWWebViewController alloc] initWithURL:@"http://gw_gzdky.niiwe.com/pay/cashier.php"];
            [webViewController setOrder:order];
            [webViewController setIsOpen:YES];
            [webViewController setIsCanShowBack:NO];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
            navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
            [rootcontroller presentViewController:navigationController animated:YES completion:^{
                
            }];
            [webViewController setCloseButtonClickBlock:^{
                [weakSelf.floatWindow showWindow];
//                if (XWHSDK.dhColseBack) {
//                    XWHSDK.dhColseBack();
//                }
            }];
            
//            if(url)
//            {
//
////                [XWHUD hideHUD:hud];
////                [weakSelf.floatWindow dissmissWindow];
////                UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
////
////                XWWebViewController *webViewController = nil;
////
////                webViewController = [[XWWebViewController alloc] initWithURL:url];
////
////                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
////                [webViewController setIsPay:YES];
////                [webViewController setIsCanShowBack:NO];
////
////                [rootcontroller presentViewController:navigationController animated:YES completion:^{
////
////                }];
////                [webViewController setCloseButtonClickBlock:^{
////                    [weakSelf.floatWindow showWindow];
////    //                if (XWHSDK.dhColseBack) {
////    //                    XWHSDK.dhColseBack();
////    //                }
////                }];
//    //            completion(orderId, url);
//
//            }
//            else
//            {
//                [XWHUD hideHUD:hud];
//                [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"获取订单失败"];
//                [weakSelf.floatWindow showWindow];
//    //            if (SDHSDK.dhInfoCallBack) {
//    //                SDHSDK.dhInfoCallBack(DHZCreateOrderFail);
//    //            }
//            }
        }
    } failure:^(NSString * _Nonnull errorMessage) {
        [XWHUD hideHUD:hud];
        [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:errorMessage];
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
    
    if (_instance.currUser != nil)
    {
        [self.floatWindow dissmissWindow];
        
        UIViewController *rootcontroller = [[[UIApplication sharedApplication] windows].firstObject rootViewController];
        XWUserCenterViewController *userCenterViewController = [XWUserCenterViewController new];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userCenterViewController];
        [rootcontroller addChildViewController:navigationController];
        [rootcontroller.view addSubview:navigationController.view];
        [userCenterViewController setCloseButtonClickBlock:^{
            if (_instance.currUser != nil)
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
    _instance.currUser = user;
    [self showIdAuth:user];
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
        
        [[XWSDK sharedInstance] start:^(XWUserModel * _Nonnull userModel) {
            
        } failure:^(NSString * _Nonnull errorMessage) {
        }];
        
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
    return @"1.0.1";
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
