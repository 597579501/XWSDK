//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"

@interface XWPhoneTextField : UITextField<UITextFieldDelegate>
{
    UIView *_outsideBorderView;
}
@end


typedef void (^blockForCodeLabelTouchUpInside)(void);

@interface XWCodeTextField : UIView<UITextFieldDelegate>
{
    UIView *_outsideBorderView;
}
@property (nonatomic, copy) blockForCodeLabelTouchUpInside blockForCodeLabelTouchUpInside;
@property (nonatomic, strong, readonly) UITextField *codeTextField;
@property (nonatomic, strong) YYLabel     *codeLabel;

- (NSString *)text;
- (void)setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block;
- (void)setBlockForCodeLabelTouchUpInside:(blockForCodeLabelTouchUpInside)blockForCodeLabelTouchUpInside;

@end


@interface XWUsernameTextField : UITextField<UITextFieldDelegate>
{
    UIView *_outsideBorderView;
}
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) BOOL isLoginText;
- (void)showUserListButton;
- (void)setPlaceholder:(NSString *)text;

@end


@interface XWPasswordTextField : UITextField<UITextFieldDelegate>
{
    UIView *_outsideBorderView;
}
@end


