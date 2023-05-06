//

//  Created by 张熙文 on 2017/5/25.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"

@interface XWUserCenterView : XWView

@property (nonatomic, strong, readonly) UIButton *updateButton;
@property (nonatomic, strong, readonly) UIButton *bindButton;
@property (nonatomic, strong, readonly) UIButton *serviceButton;
@property (nonatomic, strong, readonly) UIButton *logoutButton;
@property (nonatomic, strong) NSString *phone;

- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;


@end
