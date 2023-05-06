
#import "XWView.h"

typedef void (^phoneRegisterButtonClickBlock)(void);
typedef void (^visitorsButtonClickBlock)(void);
typedef void (^userLoginButtonClickBlock)(void);

@interface XWMainView : XWView
{
    
    
    UIButton * _phoneRegisterButton;
    UIButton * _visitorsButtton;
    UIButton * _userLoginButton;
    UILabel  * _phoneRegisterLabel;
    UILabel  * _visitorsvLabel;
    UILabel  * _userLoginLabel;
}
@property (nonatomic, copy, readonly) phoneRegisterButtonClickBlock phoneRegisterButtonClickBlock;
@property (nonatomic, copy, readonly) visitorsButtonClickBlock      visitorsButtonClickBlock;
@property (nonatomic, copy, readonly) userLoginButtonClickBlock     userLoginButtonClickBlock;


- (void)setPhoneRegisterButtonClickBlock:(phoneRegisterButtonClickBlock)phoneRegisterButtonClickBlock;

- (void)setVisitorsButtonClickBlock:(visitorsButtonClickBlock)visitorsButtonClickBlock;

- (void)setUserLoginButtonClickBlock:(userLoginButtonClickBlock)userLoginButtonClickBlock;

//- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animate;
@end
