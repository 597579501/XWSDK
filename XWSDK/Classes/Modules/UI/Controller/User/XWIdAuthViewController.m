////
////  XWIdAuthViewController.m
////  XWSDK
////
////  Created by Seven on 2023/5/15.
////
//
//#import "XWIdAuthViewController.h"
////#import "XWWebViewController.h"
//#import "XWUserRegisterView.h"
////#import "XWUserSystemManager.h"
//#import "XWHelper.h"
//#import "XWPhoneLoginViewController.h"
//
//@interface XWIdAuthViewController ()
//
//@end
//
//@implementation XWIdAuthViewController
//
//
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _userRegisterView = [XWUserRegisterView new];
//    }
//    return self;
//}
//
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    WS(weakSelf);
//    
//    
//    [self.view addSubview:_userRegisterView];
//    [_userRegisterView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
//        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
//    }];
//    
//    
//    [_userRegisterView setBackButtonClickBlock:^{
//        [weakSelf.navigationController popViewControllerAnimated:NO];
//    }];
//    
//    
//    [_userRegisterView setSubmitButtonClickBlock:^{
//        [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
//        [weakSelf.userRegisterView.usernameTextField resignFirstResponder];
//        [weakSelf.userRegisterView.passwordTextField resignFirstResponder];
//        [weakSelf.userRegisterView setUserInteractionEnabled:NO];
//        
//        [weakSelf.viewModel reg:weakSelf.userRegisterView.usernameTextField.text password:weakSelf.userRegisterView.passwordTextField.text code:@"" completion:^(NSString * _Nonnull userId) {
//            [[weakSelf.userRegisterView passwordTextField] setSecureTextEntry:NO];
//            [weakSelf.userRegisterView.submitButton stopCircleAnimation];
//            UIImage *saveImage = [XWHelper screenView:weakSelf.userRegisterView];
//            [[weakSelf.userRegisterView passwordTextField] setSecureTextEntry:YES];
//            UIImageWriteToSavedPhotosAlbum(saveImage, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//            [weakSelf.userRegisterView setUserInteractionEnabled:YES];
//            [weakSelf closeView];
//        } failure:^(NSString * _Nonnull errorMessage) {
//
//            [weakSelf.userRegisterView.submitButton stopCircleAnimation];
//            [weakSelf.userRegisterView setUserInteractionEnabled:YES];
//            [XWHUD showOnlyText:weakSelf.view text:errorMessage];
//        }];
//    }];
//    
//    [_userRegisterView setPhoneButtonClickBlock:^{
//        [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
//        XWPhoneLoginViewController *phoneLoginViewController = [XWPhoneLoginViewController new];
//        [phoneLoginViewController setCodeType:XWRegisterCode];
//        [weakSelf.navigationController pushViewController:phoneLoginViewController animated:NO];
//    }];
//    
//    [_userRegisterView setLabelClickBlock:^{
////        XWWebViewController *webViewController = [[XWWebViewController alloc] initWithURL:XW_USERAGREEMEN_ADDRESS webTitle:@"用户协议"];
////        [weakSelf.navigationController pushViewController:webViewController animated:YES];
//    }];
//}
//
//
//- (void)bgClick
//{
//    [super bgClick];
//    [_userRegisterView hiddenKeyBroad];
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    
//    WS(weakSelf);
//    [_userRegisterView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
//    [_userRegisterView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
//        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
//    }];
//    
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        
//    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//    }
//}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    NSString *msg = nil ;
//    if(error != NULL)
//    {
//        if(error.code==-3310)
//        {
//            msg = @"未授权相册权限" ;
//        }
//        else
//        {
//            msg = @"保存账号信息失败" ;
//        }
//    }else{
//        msg = @"保存账号信息成功" ;
//    }
//    [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:msg];
//}
//
//
//@end
