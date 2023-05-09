//

//  Created by 张熙文 on 2017/5/25.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserCenterView.h"
#import "XWSDK.h"

@interface XWUserCenterView ()
{
    UILabel *_usernameDesLabel;
    UILabel *_phoneDesLabel;
    UILabel *_phoneLabel;
    UILabel *_vLabel;
}

@end

@implementation XWUserCenterView

static CGFloat buttonMargin = 25;

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:8];
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [self addSubview:backButton];
//
//        UIImageView *logoImageView = [UIImageView new];
//        [logoImageView setImage:kImage(@"XW_SDK_MainLogo2")];
//        [self addSubview:logoImageView];
        
        _usernameDesLabel = [UILabel new];
        [_usernameDesLabel setText:@"用  户  名："];
        [_usernameDesLabel setFont:kFont(14)];
        [_usernameDesLabel setTextColor:kTextColor];
        [self addSubview:_usernameDesLabel];
        
        NSString *username = [XWSDK sharedInstance].currUser.userName;
        UILabel *usernameLabel = [UILabel new];
        [usernameLabel setText:username];
        [usernameLabel setFont:kFont(14)];
        [usernameLabel setTextColor:kTextDetailColor];
        [self addSubview:usernameLabel];
        
        _phoneDesLabel = [UILabel new];
        [_phoneDesLabel setHidden:YES];
        [_phoneDesLabel setText:@"绑定手机："];
        [_phoneDesLabel setFont:kFont(14)];
        [_phoneDesLabel setTextColor:kTextColor];
        [self addSubview:_phoneDesLabel];
        
        _phoneLabel = [UILabel new];
        [_phoneLabel setHidden:YES];
        [_phoneLabel setText:self.phone];
        [_phoneLabel setFont:kFont(14)];
        [_phoneLabel setTextColor:kTextDetailColor];
        [self addSubview:_phoneLabel];
        
        UIImage *updateImage = kImage(@"XW_SDK_UpdateButton");
        _updateButton = [UIButton new];
        [_updateButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [_updateButton setImage:updateImage forState:UIControlStateNormal];
        [_updateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_updateButton setTitleColor:UIColorHex(0x464646) forState:UIControlStateHighlighted];
        [[_updateButton titleLabel] setFont:kTextFont];
        [_updateButton setTitle:@"修改密码" forState:UIControlStateNormal];
//        [_updateButton.layer setBorderWidth:0.5];
//        [_updateButton.layer setBorderColor:kLineViewColor.CGColor];
//        [_updateButton.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self addSubview:_updateButton];

        UIImage *binadImage = kImage(@"XW_SDK_BindButton");
        _bindButton = [UIButton new];
        [_bindButton setImage:binadImage forState:UIControlStateNormal];
        [_bindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bindButton setTitleColor:UIColorHex(0x464646) forState:UIControlStateHighlighted];
        [[_bindButton titleLabel] setFont:kTextFont];
        [_bindButton setTitle:@"绑定密保" forState:UIControlStateNormal];
//        [_bindButton.layer setBorderWidth:0.5];
//        [_bindButton.layer setBorderColor:kLineViewColor.CGColor];
//        [_bindButton.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self addSubview:_bindButton];
            
        UIImage *serviceButtonImage = kImage(@"XW_SDK_ServiceButton");
        _serviceButton = [UIButton new];
        [_serviceButton setImage:serviceButtonImage forState:UIControlStateNormal];
        [_serviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_serviceButton setTitleColor:UIColorHex(0x464646) forState:UIControlStateHighlighted];
        [[_serviceButton titleLabel] setFont:kTextFont];
        [_serviceButton setTitle:@"联系客服" forState:UIControlStateNormal];
//        [_serviceButton.layer setBorderWidth:0.5];
//        [_serviceButton.layer setBorderColor:kLineViewColor.CGColor];
//        [_serviceButton.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self addSubview:_serviceButton];


        UIImage *logoutButtonImage = kImage(@"XW_SDK_LogoutButton");
        _logoutButton = [UIButton new];
        [_logoutButton setImage:logoutButtonImage forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logoutButton setTitleColor:UIColorHex(0x464646) forState:UIControlStateHighlighted];
        [[_logoutButton titleLabel] setFont:kTextFont];
        [_logoutButton setTitle:@"切换账号" forState:UIControlStateNormal];
//        [_logoutButton.layer setBorderWidth:0.5];
//        [_logoutButton.layer setBorderColor:kLineViewColor.CGColor];
//        [_logoutButton.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self addSubview:_logoutButton];
        
        
        [self addBottomLineWithBth:_logoutButton];
        [self addBottomLineWithBth:_updateButton];
        [self addBottomLineWithBth:_serviceButton];
        [self addBottomLineWithBth:_bindButton];

        
        _vLabel = [UILabel new];
//        [_vLabel setText:[NSString stringWithFormat:@"V%@", XWSDK]];
        [_vLabel setFont:kFont(14)];
        [_vLabel setTextColor:kTextDetailColor];
        [self addSubview:_vLabel];
        
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(12);
        }];
        
//        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.centerX.mas_equalTo(self.mas_centerX);
//        }];
    
        
        [_usernameDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.updateButton.mas_left);
            make.top.mas_equalTo(backButton.mas_bottom).with.offset(5);
        }];
        
        [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_usernameDesLabel.mas_right);
            make.top.mas_equalTo(_usernameDesLabel.mas_top);
        }];
        
        [_phoneDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_usernameDesLabel.mas_left);
            make.top.mas_equalTo(_usernameDesLabel.mas_bottom).with.offset(15);
        }];
        
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneDesLabel.mas_right);
            make.top.mas_equalTo(_phoneDesLabel.mas_top);
        }];
        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    if (phone.length == 11)
    {
        WS(weakSelf)
        [_phoneDesLabel setHidden:NO];
        [_phoneLabel setHidden:NO];
        [_phoneLabel setText:phone];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.mas_centerX);
                make.height.mas_equalTo(60);
                make.top.mas_equalTo(_phoneDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];
        }
        else if (UIInterfaceOrientationIsLandscape(orientation))
        {
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.bindButton.mas_left).with.offset(0.5);
                make.height.mas_equalTo(80);
                make.top.mas_equalTo(_phoneDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];
        }
    
