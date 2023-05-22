#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"
#import "LineView.h"
#import "XWImageButton.h"
#import "XWUserListTableView.h"
//#import "XWAgreementView.h"
#import "XWUserAgreementView.h"

typedef void (^forgetLabelClickBlock)(void);
typedef void (^registerButtonClickBlock)(void);
typedef void (^delButtonClickBlock)(NSString *username);

typedef void (^headTapBlock)(void);



@interface XWUserLoginView : XWView<UITableViewDelegate, UITableViewDataSource>
{
    NSUInteger _count;
//    XWAgreementView *_autoLoginAgreementView;
    YYLabel *_forgetLabel;
    
}

- (instancetype)initWithUserCount:(NSUInteger)count;

@property (nonatomic, strong) NSMutableArray *userArray;

@property (nonatomic, strong) XWUsernameTextField *usernameTextField;
@property (nonatomic, strong) XWPasswordTextField *passwordTextField;
@property (nonatomic, strong) XWUserListTableView *userListTableView;
@property (nonatomic, strong) XWUserAgreementView *userAgreementView;;

@property (nonatomic, strong) XWSubmitButton *submitButton;
@property (nonatomic, strong) XWSubmitButton *registerButton;
@property (nonatomic, copy) forgetLabelClickBlock forgetLabelClickBlock;
@property (nonatomic, copy) registerButtonClickBlock registerButtonClickBlock;
@property (nonatomic, copy) delButtonClickBlock delButtonClickBlock;

@property (nonatomic, copy) headTapBlock headTapBlock;

- (void)setForgetLabelClickBlock:(forgetLabelClickBlock)forgetLabelClickBlock;
- (void)setRegisterButtonClickBlock:(registerButtonClickBlock)registerButtonClickBlock;
- (void)setDelButtonClickBlock:(delButtonClickBlock)delButtonClickBlock;
- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;



- (void)showView;


@end


