//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"
#import "LineView.h"
#import "XWImageButton.h"
#import "XWUserAgreementView.h"


typedef void (^labelClickBlock)(void);
typedef void (^PhoneButtonClickBlock)(void);

@interface XWUserRegisterView : XWView
{
    UIImageView *_topView;
}

@property (nonatomic, strong, readonly) XWUsernameTextField *usernameTextField;
@property (nonatomic, strong, readonly) XWPasswordTextField *passwordTextField;
@property (nonatomic, strong) XWUserAgreementView *userAgreementView;;
@property (nonatomic, strong, readonly) XWSubmitButton *submitButton;
@property (nonatomic, strong, readonly) XWSubmitButton *phoneButton;
@property (nonatomic, copy, readonly) labelClickBlock labelClickBlock;
@property (nonatomic, copy) PhoneButtonClickBlock phoneButtonClickBlock;
@property (nonatomic, copy) PrivacyLabelClickBlock privacyLabelClickBlock;


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock;
@end
