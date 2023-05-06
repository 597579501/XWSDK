////
//
////  Created by 张熙文 on 2017/5/18.
////  Copyright © 2017年 张熙文. All rights reserved.
////
//
//#import "XWMainViewController.h"
//#import "XWPhoneLoginViewController.h"
//#import "XWMainView.h"
//#import "XWUserSystemManager.h"
//#import "XWUserLoginViewController.h"
//#import "XWUserRegisterViewController.h"
//
//@interface XWMainViewController ()
//{
//    XWMainView *_mainView;
//}
//@end
//
//@implementation XWMainViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    WS(weakSelf);
//    
//    
//    _mainView = [XWMainView new];
//    [self.view addSubview:_mainView];
//    
//    [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.centerY.mas_equalTo(self.view.mas_centerY);
//    }];
//    
//    [_mainView setPhoneRegisterButtonClickBlock:^{
//        XWPhoneLoginViewController *phoneLoginViewController = [XWPhoneLoginViewController new];
//        [phoneLoginViewController setCodeType:CodeTypeByPhoneLogin];
//        [weakSelf.navigationController pushViewController:phoneLoginViewController animated:NO];
//    }];
//    
//    [_mainView setVisitorsButtonClickBlock:^{
//        XWUserRegisterViewController *userRegisterViewController = [XWUserRegisterViewController new];
//        [weakSelf.navigationController pushViewController:userRegisterViewController animated:NO];
//        [[[userRegisterViewController userRegisterView] passwordTextField] setSecureTextEntry:NO];
//        
//        NSString *randomUsername = [NSString stringWithFormat:@"mk_%@",[XWHelper genRandomText:6]];
//        NSString *randomPassword = [XWHelper genRandomText:6];
//        [[[userRegisterViewController userRegisterView] usernameTextField] setText:randomUsername];
//        [[[userRegisterViewController userRegisterView] passwordTextField] setText:randomPassword];
//        [[[userRegisterViewController userRegisterView] submitButton] setEnabled:YES];
//    }];
//    
//    [_mainView setUserLoginButtonClickBlock:^{
//        XWUserLoginViewController *userLoginViewController = [XWUserLoginViewController new];
//        [weakSelf.navigationController pushViewController:userLoginViewController animated:NO];
//    }];
//    
//    [_mainView setBackButtonClickBlock:^{
//        
//        [weakSelf closeView];
//    }];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)pushLoginView
//{
//    XWUserLoginViewController *userLoginViewController = [XWUserLoginViewController new];
//    [self.navigationController pushViewController:userLoginViewController animated:NO];
//}
//
//@end
