//

//  Created by 张熙文 on 2017/5/25.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserCenterViewController.h"
#import "XWUserCenterView.h"
#import "XWUpdatePassWordViewController.h"
#import "XWPhoneLoginViewController.h"
//#import "XWUserSystemManager.h"
#import "XWServiceViewController.h"
#import "XWUIHelper.h"
#import "XWSDK.h"

@interface XWUserCenterViewController ()
@property (nonatomic, strong) XWUserCenterView *userCenterView;
@end

@implementation XWUserCenterViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _userCenterView = [XWUserCenterView new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    WS(weakSelf)
    
    self.viewModel
    
    [DHUserSystemManager getUserCenterInfo:^(DHUserResponeModel *userResponeModel) {
        _userResponeModel = userResponeModel;
        NSLog(@"----------pring---log--%@",_userResponeModel.serviceMobile);
        NSLog(@"----------pring---log--%@",_userResponeModel.qqServiceGroup);
        NSLog(@"----------pring---log--%@",_userResponeModel.qqPlayerGroup);
        NSLog(@"----------pring---log--%@",_userResponeModel);

        [weakSelf.userCenterView setPhone:userResponeModel.phoneNumber];

    } failure:^(int errcode, NSString *errorMessage) {

    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:UIColorHexAlpha(0x0808080, 0.2)];
//    [self.view setBackgroundColor:[UIColor redColor]];

    [self.view addSubview:_userCenterView];
    
    WS(weakSelf)
    [_userCenterView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
    }];
    [[_userCenterView updateButton] setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        XWUpdatePassWordViewController *updatePassWordViewController = [XWUpdatePassWordViewController new];
        [weakSelf.navigationController pushViewController:updatePassWordViewController animated:NO];
    }];
    
    [[_userCenterView bindButton] setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (_userModel.userPhone.length == 11)
        {
            [XWUIHelper showAlertView:nil message:@"已绑定手机" cancelButtonTitle:@"确定" otherButtonTitles:nil];
        }
        else
        {
            XWPhoneLoginViewController *phoneLoginViewController = [XWPhoneLoginViewController new];
            [phoneLoginViewController setCodeType:XWBindCode];
            [weakSelf.navigationController pushViewController:phoneLoginViewController animated:NO];
        }
    }];
    
    [[_userCenterView serviceButton] setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        DHServiceViewController *serviceViewController = [[XWServiceViewController alloc] initWithMobile:_userResponeModel.serviceMobile qqServiceGroup:_userResponeModel.qqServiceGroup qqPlayerGroup:_userResponeModel.qqPlayerGroup];
//        [weakSelf.navigationController pushViewController:serviceViewController animated:NO];
    }];
    
    [[_userCenterView logoutButton] setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        UIAlertView *alertView = [DHUIHelper showAlertView:nil message:@"确认注销吗" cancelButtonTitle:@"确定" otherButtonTitles:@"取消"];
//        [alertView setDelegate:self];
           [weakSelf closeView];
           [[XWSDK sharedInstance] logoutAccount];
    }];
    

    
    [_userCenterView setBackButtonClickBlock:^{
        
        [weakSelf closeView];
    }];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0)
//    {
//
//        [self closeView];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[DHSDK share] lo];
//
//        });
//
//
//    }
//    else if (buttonIndex == 1)
//    {
//
//    }
//}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_userCenterView updateRotationView:toInterfaceOrientation animate:YES duration:duration];
    [_userCenterView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        
    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
