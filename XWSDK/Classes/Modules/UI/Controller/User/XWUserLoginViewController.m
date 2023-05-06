//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserLoginViewController.h"
#import "XWUserRegisterViewController.h"
#import "XWUserLoginView.h"
//#import "XWUserSystemManager.h"
//#import "XWUserResponeModel.h"
#import "XWPhoneLoginViewController.h"
#import "XWDBHelper.h"


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
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        XWUserRegisterViewController *userRegisterViewController = [XWUserRegisterViewController new];
        [weakSelf.navigationController pushViewController:userRegisterViewController animated:NO];
    }];
    
    [_userLoginView setForgetLabelClickBlock:^{
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        XWPhoneLoginViewController *phoneLoginViewController = [XWPhoneLoginViewController new];
        [phoneLoginViewController setCodeType:CodeTypeByFindPassword];
        [weakSelf.navigationController pushViewController:phoneLoginViewController animated:NO];
    
        
    }];
    
    [_userLoginView setSubmitButtonClickBlock:^{
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES]; 
//        [weakSelf.userLoginView.usernameTextField resignFirstResponder];
//        [weakSelf.userLoginView.passwordTextField resignFirstResponder];
//        [weakSelf.userLoginView setUserInteractionEnabled:NO];
        
        
        
        NSLog(@"账号%@",weakSelf.userLoginView.usernameTextField.text);
        NSLog(@"密码%@",weakSelf.userLoginView.passwordTextField.text);
        
//        [XWUserSystemManager login:weakSelf.userLoginView.usernameTextField.text
//                          passWord:weakSelf.userLoginView.passwordTextField.text
//                       phoneNumber:@"" verifyCode:@"" type:UserTypeByNormal success:^(XWUserResponeModel *userResponeModel) {
//                           
//                           [weakSelf.userLoginView.submitButton stopCircleAnimation];
//                           [weakSelf.userLoginView setUserInteractionEnabled:YES];
//                           [weakSelf closeView];
//                           
//        } failure:^(int errcode, NSString *errorMessage) {
//            [weakSelf.userLoginView.submitButton stopCircleAnimation];
//            [weakSelf.userLoginView setUserInteractionEnabled:YES];
//            [XWHUD showOnlyText:weakSelf.view text:errorMessage];
//        }];
    }];
    
    
    
    //解决旧版版本账号记录兼容问题
    XWUserLoginRecordModel *userLoginRecordModel = nil;
    XWUserResponeModel *userResponeModel = [XWUserSystemManager getUserInformation];
    if (userResponeModel) {
        userLoginRecordModel = [[XWUserLoginRecordModel alloc] init];;
        [userLoginRecordModel setUsername:userResponeModel.username];
        [userLoginRecordModel setUserType:userResponeModel.type];
        [userLoginRecordModel setPassword:userResponeModel.password];
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
                                                         && ([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6))];

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
