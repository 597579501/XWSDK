
//  Created by 熙文 张 on 17/6/7.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWAutoLoginView.h"
#import "XWMentLoadingHUD.h"

@interface XWAutoLoginView (){
    
    UIImageView *_logoImageView;

}

@end

@implementation XWAutoLoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:8];
        
//
        _logoImageView = [UIImageView new];
        [_logoImageView setImage:kImage(@"XW_SDK_MainLogo2")];
        [self addSubview:_logoImageView];
        
        _usernameLabel = [UILabel new];
        [_usernameLabel setFont:kTextFont];
        [_usernameLabel setTextColor:kTextDetailColor];
        [self addSubview:_usernameLabel];
        
        UIView *loadingView = [UIView new];
        [self addSubview:loadingView];
        [loadingView setBounds:CGRectMake(30, 0, 60, 60)];
        [XWMentLoadingHUD showIn:loadingView];
        
        _cancelButton = [UIButton new];
        [_cancelButton setTitle:@"切换用户" forState:UIControlStateNormal];
//        [_cancelButton setTitleColor:kMainColor forState:UIControlStateNormal];
//        [_cancelButton.layer setBorderColor:kMainColor.CGColor];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setBackgroundColor:XWAdapterHead];
//        [_cancelButton.layer setBorderWidth:1];
        [self addSubview:_cancelButton];
        
        
        WS(weakSelf)
        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.top.mas_equalTo(20);
        }];
        
     
        [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(10);
        }];
        
        [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.usernameLabel.mas_bottom).with.offset(0);
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(200);
            make.top.mas_equalTo(loadingView.mas_bottom).with.offset(5);
        }];

        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.cancelButton.mas_bottom).with.offset(15);
            make.right.mas_equalTo(weakSelf.cancelButton.mas_right).with.offset(15);
        }];
        
   
        
//        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//        [self updateRotationView:orientation animate:NO duration:0];
    }
    return self;
}


//- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
//{
//    CGFloat width = 250;
//    if (UIInterfaceOrientationIsPortrait(orientation))
//    {
//        [_logoImageView setImage:kImage(@"MK_SDK_MainLogo")];
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(20);
//        }];
//        
//        [_cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(15);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(40);
//        }];
//        
//      
//        
//        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(_submitButton.mas_bottom).with.offset(15);
//            make.right.mas_equalTo(self.phoneTextField.mas_right).with.offset(15);
//        }];
//        
//        
//    }
//    else if (UIInterfaceOrientationIsLandscape(orientation))
//    {
//        [_logoImageView setImage:kImage(@"MK_SDK_LanLogo")];
//        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(20);
//        }];
//        
//        [self.phoneTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_logoImageView.mas_right).with.offset(10);
//            make.top.mas_equalTo(15);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(40);
//        }];
//        
//        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(self.phoneTextField.mas_width);
//            make.height.mas_equalTo(self.phoneTextField.mas_height);
//            make.left.mas_equalTo(self.phoneTextField.mas_left);
//            make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
//        }];
//        
//        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(_logoImageView.mas_bottom).with.offset(10);
//            make.right.mas_equalTo(self.phoneTextField.mas_right).with.offset(15);
//        }];
//    }
//    
//    if (animated) {
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
//        
//        [UIView animateWithDuration:duration animations:^{
//            [self layoutIfNeeded];
//        }];
//    }
//}



@end
