//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWTextField.h"
#import "XWHelper.h"

#define outsideBorderColor UIColorHex(0xC6E0FF)
#define insideBorderColor UIColorHex(0xC1C1C1)
#define textForegroundColor UIColorHex(0xB8B8B8)
#define textTintColor UIColorHex(0xB8B8B8)

@implementation XWPhoneTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *leftView = [UIView new];
        [leftView setFrame:CGRectMake(0, 0, 40, 26)];

        UILabel *leftLabel = [UILabel new];
        [leftLabel setFrame:CGRectMake(5, 0, 30, 26)];
        [leftLabel setFont:kTextFont];
        [leftLabel setText:@"+86"];
        [leftView addSubview:leftLabel];
        
        
        _outsideBorderView = [UIView new];
        [_outsideBorderView setUserInteractionEnabled:NO];
        [_outsideBorderView.layer setBorderColor:XWAdapterBorde.CGColor];

        [_outsideBorderView.layer setBorderWidth:2];
        [_outsideBorderView.layer setCornerRadius:5];
        [self addSubview:_outsideBorderView];
        [_outsideBorderView setHidden:YES];
        
        [_outsideBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-1.0, -1.0, -1.0, -1.0));
        }];
        
        [self setText:@""];
        [self setTintColor:textTintColor];
        [self setKeyboardType:UIKeyboardTypeNumberPad];
        [self setDelegate:self];
        [self setLeftViewMode:UITextFieldViewModeAlways];
        [self setReturnKeyType:UIReturnKeySend];
        [self setLeftView:leftView];
        [self setFont:kTextFont];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.layer setBorderColor:insideBorderColor.CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setCornerRadius:5];
        
        
        NSAttributedString *phoneAttributedString = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName : textForegroundColor}];
        [self setAttributedPlaceholder:phoneAttributedString];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1 && string.length == 0)
    {
        return YES;
    }
    if ([XWHelper validateNumber:string])
    {
        BOOL returnValue = YES;
        NSMutableString *newText = [NSMutableString stringWithCapacity:0];
        // 拿到原有text,根据下面判断可能给它添加" "(空格);
        [newText appendString:textField.text];
        
        NSString *noBlankStr = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];
        NSInteger textLength = [noBlankStr length];
        
        if (string.length) {
            //这个11是控制实际字符串长度,比如电话号码长度
            if (textLength < 11) {
                if (textLength > 0 && textLength < 4 && textLength % 3 == 0)
                {
                    newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                    [newText appendString:@" "];
                    [newText appendString:string];
                    textField.text = newText;
                    returnValue = NO;
                    //return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturn YES的话,你会发现会多出一个字符串
                }
                else if (textLength > 5  && textLength % 7 == 0)
                {
                    newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                    [newText appendString:@" "];
                    [newText appendString:string];
                    textField.text = newText;
                    returnValue = NO;
                    //return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturn YES的话,你会发现会多出一个字符串
                }
                else
                {
                    [newText appendString:string];
                }
            }
            else
            {   // 比11长的话 return NO这样输入就无效了
                returnValue = NO;
            }
        }
        else
        {
            returnValue =  NO;
        }
        return returnValue;
    }
    return NO;
}





@end


@implementation XWCodeTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        
        [self.layer setBorderColor:insideBorderColor.CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setCornerRadius:5];
        
        
        NSMutableAttributedString *codeLabelAttributedString = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
        
        [codeLabelAttributedString setTextHighlightRange:codeLabelAttributedString.rangeOfAll
                                     color:kMainColor
                           backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.120]
                                 tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                     if (weakSelf.blockForCodeLabelTouchUpInside) {
                                         weakSelf.blockForCodeLabelTouchUpInside();
                                     }
                                 }];
        
        
        self.codeLabel = [YYLabel new];
        [self.codeLabel setAttributedText:codeLabelAttributedString];
        [self.codeLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.codeLabel];
        
        LineView *codeLineView = [LineView new];
        [codeLineView setStyle:LineVerticalStyle];
        [codeLineView setLineColor:kLineViewColor];
        [self addSubview:codeLineView];
        
        
        UIView *leftView = [UIView new];
        [leftView setFrame:CGRectMake(0, 0, 35, 25)];
        
        
        UIImageView *leftImageView = [UIImageView new];
        [leftImageView setFrame:CGRectMake(5, 0, 25, 25)];
        [leftImageView setImage:kImage(@"XW_SDK_sms")];
        [leftView addSubview:leftImageView];
        
        
        _outsideBorderView = [UIView new];
        [_outsideBorderView setUserInteractionEnabled:NO];
        [_outsideBorderView.layer setBorderColor:outsideBorderColor.CGColor];
        [_outsideBorderView.layer setBorderWidth:2];
        [_outsideBorderView.layer setCornerRadius:5];
        [self addSubview:_outsideBorderView];
        [_outsideBorderView setHidden:YES];
        
        [_outsideBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-1.0, -1.0, -1.0, -1.0));
        }];
        
        UITextField *codeTextField = [UITextField new];
        [codeTextField setText:@""];
        [codeTextField setTintColor:textTintColor];
        [codeTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [codeTextField setDelegate:self];
        [codeTextField setLeftViewMode:UITextFieldViewModeAlways];
        [codeTextField setLeftView:leftView];
        [codeTextField setReturnKeyType:UIReturnKeySend];
        [codeTextField setFont:kTextFont];
        [codeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:codeTextField];
        _codeTextField = codeTextField;
        
        NSAttributedString *codeTextAttributedString = [[NSAttributedString alloc] initWithString:@"请输入短信验证码" attributes:@{NSForegroundColorAttributeName : textForegroundColor}];
        [codeTextField setAttributedPlaceholder:codeTextAttributedString];
        
        
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        
        [codeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.codeLabel.mas_left).with.offset(-5);
            make.top.mas_equalTo(2);
            make.bottom.mas_equalTo(-2);
            make.width.mas_equalTo(1);
        }];
        
        [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(codeLineView.mas_left).with.offset(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
//        [_codeTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
//            NSLog(@"123123");
//        }];
        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:YES];
}

