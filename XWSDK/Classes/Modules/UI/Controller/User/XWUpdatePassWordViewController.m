//

//  Created by 熙文 张 on 17/6/2.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUpdatePassWordViewController.h"
//#import "XWUserSystemManager.h"


@interface XWUpdatePassWordViewController ()

@end

@implementation XWUpdatePassWordViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _updatePassWordView = [XWUpdatePassWordView new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    
    [self.view addSubview:_updatePassWordView];
    [_updatePassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    
//    [_updatePassWordView setBackButtonClickBlock:^{
//        [weakSelf.navigationController popViewControllerAnimated:NO];
//    }];
//    
//    [_updatePassWordView setSubmitButtonClickBlock:^{
//        [[UIApplication sharedApplication].keyWindow endEditing:YES]; 
//        [weakSelf.updatePassWordView.submitButton startCircleAnimation];
//        [weakSelf.updatePassWordView setUserInteractionEnabled:NO];
//        [weakSelf.updatePassWordView.oldPasswordTextField resignFirstResponder];
//        [weakSelf.updatePassWordView.nPasswordTextField resignFirstResponder];
//        [weakSelf.updatePassWordView.repeatPasswordTextField resignFirstResponder];
////        [XWUserSystemManager updatePassword:weakSelf.updatePassWordView.oldPasswordTextField.text
////                                newPassword:weakSelf.updatePassWordView.nPasswordTextField.text
////                                    success:^{
////                                        [weakSelf.updatePassWordView.submitButton stopCircleAnimation];
////                                        [weakSelf.updatePassWordView setUserInteractionEnabled:YES];
////                                        [weakSelf closeView];
////                                        [[XWSDK share] showFloatBtn];
////                                        [XWHUD showOnlyText:[[UIApplication sharedApplication] keyWindow] text:@"修改密码成功"];
////                                    } failure:^(int errcode, NSString *errorMessage) {
////                                        [weakSelf.updatePassWordView.submitButton stopCircleAnimation];
////                                        [weakSelf.updatePassWordView setUserInteractionEnabled:YES];
////                                        [XWHUD showOnlyText:weakSelf.view text:errorMessage];
////                                    }];
//        
//
//    }];
    
}


- (void)bgClick
{
    [super bgClick];
    [_updatePassWordView hiddenKeyBroad];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_updatePassWordView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_updatePassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        
    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
    }
}

@end
