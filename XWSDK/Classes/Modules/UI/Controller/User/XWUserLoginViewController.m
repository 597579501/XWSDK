//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserLoginViewController.h"
#import "XWUserRegisterViewController.h"
#import "XWUserLoginView.h"
//#import "XWUserSystemManager.h"
#import "XWUserModel.h"
#import "XWUserLoginRecordModel.h"
#import "XWPhoneLoginViewController.h"
#import "XWDBHelper.h"
#import "XWSDK.h"
#import "XWSDKEnumHeader.h"
#import "XWWebViewController.h"


@interface XWUserLoginViewController ()
{
    
}
@property (nonatomic, strong) XWUserLoginView *userLoginView;
@end

@implementation XWUserLoginViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *userArray = [[XWDBHelper sharedDBHelper] getAllUsers];
        _userLoginView = [[XWUserLoginView alloc] initWithUserCount:userArray.count];
        [_userLoginView setUserArray:userArray];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    
    [_userLoginView setDelButtonClickBlock:^(NSString *username) {
        [[XWDBHelper sharedDBHelper] deleteUser:username];
    }];
    
    [self.view addSubview:_userLoginView];
    [_userLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
   
    [_userLoginView setBackButtonClickBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    
    [_userLoginView setRegisterButtonClickBlock:^{
        [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
        XWUserRegisterViewController *userRegisterViewController = [XWUserRegisterViewController new];
        [weakSelf.navigationController pushViewController:userRegisterViewController animated:NO];
    }];
    
    [_userLoginView setForgetLabelClickBlock:^{
        [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
        XWPhoneLoginViewController *phoneLoginViewController = [XWPhoneLoginViewController new];
        [phoneLoginViewController setCodeType:XWResetCode];
        [weakSelf.navigationController pushViewController:phoneLoginViewController animated:NO];
    }];
    
    
    [self.userLoginView.userAgreementView setLabelClickBlock:^{
        NSString *XW_USERAGREEMEN_ADDRESS = [NSString stringWithFormat:@"http://agreement.gzdky.dakongy.com/protocal.html?corp=%@", [XWCommonModel sharedInstance].appId];
        XWWebViewController *webViewController = [[XWWebViewController alloc] initWithURL:XW_USERAGREEMEN_ADDRESS webTitle:@"用户协议"];
        [weakSelf.navigationController pushViewController:webViewController animated:YES];
    }];
    
    [self.userLoginView.userAgreementView setPrivacyLabelClickBlock:^{
        NSString *privacyUrl = [NSString stringWithFormat:@"http://agreement.gzdky.dakongy.com/privacy_230428.html?corp=%@", [XWCommonModel sharedInstance].appId];
        XWWebViewController *webViewController = [[XWWebViewController alloc] initWithURL:privacyUrl webTitle:@"隐私协议"];
        [weakSelf.navigationController pushViewController:webViewController animated:YES];
    }];
    
    
    
    [_userLoginView setSubmitButtonClickBlock:^{
        
        [[UIApplication sharedApplication].windows.firstObject endEditing:YES]; 
        [weakSelf.userLoginView.usernameTextField resignFirstResponder];
        [weakSelf.userLoginView.passwordTextField resignFirstResponder];
        [weakSelf.userLoginView setUserInteractionEnabled:NO];
        
        
        
//        NSLog(@"账号%@",weakSelf.userLoginView.usernameTextField.text);
//        NSLog(@"密码%@",weakSelf.userLoginView.passwordTextField.text);
        
        [weakSelf.viewModel login:weakSelf.userLoginView.usernameTextField.text password:weakSelf.userLoginView.passwordTextField.text completion:^(XWUserModel * _Nonnull userModel) {
           [weakSelf.userLoginView.submitButton stopCircleAnimation];
           [weakSelf.userLoginView setUserInteractionEnabled:YES];
           [weakSelf closeView];
        } failure:^(NSString * _Nonnull errorMessage) {
            [weakSelf.userLoginView.submitButton stopCircleAnimation];
            [weakSelf.userLoginView setUserInteractionEnabled:YES];
            [XWHUD showOnlyText:weakSelf.view text:errorMessage];
        }];
    }];
    
    
    
    //解决旧版版本账号记录兼容问题
    XWUserLoginRecordModel *userLoginRecordModel = nil;
    XWUserModel *userModel = [XWSDK sharedInstance].currUser;
    if (userModel) {
        userLoginRecordModel = [[XWUserLoginRecordModel alloc] init];;
        [userLoginRecordModel setUsername:userModel.userName];
//        [userLoginRecordModel setUserType:userModel.type];
//        [userLoginRecordModel setPassword:userModel.pas];
    }
    else
    {
        userLoginRecordModel = [[XWDBHelper sharedDBHelper] getLastLoginUser];
    }
    

    [weakSelf.userLoginView.usernameTextField setText:userLoginRecordModel.username];
    [weakSelf.userLoginView.passwordTextField setText:userLoginRecordModel.password];
    
    NSString *username = userLoginRecordModel.username;
    NSString *password = userLoginRecordModel.password;
    [[[weakSelf userLoginView] submitButton] setEnabled:(([[username stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                                                         && ([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                                                         && weakSelf.userLoginView.userAgreementView.isCheck)];
    


    //点击放大
    [_userLoginView showView];
//
//    //点击缩小
//    [_userLoginView setHeadTapBlock:^{
//
//        [weakSelf closeButtonClick];
//    }];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL)
    {
        msg = @"保存失败" ;
    }
    else
    {
        msg = @"保存成功" ;
    }
    [XWHUD showOnlyText:self.navigationController.view text:msg];
}


- (void)bgClick
{
    [super bgClick];
    [_userLoginView hiddenKeyBroad];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_userLoginView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_userLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
    }
}


@end
