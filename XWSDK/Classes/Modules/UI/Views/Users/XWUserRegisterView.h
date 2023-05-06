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

@interface XWUserRegisterView : XWView
{
    XWUserAgreementView *_userAgreementView;
    UIImageView *_topView;
}

@property (nonatomic, strong, readonly) XWUsernameTextField *usernameTextField;
@property (nonatomic, strong, readonly) XWPasswordTextField *passwordTextField;
@property (nonatomic, strong, readonly) XWSubmitButton *submitButton;
@property (nonatomic, copy, readonly) labelClickBlock labelClickBlock;


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock;
@end
