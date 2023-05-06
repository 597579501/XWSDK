//

//  Created by 熙文 张 on 17/6/1.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWResetPassWordView.h"

@implementation XWResetPassWordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:5];
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [self addSubview:backButton];
        
//        _logoImageView = [UIImageView new];
//        [_logoImageView setImage:kImage(@"XW_SDK_LanLogo2")];
//        [self addSubview:_logoImageView];
        
//        UILabel *leftLabel = [UILabel new];
//        [leftLabel setFont:kTextFont];
//        [leftLabel setText:@"+86"];
//        [leftLabel setFrame:CGRectMake(5, 0, 35, 40)];
        
        _passwordTextField = [XWPasswordTextField new];
        [self addSubview:_passwordTextField];
        
        _submitButton = [XWSubmitButton new];
        [_submitButton setEnabled:NO];
        [_submitButton setTitle:@"重置"];
        [self addSubview:_submitButton];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.passwordTextField resignFirstResponder];
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        [self.passwordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.passwordTextField resignFirstResponder];
            [weakSelf.submitButton startCircleAnimation];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];
        
        [self setBgClickClickBlock:^{
            [weakSelf.passwordTextField resignFirstResponder];
        }];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}


- (void)textChanged
{
    NSString *password = [_passwordTextField text];
    [_submitButton setEnabled:(([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6))];
}



- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    CGFloat margin = 15;
    WS(weakSelf)
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
//        [_logoImageView setImage:kImage(@"XW_SDK_MainLogo2")];
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(20);
//        }];
        
//        [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(margin);
//            make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(margin);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(40);
//        }];
        
        
        [_passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(weakSelf).offset(60);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.passwordTextField.mas_width);
            make.height.mas_equalTo(weakSelf.passwordTextField.mas_height);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).offset(15);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(10);
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right).with.offset(margin);
        }];
        
        
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
//        [_logoImageView setImage:kImage(@"XW_SDK_LanLogo2")];
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(20);
//        }];
        
        [_passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(margin);
            make.top.mas_equalTo(60);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.passwordTextField.mas_width);
            make.height.mas_equalTo(weakSelf.passwordTextField.mas_height);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(10);
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right).with.offset(margin);
        }];
    }
    
    if (animated) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:duration animations:^{
            [self layoutIfNeeded];
        }];
    }
}


@end
