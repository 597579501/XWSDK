//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"



@interface XWPhoneLoginView : XWView
{
    UIImageView *_topView;
}

@property (nonatomic, strong) XWPhoneTextField *phoneTextField;
@property (nonatomic, strong) XWSubmitButton   *submitButton;

- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;
@end
