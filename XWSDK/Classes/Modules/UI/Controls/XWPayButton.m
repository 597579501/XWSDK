//

//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWPayButton.h"
#import "XWmentSuccessHUD.h"
#import "XWmentLoadingHUD.h"

#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]
#define WhiteColor [UIColor whiteColor]


@implementation XWPayButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:kImage(@"XW_SDK_Button_Normal") forState:UIControlStateNormal];
        [self setBackgroundImage:kImage(@"XW_SDK_Button_Highlighted") forState:UIControlStateHighlighted];
        [self setBackgroundImage:kImage(@"XW_SDK_Button_Disabled") forState:UIControlStateDisabled];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    _size = self.bounds.size.height / 2;
}




- (void)excuting
{
    //隐藏支付完成动画
    [XWMentSuccessHUD hideIn:self];
    //显示支付中动画
    [XWMentLoadingHUD showIn:self];
}


- (void)paySuccess
{
    
    //隐藏支付中成动画
    [XWMentLoadingHUD hideIn:self];
    //显示支付完成动画
    XWMentSuccessHUD *hud = [XWMentSuccessHUD showIn:self];
    
    [hud circleAnimation];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self setTitle:@"下单成功"];
        [hud checkAnimation];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void){
            [self setTitle:@"确认支付"];
            
        });
    });
    
    
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

@end
