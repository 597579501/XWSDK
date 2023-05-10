//

//  Created by 张熙文 on 2017/5/23.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWCodeLoginViewController.h"
#import "XWCodeLoginView.h"
#import "XWProgressHUD.h"
//#import "XWUserSystemManager.h"
#import "XWResetPassWordViewController.h"
#import "XWSDK.h"
@interface XWCodeLoginViewController ()
{
    
}
@property (nonatomic, strong) XWCodeLoginView *codeLoginView;
@end

@implementation XWCodeLoginViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _codeLoginView = [XWCodeLoginView new];
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:_codeLoginView];
    
    [_codeLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    
    [_codeLoginView setBackButtonClickBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    
    [_codeLoginView setBlockForCodeLabelTouchUpInside:^{
        [weakSelf.codeLoginView.codeTextField resignFirstResponder];
        [weakSelf.codeLoginView.passwordTextField resignFirstResponder];
        XWProgressHUD *hud = [XWHUD showHUD:weakSelf.view];
        
        [weakSelf.viewModel sendCode:weakSelf.phone name:[XWSDK sharedInstance].currUser.userName codeType:weakSelf.codeType completion:^{
            [weakSelf.codeLoginView codeLabelCountDown:[NSNumber numberWithInt:59]];
            [XWHUD hideHUD:hud];
            [XWHUD showOnlyText:weakSelf.view text:@"获取验证码成功"];
        } failure:^(NSString * _Nonnull errorMessage) {
            [XWHUD hideHUD:hud];
            [XWHUD showOnlyText:weakSelf.view text:errorMessage];
        }];
        
    }];
    
    [self.codeLoginView setCodeType:self.codeType];

    
    [_codeLoginView setSubmitButtonClickBlock:^{
        [[UIApplication sharedApplication].windows.firstObject endEditing:YES]; 
        [weakSelf.codeLoginView setUserInteractionEnabled:NO];
        [weakSelf.codeLoginView.codeTextField resignFirstResponder];
        [weakSelf.codeLoginView.passwordTextField resignFirstResponder];
        
        if (weakSelf.codeType == XWRegisterCode)
        {
            
            [weakSelf.viewModel reg:weakSelf.phone password:weakSelf.codeLoginView.passwordTextField.text code:weakSelf.codeLoginView.codeTextField.text completion:^(NSString * _Nonnull userId) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [weakSelf closeView];
            } failure:^(NSString * _Nonnull errorMessage) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
            }];
        }
        else if (weakSelf.codeType == XWResetCode)
        {
            [weakSelf.viewModel resetPassword:weakSelf.phone code:weakSelf.codeLoginView.codeTextField.text newPassword:weakSelf.codeLoginView.passwordTextField.text completion:^{

                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [weakSelf closeView];
                [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"重置密码成功"];
                [[XWSDK sharedInstance] logoutAccount];
            } failure:^(NSString * _Nonnull errorMessage) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
            }];
        }
        else if (weakSelf.codeType == XWBindCode)
        {
            [weakSelf.viewModel bind:[XWSDK sharedInstance].currUser.userName password:weakSelf.codeLoginView.passwordTextField.text phone:weakSelf.phone code:weakSelf.codeLoginView.codeTextField.text completion:^(XWUserModel * _Nonnull userModel) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [weakSelf closeView];
                [[XWSDK sharedInstance] showFloatBtn];
                [XWSDK sharedInstance].currUser.isBindphone = YES;
                [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"绑定成功"];
            } failure:^(NSString * _Nonnull errorMessage) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
            }];
        }
        else if (weakSelf.codeType == XWUnBindCode)
        {
            [weakSelf.viewModel unBind:[XWSDK sharedInstance].currUser.userName password:weakSelf.codeLoginView.passwordTextField.text phone:weakSelf.phone code:weakSelf.codeLoginView.codeTextField.text completion:^(XWUserModel * _Nonnull userModel) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [weakSelf closeView];
                [[XWSDK sharedInstance] showFloatBtn];
                [XWSDK sharedInstance].currUser.isBindphone = NO;
                [XWHUD showOnlyText:[[UIApplication sharedApplication] windows].firstObject text:@"解绑成功"];
            } failure:^(NSString * _Nonnull errorMessage) {
                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
            }];
        }
    }];
}


- (void)setPhone:(NSString *)phone
{
    [_codeLoginView setPhone:phone];
    _phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (void)bgClick
{
    [super bgClick];
    [_codeLoginView hiddenKeyBroad];
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_codeLoginView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_codeLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];

}



@end
