//

//  Created by 张熙文 on 2017/5/23.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"
#import "XWTextField.h"
#import "XWSubmitButton.h"
#import "XWSDKEnumHeader.h"

typedef void (^blockForCodeLabelTouchUpInside)(void);

@interface XWCodeLoginView : XWView
{
    BOOL _isCountDown;
    UILabel     *_phoneDescLabel;
    UIImageView *_topView;
    UILabel *_subTitleLabel;
}
@property (nonatomic, strong) XWCodeTextField *codeTextField;
@property (nonatomic, strong) XWPasswordTextField *passwordTextField;
@property (nonatomic, strong) XWSubmitButton  *submitButton;
@property (nonatomic, strong) NSString        *phone;
@property (nonatomic, assign) XWCodeType         codeType;
@property (nonatomic, copy) blockForCodeLabelTouchUpInside blockForCodeLabelTouchUpInside;
- (void)setBlockForCodeLabelTouchUpInside:(blockForCodeLabelTouchUpInside)blockForCodeLabelTouchUpInside;
- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)codeLabelCountDown:(NSNumber *)second;

@end
