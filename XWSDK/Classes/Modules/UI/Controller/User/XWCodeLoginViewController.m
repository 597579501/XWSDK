//

//  Created by 张熙文 on 2017/5/23.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWCodeLoginViewController.h"
#import "XWCodeLoginView.h"
#import "XWProgressHUD.h"
//#import "XWUserSystemManager.h"
#import "XWResetPassWordViewController.h"

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
        
        [weakSelf.viewModel sendCode:weakSelf.phone name:weakSelf.phone codeType:weakSelf.codeType completion:^{
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
        [[UIApplication sharedApplication].keyWindow endEditing:YES]; 
        [weakSelf.codeLoginView setUserInteractionEnabled:NO];
        [weakSelf.codeLoginView.codeTextField resignFirstResponder];
        [weakSelf.codeLoginView.passwordTextField resignFirstResponder];
        
//        if (weakSelf.codeType == XWRegisterCode) {
////            [XWUserSystemManager registerUser:@""
////                                     passWord:weakSelf.codeLoginView.passwordTextField.text
////                                  phoneNumber:weakSelf.phone
////                                   verifyCode:weakSelf.codeLoginView.codeTextField.text
////                                         type:UserTypeByPhone
////                                      success:^(XWUserResponeModel *userResponeModel) {
////                                          [weakSelf.codeLoginView.submitButton stopCircleAnimation];
////                                          [weakSelf.codeLoginView setUserInteractionEnabled:YES];
////                                          [weakSelf closeView];
////                                      } failure:^(int errcode, NSString *errorMessage) {
////                                          [weakSelf.codeLoginView.submitButton stopCircleAnimation];
////                                          [weakSelf.codeLoginView setUserInteractionEnabled:YES];
////                                          [XWHUD showOnlyText:weakSelf.view text:errorMessage];
////                [weakSelf.viewModel sendCode:weakSelf.phone name:<#(nonnull NSString *)#> codeType:<#(XWCodeType)#> completion:<#^(void)completion#> failure:<#^(NSString * _Nonnull errorMessage)failure#>]
//            
////            }];
//        }
//        else if (weakSelf.codeType == XWResetCode)
//        {
//            [XWUserSystemManager verifyCode:weakSelf.codeLoginView.codeTextField.text phoneNumber:weakSelf.phone method:XW_RESETPASSWORDEVERIFY_METHOD success:^(NSString *resetToken) {
//                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
//                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
//
//                XWResetPassWordViewController *resetPassWordViewController = [XWResetPassWordViewController new];
//                [resetPassWordViewController setCode:weakSelf.codeLoginView.codeTextField.text];
//                [resetPassWordViewController setPhoneNumber:weakSelf.phone];
//                [weakSelf.navigationController pushViewController:resetPassWordViewController animated:NO];
//
//            } failure:^(int errcode, NSString *errorMessage) {
//                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
//                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
//                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
//            }];
//        }
//        else if (weakSelf.codeType == XWBindCode)
//        {
//            [XWUserSystemManager verifyCode:weakSelf.codeLoginView.codeTextField.text phoneNumber:weakSelf.phone method:XW_BINDPHONEVERIFY_METHOD success:^(NSString *resetToken) {
//                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
//                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
//                [weakSelf closeView];
//                [[XWSDK share] showFloatBtn];
//                [XWHUD showOnlyText:[[UIApplication sharedApplication] keyWindow] text:@"绑定成功"];
//            } failure:^(int errcode, NSString *errorMessage) {
//                [weakSelf.codeLoginView.submitButton stopCircleAnimation];
//                [weakSelf.codeLoginView setUserInteractionEnabled:YES];
//                [XWHUD showOnlyText:weakSelf.view text:errorMessage];
//            }];
//        }
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
