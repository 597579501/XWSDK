//
//  

//  Created by 张熙文 on 2017/5/19.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWPhoneLoginViewController.h"
#import "XWCodeLoginViewController.h"
#import "XWPhoneLoginView.h"
//#import "XWUserSystemManager.h"

@interface XWPhoneLoginViewController ()
{
    
}
@property (nonatomic, strong) XWPhoneLoginView *phoneLoginView;

@end

@implementation XWPhoneLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _phoneLoginView = [XWPhoneLoginView new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    [self.view addSubview:_phoneLoginView];
    [_phoneLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [_phoneLoginView setBackButtonClickBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    
    [_phoneLoginView setSubmitButtonClickBlock:^{
        [[UIApplication sharedApplication].keyWindow endEditing:YES]; 
        [weakSelf.phoneLoginView.submitButton stopCircleAnimation];
        XWCodeLoginViewController *codeLoginViewController = [XWCodeLoginViewController new];
        [codeLoginViewController setCodeType:weakSelf.codeType];
        [weakSelf.navigationController pushViewController:codeLoginViewController animated:NO];
        NSString *phone = [NSString stringWithFormat:@"%@", weakSelf.phoneLoginView.phoneTextField.text];
        [codeLoginViewController setPhone:[weakSelf formatPhone:phone]];
        
    }];
}


- (NSString *)formatPhone:(NSString *)phone
{
    if (phone.length == 11)
    {
        NSString *leftString = [phone substringToIndex:3];
        NSString *middleString = [phone substringWithRange:NSMakeRange(3, 4)];
        NSString *rightString = [phone substringFromIndex:7];
        phone = [NSString stringWithFormat:@"%@ %@ %@", leftString, middleString, rightString];
        [self.phoneLoginView.submitButton setEnabled:YES];
        
    }
    return phone;
}


- (void)bgClick
{
    [super bgClick];
    [_phoneLoginView hiddenKeyBroad];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_phoneLoginView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_phoneLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

@end
