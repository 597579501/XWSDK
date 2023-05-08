//

//  Created by 张熙文 on 2017/5/23.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWCodeLoginView.h"

@implementation XWCodeLoginView

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
        [companyLabel setText:@"账号登陆"];
        [companyLabel setFont:kFont(17)];
        [topView addSubview:companyLabel];
        
//        LineView *lineView = [LineView new];
//        [lineView setLineColor:[UIColor whiteColor]];
//        [lineView setStyle:LineVerticalStyle];
//        [topView addSubview:lineView];
//
//        UILabel *subTitleLabel = [UILabel new];
//        [subTitleLabel setTextColor:[UIColor whiteColor]];
//        [subTitleLabel setText:@"账号登录"];
//        [subTitleLabel setFont:kFont(12)];
//        [topView addSubview:subTitleLabel];
//        _subTitleLabel = subTitleLabel;
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [topView addSubview:backButton];
        
    

        _phoneDescLabel = [UILabel new];
        [_phoneDescLabel setFont:kTextFont];
        [_phoneDescLabel setTextColor:kTextDetailColor];
        [self addSubview:_phoneDescLabel];
        
        _codeTextField = [XWCodeTextField new];
        [self addSubview:_codeTextField];
        
        _passwordTextField = [XWPasswordTextField new];
        [self.passwordTextField setHidden:YES];
        [self addSubview:_passwordTextField];
        
        _submitButton = [XWSubmitButton new];
        [_submitButton setEnabled:NO];
        [_submitButton setTitle:@"登录"];
        [self addSubview:_submitButton];
        
        
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
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.codeTextField resignFirstResponder];
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.codeTextField.codeTextField resignFirstResponder];
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.codeTextField.codeTextField resignFirstResponder];
            [weakSelf.submitButton startCircleAnimation];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];
        
        [_codeTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id sender) {
            [weakSelf codeTextChanged];
        }];
        
        [_passwordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id sender) {
            [weakSelf codeTextChanged];
        }];
        
        [_codeTextField setBlockForCodeLabelTouchUpInside:^{
            if (weakSelf.blockForCodeLabelTouchUpInside) {
                weakSelf.blockForCodeLabelTouchUpInside();
            }
        }];
        
        
        
        
        [self setBgClickClickBlock:^{
            [weakSelf.codeTextField.codeTextField resignFirstResponder];
        }];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
    }
    return self;
}




- (void)setBlockForCodeLabelTouchUpInside:(blockForCodeLabelTouchUpInside)blockForCodeLabelTouchUpInside
{
    _blockForCodeLabelTouchUpInside = blockForCodeLabelTouchUpInside;
}


- (void)setCodeType:(XWCodeType)codeType
{
    _codeType = codeType;
    switch (codeType) {
        case XWRegisterCode:
        {
            [self.submitButton setTitle:@"注册"];
            [_subTitleLabel setText:@"账号注册"];
            [self.passwordTextField setHidden:NO];
            [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.codeTextField.mas_left);
                make.top.mas_equalTo(self.codeTextField.mas_bottom).with.offset(10);
                make.width.mas_equalTo(self.codeTextField.mas_width);
                make.height.mas_equalTo(40);
            }];
            break;
        }
        case XWResetCode:
        {
            [self.submitButton setTitle:@"验证"];
            [_subTitleLabel setText:@"验证手机"];
            [self.passwordTextField setClipsToBounds:YES];
            [self.passwordTextField setHidden:YES];
            [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.codeTextField.mas_left);
                make.top.mas_equalTo(self.codeTextField.mas_bottom).with.offset(10);
                make.width.mas_equalTo(self.codeTextField.mas_width);
                make.height.mas_equalTo(0);
            }];
            break;
        }
        case XWBindCode:
        {
            [self.submitButton setTitle:@"绑定"];
            [_subTitleLabel setText:@"绑定"];
            [self.passwordTextField setClipsToBounds:YES];
            [self.passwordTextField setHidden:YES];
            [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.codeTextField.mas_left);
                make.top.mas_equalTo(self.codeTextField.mas_bottom).with.offset(10);
                make.width.mas_equalTo(self.codeTextField.mas_width);
                make.height.mas_equalTo(0);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    [_phoneDescLabel setText:[NSString stringWithFormat:@"即将发送到手机号：%@", phone]];
}



- (void)codeTextChanged
{
    switch (self.codeType) {
        case XWRegisterCode:
        {
            NSString *code = [_codeTextField text];
            NSString *password = [_passwordTextField text];
            [_submitButton setEnabled:(([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 5)
                                       && [[code stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 5)];
            break;
        }
        case XWResetCode:
        {
            NSString *code = [_codeTextField text];
            [_submitButton setEnabled:([[code stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 5)];
            break;
        }
        case XWBindCode:
        {
            NSString *code = [_codeTextField text];
            [_submitButton setEnabled:([[code stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 5)];
            break;
        }
        default:
            break;
    }
    
}



#pragma mark -- 获取验证码按钮倒计时 --
- (void)codeLabelCountDown:(NSNumber *)second;
{
    [_codeTextField.codeLabel setUserInteractionEnabled:NO];
    _isCountDown = YES;
    int time = [second intValue];
    if (time == 0)
    {
        [_codeTextField.codeLabel setText:@"获取验证码"];
        [_codeTextField.codeLabel setUserInteractionEnabled:YES];
        [_codeTextField.codeLabel setAlpha:1];
        _isCountDown = NO;
    }
    else
    {
        NSString *timeStr = [NSString stringWithFormat:@"%ds",time];
        [_codeTextField.codeLabel setText:timeStr];
        [_codeTextField.codeLabel setAlpha:0.5];
        [self performSelector:@selector(codeLabelCountDown:) withObject:[NSNumber numberWithInt:time - 1] afterDelay:1];
    }
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        
        [_topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        [_phoneDescLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(15);
            make.left.mas_equalTo(15);
        }];
        
        [self.codeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneDescLabel.mas_left);
            make.top.mas_equalTo(_phoneDescLabel.mas_bottom).with.offset(15);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.codeTextField.mas_left);
            make.top.mas_equalTo(self.codeTextField.mas_bottom).with.offset(10);
            make.width.mas_equalTo(self.codeTextField.mas_width);
            make.height.mas_equalTo(40);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.codeTextField.mas_width);
            make.height.mas_equalTo(self.codeTextField.mas_height);
            make.left.mas_equalTo(self.codeTextField.mas_left);
            make.top.mas_equalTo(self.passwordTextField.mas_bottom).with.offset(15);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(15);
            make.right.mas_equalTo(self.codeTextField.mas_right).with.offset(15);
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
        
        [_phoneDescLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(15);
        }];
        
        [self.codeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneDescLabel.mas_left);
            make.top.mas_equalTo(_phoneDescLabel.mas_bottom).with.offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.codeTextField.mas_left);
            make.top.mas_equalTo(self.codeTextField.mas_bottom).with.offset(10);
            make.width.mas_equalTo(self.codeTextField.mas_width);
            make.height.mas_equalTo(40);
        }];

        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.codeTextField.mas_width);
            make.height.mas_equalTo(self.codeTextField.mas_height);
            make.left.mas_equalTo(self.codeTextField.mas_left);
            make.top.mas_equalTo(self.passwordTextField.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(10);
            make.right.mas_equalTo(self.codeTextField.mas_right).with.offset(15);
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
