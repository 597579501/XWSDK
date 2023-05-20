//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserRegisterView.h"
#import "XWSubmitButton.h"
#import "XWTextField.h"

@interface XWUserRegisterView ()


@end

@implementation XWUserRegisterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:5];
        
        UIImageView *topView = [UIImageView new];
        [topView setUserInteractionEnabled:YES];
//        UIImage *loginTopImage = kImage(@"MK_SDK_LoginTop");
//        [topView setImage:loginTopImage];
//        [topView setBackgroundColor:UIColorHex(0x77aeee)];
        
        [topView setBackgroundColor:XWAdapterHead];

        [self addSubview:topView];
        _topView = topView;
        
        UILabel *companyLabel = [UILabel new];
        [companyLabel setTextColor:[UIColor whiteColor]];
        [companyLabel setText:@"账号注册"];
        [companyLabel setFont:kFont(17)];
        [topView addSubview:companyLabel];
        
//        LineView *lineView = [LineView new];
//        [lineView setLineColor:[UIColor whiteColor]];
//        [lineView setStyle:LineVerticalStyle];
//        [topView addSubview:lineView];
//
//        UILabel *subTitleLabel = [UILabel new];
//        [subTitleLabel setTextColor:[UIColor whiteColor]];
//        [subTitleLabel setText:@"账号注册"];
//        [subTitleLabel setFont:kFont(12)];
//        [topView addSubview:subTitleLabel];
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [topView addSubview:backButton];
        
        
        UILabel *leftLabel = [UILabel new];
        [leftLabel setFont:kTextFont];
        [leftLabel setText:@"+86"];
        [leftLabel setFrame:CGRectMake(0, 0, 35, 30)];
        
        _usernameTextField = [XWUsernameTextField new];
        [self.usernameTextField setPlaceholder:@"请输入账号（首位为字母）"];
        [self addSubview:_usernameTextField];
        
        _passwordTextField = [XWPasswordTextField new];
        [self addSubview:_passwordTextField];
        
        _userAgreementView = [XWUserAgreementView new];
        [self addSubview:_userAgreementView];
        
        _submitButton = [XWSubmitButton new];
        [_submitButton setEnabled:NO];
        [_submitButton setTitle:@"注册并登录"];
        [self addSubview:_submitButton];
        
        _phoneButton = [XWSubmitButton new];
        [_phoneButton setTitle:@"手机号注册"];
        [self addSubview:_phoneButton];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.left.mas_equalTo(0);
        }];
        
        [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.left.mas_equalTo(backButton.mas_right);
        }];
        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(companyLabel.mas_right).offset(5);
//            make.centerY.mas_equalTo(companyLabel.mas_centerY).offset(2);
//            make.height.mas_equalTo(15);
//            make.width.mas_equalTo(1);
//        }];
//        
//        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lineView.mas_right).offset(5);
//            make.centerY.mas_equalTo(lineView.mas_centerY);
//        }];
        
        [_userAgreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).with.offset(10);
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
        }];
        
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.usernameTextField resignFirstResponder];
            [weakSelf.passwordTextField resignFirstResponder];
            [weakSelf.submitButton startCircleAnimation];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];
        
        [_phoneButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.usernameTextField resignFirstResponder];
            [weakSelf.passwordTextField resignFirstResponder];
            if (weakSelf.phoneButtonClickBlock) {
                weakSelf.phoneButtonClickBlock();
            }
        }];
        
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        [self.usernameTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [self.passwordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [_userAgreementView setCheckClickBlock:^(BOOL isCheck) {
            [weakSelf textChanged];
        }];

        [_userAgreementView setLabelClickBlock:^{
            if (weakSelf.labelClickBlock) {
                weakSelf.labelClickBlock();
            }
        }];
        
        [_userAgreementView setPrivacyLabelClickBlock:^{
            if (weakSelf.privacyLabelClickBlock) {
                weakSelf.privacyLabelClickBlock();
            }
        }];
        
        [self setBgClickClickBlock:^{
            [weakSelf.usernameTextField resignFirstResponder];
            [weakSelf.passwordTextField resignFirstResponder];
        }];
        
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}


- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock
{
    _labelClickBlock = labelClickBlock;
}


- (void)textChanged
{
    NSString *username = [_usernameTextField text];
    NSString *password = [_passwordTextField text];
    [_submitButton setEnabled:(([[username stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                               && _userAgreementView.isCheck
                               && ([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6))];
    
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    CGFloat margin = 15;
    WS(weakSelf)
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        [_topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        [self.usernameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(margin);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.usernameTextField.mas_left);
            make.width.mas_equalTo(weakSelf.usernameTextField.mas_width);;
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.top.mas_equalTo(weakSelf.usernameTextField.mas_bottom).with.offset(10);
        }];
        
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).with.offset(10);
        }];
        
        
        [_phoneButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).with.offset(10);
        }];
        
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(weakSelf.usernameTextField.mas_right).with.offset(margin);
        }];
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [_topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        [self.usernameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];

        [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.usernameTextField.mas_left);
            make.width.mas_equalTo(weakSelf.usernameTextField.mas_width);;
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.top.mas_equalTo(weakSelf.usernameTextField.mas_bottom).with.offset(10);
        }];

        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).with.offset(10);
        }];
        
        [_phoneButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(weakSelf.usernameTextField.mas_right).with.offset(margin);
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
