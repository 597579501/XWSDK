//

//  Created by 熙文 张 on 17/6/2.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUpdatePassWordView.h"

@interface XWUpdatePassWordView (){
    
    UIButton *_backBtn;
}


@end

@implementation XWUpdatePassWordView

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
        
        _backBtn = backButton;
        
//        _logoImageView = [UIImageView new];
//        [_logoImageView setImage:kImage(@"XW_SDK_LanLogo2")];
//        [self addSubview:_logoImageView];
        
        UILabel *leftLabel = [UILabel new];
        [leftLabel setFont:kTextFont];
        [leftLabel setText:@"+86"];
        [leftLabel setFrame:CGRectMake(0, 0, 35, 30)];
        
        _oldPasswordTextField = [XWPasswordTextField new];
        [_oldPasswordTextField setPlaceholder:@"请输入原密码"];
        [self addSubview:_oldPasswordTextField];
        
        _nPasswordTextField = [XWPasswordTextField new];
        [_nPasswordTextField setPlaceholder:@"请输入新密码"];
        [self addSubview:_nPasswordTextField];
        
        _repeatPasswordTextField = [XWPasswordTextField new];
        [_repeatPasswordTextField setPlaceholder:@"请重复新密码"];
        [self addSubview:_repeatPasswordTextField];
        
        
        _submitButton = [XWSubmitButton new];
        [_submitButton setEnabled:NO];
        [_submitButton setTitle:@"修改"];
        [self addSubview:_submitButton];
        
    
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.oldPasswordTextField resignFirstResponder];
            [weakSelf.nPasswordTextField resignFirstResponder];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        [self.oldPasswordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [self.nPasswordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [self.repeatPasswordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        
   
        
        [self setBgClickClickBlock:^{
            [weakSelf.oldPasswordTextField resignFirstResponder];
            [weakSelf.nPasswordTextField resignFirstResponder];
        }];
        
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}



- (void)textChanged
{
    NSString *oldPassword = [_nPasswordTextField text];
    NSString *newPassword = [_oldPasswordTextField text];
    NSString *repeatPassword = [_repeatPasswordTextField text];
    
    BOOL boolLen = (([[oldPassword stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                    && ([[repeatPassword stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                    && ([[newPassword stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6));
    BOOL isEqual = [oldPassword isEqualToString:repeatPassword];
    
    [_submitButton setEnabled:boolLen && isEqual];
    
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    CGFloat margin = 15;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(20);
//        }];
        
        [self.oldPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(_backBtn.mas_bottom);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [self.nPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oldPasswordTextField.mas_left);
            make.width.mas_equalTo(self.oldPasswordTextField.mas_width);;
            make.height.mas_equalTo(self.oldPasswordTextField.mas_height);
            make.top.mas_equalTo(self.oldPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        
        [self.repeatPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nPasswordTextField.mas_left);
            make.width.mas_equalTo(self.nPasswordTextField.mas_width);;
            make.height.mas_equalTo(self.nPasswordTextField.mas_height);
            make.top.mas_equalTo(self.nPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.repeatPasswordTextField.mas_width);
            make.height.mas_equalTo(self.repeatPasswordTextField.mas_height);
            make.left.mas_equalTo(self.repeatPasswordTextField.mas_left);
            make.top.mas_equalTo(self.repeatPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(self.oldPasswordTextField.mas_right).with.offset(margin);
        }];
        
//        [_logoImageView setImage:kImage(@"XW_SDK_MainLogo2")];
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(margin);
//            make.top.mas_equalTo(40);
//        }];
        
        WS(weakSelf);
        [self.oldPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).with.offset(margin);
            make.top.mas_equalTo(_backBtn.mas_bottom);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [self.nPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oldPasswordTextField.mas_left);
            make.width.mas_equalTo(self.oldPasswordTextField.mas_width);;
            make.height.mas_equalTo(self.oldPasswordTextField.mas_height);
            make.top.mas_equalTo(self.oldPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        [self.repeatPasswordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nPasswordTextField.mas_left);
            make.width.mas_equalTo(self.nPasswordTextField.mas_width);;
            make.height.mas_equalTo(self.nPasswordTextField.mas_height);
            make.top.mas_equalTo(self.nPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.repeatPasswordTextField.mas_width);
            make.height.mas_equalTo(self.repeatPasswordTextField.mas_height);
            make.left.mas_equalTo(self.repeatPasswordTextField.mas_left);
            make.top.mas_equalTo(self.repeatPasswordTextField.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(self.oldPasswordTextField.mas_right).with.offset(margin);
        }];
        
//        [_logoImageView setImage:kImage(@"XW_SDK_LanLogo2")];
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
