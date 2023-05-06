//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWPhoneLoginView.h"
#import "XWSubmitButton.h"
#import "UIDevice+YYAdd.h"
#import "UIScreen+YYAdd.h"
#import "XWUIHelper.h"

@implementation XWPhoneLoginView

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
        [companyLabel setText:@"输入手机"];
        [companyLabel setFont:kFont(17)];
        [topView addSubview:companyLabel];
//
//        LineView *lineView = [LineView new];
//        [lineView setLineColor:[UIColor whiteColor]];
//        [lineView setStyle:LineVerticalStyle];
//        [topView addSubview:lineView];
        
//        UILabel *subTitleLabel = [UILabel new];
//        [subTitleLabel setTextColor:[UIColor whiteColor]];
//        [subTitleLabel setText:@"输入手机"];
//        [subTitleLabel setFont:kFont(12)];
//        [topView addSubview:subTitleLabel];
        
        
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [topView addSubview:backButton];
        
        _phoneTextField = [XWPhoneTextField new];
        [_phoneTextField addTarget:self action:@selector(phoneTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_phoneTextField];
        
        _submitButton = [XWSubmitButton new];
        [_submitButton setEnabled:NO];
        [_submitButton setTitle:@"下一步"];
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
            [weakSelf.phoneTextField resignFirstResponder];
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.phoneTextField resignFirstResponder];
            [weakSelf.submitButton startCircleAnimation];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];
        
        [self setBgClickClickBlock:^{
            [weakSelf.phoneTextField resignFirstResponder];
        }];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}



- (void)phoneTextChanged:(UITextField *)textField
{
    NSString *phone = [_phoneTextField text];
    
    if ([[phone stringByReplacingOccurrencesOfString:@" " withString:@""] length] != 11)
    {
        [_submitButton setEnabled:NO];
    }
    else
    {
        [_submitButton setEnabled:YES];
    }
}


- (BOOL)validateNumber
{
    NSString *phone = [_phoneTextField text];
    if ([[phone stringByReplacingOccurrencesOfString:@" " withString:@""] length] != 11)
    {
        [XWUIHelper textFieldVerificationFailedAnimation:_phoneTextField];
        return NO;
    }
    return YES;
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        
        [self.phoneTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(15);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.phoneTextField.mas_width);
            make.height.mas_equalTo(self.phoneTextField.mas_height);
            make.left.mas_equalTo(self.phoneTextField.mas_left);
            make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(15);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(15);
            make.right.mas_equalTo(self.phoneTextField.mas_right).with.offset(15);
        }];


    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [self.phoneTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_topView.mas_bottom).with.offset(15);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.phoneTextField.mas_width);
            make.height.mas_equalTo(self.phoneTextField.mas_height);
            make.left.mas_equalTo(self.phoneTextField.mas_left);
            make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(10);
            make.right.mas_equalTo(self.phoneTextField.mas_right).with.offset(15);
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