- (void)setBlockForCodeLabelTouchUpInside:(blockForCodeLabelTouchUpInside)blockForCodeLabelTouchUpInside
{
    _blockForCodeLabelTouchUpInside = blockForCodeLabelTouchUpInside;
}


- (NSString *)text
{
    return _codeTextField.text;
}



- (void)setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block
{
    __weak UITextField *codeTextField = _codeTextField;
    [_codeTextField setBlockForControlEvents:controlEvents block:^(id  _Nonnull sender) {
        if (block) {
            block(codeTextField);
        }
    }];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1 && string.length == 0)
    {
        return YES;
    }
    else if (textField.text.length >= 6)
    {
        textField.text = [textField.text substringToIndex:6];
        return NO;
    }
    return [XWHelper validateNumber:string];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}




@end

#define kTextKeyLimit @"QWERTYUIOPASDFGHJKLZXCVBNMQWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm"

@implementation XWUsernameTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *leftView = [UIView new];
        [leftView setFrame:CGRectMake(0, 0, 35, 25)];

        UIImageView *leftImageView = [UIImageView new];
        [leftImageView setFrame:CGRectMake(5, 0, 25, 25)];
        [leftImageView setImage:kImage(@"XW_SDK_Username")];
        [leftView addSubview:leftImageView];
        
        self.rightButton = [UIButton new];
        [self.rightButton setImage:kImage(@"XW_SDK_UserListDropDown") forState:UIControlStateNormal];
        [self.rightButton setFrame:CGRectMake(0, 0, 35, 40)];
        
        _outsideBorderView = [UIView new];
        [_outsideBorderView setUserInteractionEnabled:NO];
        [_outsideBorderView.layer setBorderColor:XWAdapterBorde.CGColor];
        [_outsideBorderView.layer setBorderWidth:2];
        [_outsideBorderView.layer setCornerRadius:5];
        [self addSubview:_outsideBorderView];
        [_outsideBorderView setHidden:YES];
        
        [_outsideBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-1.0, -1.0, -1.0, -1.0));
        }];
        
        [self setText:@""];
        [self setTintColor:textTintColor];
        [self setKeyboardType:UIKeyboardTypeASCIICapable];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setDelegate:self];
        
        [self setLeftView:leftView];
        [self setRightView:self.rightButton];
        
        [self setLeftViewMode:UITextFieldViewModeAlways];
        [self setReturnKeyType:UIReturnKeyNext];
        [self setFont:kTextFont];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.layer setBorderColor:insideBorderColor.CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setCornerRadius:5];
    }
    return self;
}



- (void)showUserListButton
{
    [self setRightViewMode:UITextFieldViewModeAlways];
}

- (void)setPlaceholder:(NSString *)text
{
    NSAttributedString *usernameAttributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : textForegroundColor}];
    [self setAttributedPlaceholder:usernameAttributedString];
}


- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //注册限制首字符是字母
    if (!self.isLoginText) {
        if (range.location == 0) {
            BOOL res = YES;
            NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:kTextKeyLimit];
            int i = 0;
            while (i < string.length) {
                NSString *tempString = [string substringWithRange:NSMakeRange(i, 1)];
                NSRange range = [tempString rangeOfCharacterFromSet:tmpSet];
                if (range.length == 0) {
                    res = NO;
                    break;
                }
                i++;
            }
            return res;
        }
        
    }
    
    if (range.length == 1 && string.length == 0)
    {
        return YES;
    }
    else if (textField.text.length >= 16)
    {
        textField.text = [textField.text substringToIndex:16];
        return NO;
    }
    return YES;
}

@end


@implementation XWPasswordTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *leftView = [UIView new];
        [leftView setFrame:CGRectMake(0, 0, 35, 25)];
        
        UIImageView *leftImageView = [UIImageView new];
        [leftImageView setFrame:CGRectMake(5, 0, 25, 25)];
        [leftImageView setImage:kImage(@"XW_SDK_password")];
        [leftView addSubview:leftImageView];
        
        _outsideBorderView = [UIView new];
        [_outsideBorderView setUserInteractionEnabled:NO];
        [_outsideBorderView.layer setBorderColor:XWAdapterBorde.CGColor];
        [_outsideBorderView.layer setBorderWidth:2];
        [_outsideBorderView.layer setCornerRadius:5];
        [self addSubview:_outsideBorderView];
        [_outsideBorderView setHidden:YES];
        
        [_outsideBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-1.0, -1.0, -1.0, -1.0));
        }];
        
        [self setSecureTextEntry:YES];
        [self setText:@""];
        [self setTintColor:textTintColor];
        [self setKeyboardType:UIKeyboardTypeASCIICapable];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setReturnKeyType:UIReturnKeySend];
        [self setDelegate:self];
        [self setLeftView:leftView];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setLeftViewMode:UITextFieldViewModeAlways];
        [self setFont:kTextFont];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.layer setBorderColor:insideBorderColor.CGColor];
        [self.layer setCornerRadius:5];
        [self.layer setBorderWidth:0.5];
        
        NSAttributedString *passwordAttributedString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : textForegroundColor}];
        [self setAttributedPlaceholder:passwordAttributedString];
        
    }
    return self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1 && string.length == 0)
    {
        return YES;
    }
    else if (textField.text.length >= 16)
    {
        textField.text = [textField.text substringToIndex:16];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_outsideBorderView setHidden:YES];
}



@end
