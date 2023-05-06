//

//  Created by 熙文 张 on 17/6/1.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"

@interface XWResetPassWordView : XWView
{
    UIImageView *_logoImageView;
}

@property (nonatomic, strong) XWPasswordTextField *passwordTextField;
@property (nonatomic, strong) XWSubmitButton   *submitButton;

- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;
@end
