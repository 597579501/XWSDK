//

//  Created by 熙文 张 on 17/6/5.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWServiceViewController.h"
#import "XWServiceView.h"
#import "XWHelper.h"

@interface XWServiceViewController ()
{
    XWServiceView *_serviceView;
}

@end

@implementation XWServiceViewController

- (instancetype)initWithMobile:(NSString *)mobile qqServiceGroup:(NSString *)qqServiceGroup qqPlayerGroup:(NSString *)qqPlayerGroup
{
    self = [super init];
    if (self) {
        _serviceView = [[XWServiceView alloc] initWithMobile:(NSString *)mobile qqServiceGroup:(NSString *)qqServiceGroup qqPlayerGroup:(NSString *)qqPlayerGroup];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(weakSelf);
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:UIColorHexAlpha(0x0808080, 0.2)];
    
    [self.view addSubview:_serviceView];
    [_serviceView setClipsToBounds:YES];
    [_serviceView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];

    
    [_serviceView setBackButtonClickBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    
    [_serviceView setQQLabelClickBlock:^(NSString *qq) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = qq;
        [XWHUD showOnlyText:weakSelf.view text:@"复制成功"];
    }];
    
    [_serviceView setMobileLabelClickBlock:^(NSString *mobile) {
        [XWHelper callMobileWithWebView:mobile];
    }];
    
}   

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
