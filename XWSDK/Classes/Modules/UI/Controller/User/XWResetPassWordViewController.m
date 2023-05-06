#import "XWResetPassWordViewController.h"
#import "XWResetPassWordView.h"
//#import "XWUserSystemManager.h"

@interface XWResetPassWordViewController ()
@property (nonatomic, strong) XWResetPassWordView *resetPassWordView;
@end

@implementation XWResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    _resetPassWordView = [XWResetPassWordView new];
    [self.view addSubview:_resetPassWordView];
    [_resetPassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [_resetPassWordView setBackButtonClickBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    
    [_resetPassWordView setSubmitButtonClickBlock:^{
        [[UIApplication sharedApplication].keyWindow endEditing:YES]; 
        [weakSelf.resetPassWordView setUserInteractionEnabled:NO];
        [weakSelf.resetPassWordView.passwordTextField resignFirstResponder];
//        [XWUserSystemManager resetPassword:weakSelf.phoneNumber code:weakSelf.code newPassword:weakSelf.resetPassWordView.passwordTextField.text success:^{
//            [weakSelf.resetPassWordView.submitButton stopCircleAnimation];
//            [weakSelf.resetPassWordView setUserInteractionEnabled:YES];
//            [weakSelf closeView];
//            [XWHUD showOnlyText:[[UIApplication sharedApplication] keyWindow] text:@"重置密码成功"];
//            [[XWSDK share] logoutAccount];
//        } failure:^(int errcode, NSString *errorMessage) {
//            [weakSelf.resetPassWordView.submitButton stopCircleAnimation];
//            [weakSelf.resetPassWordView setUserInteractionEnabled:YES];
//            [XWHUD showOnlyText:weakSelf.view text:errorMessage];
//        }];
    }];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_resetPassWordView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_resetPassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        
    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
    }
}
@end
