//

//  Created by 熙文 张 on 17/6/2.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"

@interface XWUpdatePassWordView : XWView
{
    UIImageView *_logoImageView;
}

@property (nonatomic, strong, readonly) XWPasswordTextField *oldPasswordTextField;
@property (nonatomic, strong, readonly) XWPasswordTextField *nPasswordTextField;
@property (nonatomic, strong, readonly) XWPasswordTextField *repeatPasswordTextField;
@property (nonatomic, strong, readonly) XWSubmitButton *submitButton;


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;


@end
