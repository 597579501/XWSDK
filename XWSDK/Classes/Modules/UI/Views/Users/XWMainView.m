//
//  MainView.m

//
//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWMainView.h"
#import "XWUIMacor.h"

@implementation XWMainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:8];
        
        CGFloat size = 60;
        CGFloat buttonMargin = 25;
        CGFloat labelTopMargin = 8;
        
//        self.backgroundColor = [UIColor orangeColor];
        UIImageView *logoImageView = [UIImageView new];
        [logoImageView setImage:kImage(@"XW_SDK_MainLogo2")];
        [self addSubview:logoImageView];
        
        UILabel *changeLoginTypeLabel = [UILabel new];
        [changeLoginTypeLabel setFont:kTextFont];
        [changeLoginTypeLabel setTextColor:UIColorHex(0x848484)];
        [changeLoginTypeLabel setText:@"选择注册方式"];
        [self addSubview:changeLoginTypeLabel];
        
        
        UIButton *phoneRegisterButton = [UIButton new];
        [self addSubview:phoneRegisterButton];
        _phoneRegisterButton = phoneRegisterButton;
        
        UILabel *phoneRegisterLabel = [UILabel new];
        [phoneRegisterLabel setText:@"手机注册"];
        [phoneRegisterLabel setFont:kFont(13)];
        [phoneRegisterLabel setTextColor:UIColorHex(0x141414)];
        [self addSubview:phoneRegisterLabel];
        _phoneRegisterLabel = phoneRegisterLabel;
        
        UIButton *visitorsvButtton = [UIButton new];
        [self addSubview:visitorsvButtton];
        _visitorsButtton = visitorsvButtton;
        
        UILabel *visitorsvLabel = [UILabel new];
        [visitorsvLabel setText:@"一键注册"];
        [visitorsvLabel setFont:kFont(13)];
        [visitorsvLabel setTextColor:UIColorHex(0x141414)];
        [self addSubview:visitorsvLabel];
        _visitorsvLabel = visitorsvLabel;
        
        UIButton *userLoginButton = [UIButton new];
        [self addSubview:userLoginButton];
        _userLoginButton = userLoginButton;

        UILabel *userLoginLabel = [UILabel new];
        [userLoginLabel setText:@"账号登录"];
        [userLoginLabel setFont:kFont(13)];
        [userLoginLabel setTextColor:UIColorHex(0x141414)];
        [self addSubview:userLoginLabel];
        _userLoginLabel = userLoginLabel;
        
        UIImage *phoneRegisterButtonImage = kImage(@"XW_SDK_PhoneRegisterButton-Portrait");
        UIImage *visitorsvButttonImage = kImage(@"XW_SDK_VisitorsvButton-Portrait");
        UIImage *userLoginButtonImage = kImage(@"XW_SDK_UserLoginButton-Portrait");
        [_phoneRegisterButton setImage:phoneRegisterButtonImage forState:UIControlStateNormal];
        [_visitorsButtton setImage:visitorsvButttonImage forState:UIControlStateNormal];
        [_userLoginButton setImage:userLoginButtonImage forState:UIControlStateNormal];
        
//        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(40);
//            make.top.mas_equalTo(10);
//            make.left.mas_equalTo(10);
//        }];
        
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [changeLoginTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(logoImageView.mas_bottom).with.offset(10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [phoneRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(changeLoginTypeLabel.mas_bottom).with.offset(20);
            make.width.mas_equalTo(67);
            make.height.mas_equalTo(size);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [visitorsvButtton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneRegisterButton.mas_top);
            make.size.mas_equalTo(phoneRegisterButton.mas_height);
            make.right.mas_equalTo(phoneRegisterButton.mas_left).with.offset(-buttonMargin);
        }];
        
        [userLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneRegisterButton.mas_top);
            make.size.mas_equalTo(phoneRegisterButton.mas_height);
            make.left.mas_equalTo(phoneRegisterButton.mas_right).with.offset(buttonMargin - 7);
        }];
        
        [phoneRegisterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneRegisterButton.mas_bottom).with.offset(labelTopMargin);
            make.centerX.mas_equalTo(phoneRegisterButton.mas_centerX);
        }];
        
        [visitorsvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneRegisterLabel.mas_top);
            make.centerX.mas_equalTo(visitorsvButtton.mas_centerX);
        }];
        
        [userLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneRegisterLabel.mas_top);
            make.centerX.mas_equalTo(userLoginButton.mas_centerX);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(phoneRegisterLabel.mas_bottom).with.offset(buttonMargin);
            make.left.mas_equalTo(visitorsvButtton.mas_left).with.offset(-buttonMargin);
            
            
        }];
        
        
//        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//            if (weakSelf.backButtonClickBlock) {
//                weakSelf.backButtonClickBlock();
//            }
//        }];
        
        
        [visitorsvButtton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.visitorsButtonClickBlock) {
                weakSelf.visitorsButtonClickBlock();
            }
        }];
        
        [phoneRegisterButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.phoneRegisterButtonClickBlock) {
                weakSelf.phoneRegisterButtonClickBlock();
            }
        }];
        
        [userLoginButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.userLoginButtonClickBlock) {
                weakSelf.userLoginButtonClickBlock();
            }
        }];
    }
    return self;
}


- (void)setUserLoginButtonClickBlock:(userLoginButtonClickBlock)userLoginButtonClickBlock
{
    _userLoginButtonClickBlock = userLoginButtonClickBlock;
}


- (void)setVisitorsButtonClickBlock:(visitorsButtonClickBlock)visitorsButtonClickBlock
{
    _visitorsButtonClickBlock = visitorsButtonClickBlock;
}


- (void)setPhoneRegisterButtonClickBlock:(phoneRegisterButtonClickBlock)phoneRegisterButtonClickBlock
{
    _phoneRegisterButtonClickBlock = phoneRegisterButtonClickBlock;
}



@end