//            [self setNeedsUpdateConstraints];
//            [self updateConstraintsIfNeeded];
            
            [UIView animateWithDuration:0.1 animations:^{
                [self layoutIfNeeded];
            }];
        
    }
    
   
    
    
}



- (void)addBottomLineWithBth:(UIButton *)sender{
    
    UIColor  *color = [UIColor clearColor];
    
    if (sender == _updateButton) {
        color =  UIColorHex(0xff881b);
        
    }else if (sender == _bindButton){
        color =  UIColorHex(0xef694e);
        
    }else if (sender == _serviceButton){
        color =  UIColorHex(0x7687f1);
        
    }else if (sender == _logoutButton){
        color =  UIColorHex(0x6bcae6);
        
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view setBackgroundColor:color];
    [sender addSubview:view];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(sender);
//        make.left.right.mas_equalTo(sender);
        make.left.mas_equalTo(sender).offset(5);
        make.right.mas_equalTo(sender).offset(-5);
        make.height.mas_equalTo(1);
        
    }];
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{

    WS(weakSelf)
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        
        
        
        if (_phoneLabel.text.length > 2) {
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_centerX);
                make.height.mas_equalTo(60);
                make.top.mas_equalTo(_phoneDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];
            
            
        }else{
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_centerX);
                make.height.mas_equalTo(60);
                make.top.mas_equalTo(_usernameDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];
            
        }

        
        [_bindButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.updateButton.mas_right).with.offset(-0.5);
            make.top.mas_equalTo(weakSelf.updateButton.mas_top);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
        }];
        
        [_serviceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.updateButton.mas_left);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
            make.top.mas_equalTo(weakSelf.updateButton.mas_bottom).with.offset(-0.5);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
        }];
        
        [_logoutButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bindButton.mas_left);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
            make.top.mas_equalTo(weakSelf.serviceButton.mas_top);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
        }];
        
        [_vLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.serviceButton.mas_left);
            make.top.mas_equalTo(weakSelf.serviceButton.mas_bottom).with.offset(15);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(20);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_vLabel.mas_bottom).with.offset(buttonMargin);
            make.left.mas_equalTo(weakSelf.updateButton.mas_left).with.offset(-buttonMargin);
        }];
     
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        
        
        if (_phoneLabel.text.length > 2) {
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.bindButton.mas_left).with.offset(0.5);
                make.height.mas_equalTo(80);
                make.top.mas_equalTo(_phoneDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];

            
        }else{
            [_updateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.bindButton.mas_left).with.offset(0.5);
                make.height.mas_equalTo(80);
                make.top.mas_equalTo(_usernameDesLabel.mas_bottom).with.offset(20);
                make.width.mas_equalTo(120);
            }];

            
        }
        
        
        [_bindButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.mas_centerX);
            make.top.mas_equalTo(weakSelf.updateButton.mas_top);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
        }];
        
        [_serviceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bindButton.mas_right).with.offset(-0.5);
            make.top.mas_equalTo(weakSelf.updateButton.mas_top);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
        }];
        
        [_logoutButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_serviceButton.mas_right).with.offset(-0.5);
            make.top.mas_equalTo(weakSelf.updateButton.mas_top);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(weakSelf.updateButton.mas_height);
        }];
        
        [_vLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.updateButton.mas_left);
            make.top.mas_equalTo(weakSelf.updateButton.mas_bottom).with.offset(15);
            make.width.mas_equalTo(weakSelf.updateButton.mas_width);
            make.height.mas_equalTo(20);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_vLabel.mas_bottom).with.offset(buttonMargin);
            make.left.mas_equalTo(weakSelf.updateButton.mas_left).with.offset(-buttonMargin);
        }];
       
    }
    
    CGFloat totalHeight = (_updateButton.imageView.frame.size.height + _updateButton.titleLabel.frame.size.height) + 5;
    [_updateButton setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _updateButton.imageView.frame.size.height), 0.0, 0.0, -_updateButton.titleLabel.frame.size.width)];
    [_updateButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_updateButton.imageView.frame.size.width, -(totalHeight - _updateButton.titleLabel.frame.size.height),0.0)];
    
    [_bindButton setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _bindButton.imageView.frame.size.height), 0.0, 0.0, -_bindButton.titleLabel.frame.size.width)];
    [_bindButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_bindButton.imageView.frame.size.width, -(totalHeight - _bindButton.titleLabel.frame.size.height),0.0)];
    
    [_serviceButton setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _bindButton.imageView.frame.size.height), 0.0, 0.0, -_bindButton.titleLabel.frame.size.width)];
    [_serviceButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_bindButton.imageView.frame.size.width, -(totalHeight - _bindButton.titleLabel.frame.size.height),0.0)];
    
    [_logoutButton setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _bindButton.imageView.frame.size.height), 0.0, 0.0, -_bindButton.titleLabel.frame.size.width)];
    [_logoutButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_bindButton.imageView.frame.size.width, -(totalHeight - _bindButton.titleLabel.frame.size.height),0.0)];
    
    
    
    
    if (animated) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:duration animations:^{
            [self layoutIfNeeded];
        }];
    }
}

@end
