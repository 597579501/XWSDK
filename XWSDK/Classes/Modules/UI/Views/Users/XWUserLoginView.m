//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserLoginView.h"
#import "XWSubmitButton.h"
#import "XWTextField.h"
#import "XWUserListTableViewCell.h"

@implementation XWUserLoginView

- (instancetype)initWithUserCount:(NSUInteger)count
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        _count = count;
        
        [self addObserver:self forKeyPath:@"userArray" options:NSKeyValueObservingOptionNew context:nil];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:3];
        
        UIImageView *topView = [UIImageView new];
//        UIImage *loginTopImage = kImage(@"MK_SDK_LoginTop");
//        [topView setImage:loginTopImage];
        //原色
//        [topView setBackgroundColor:UIColorHex(0x77aeee)];
      

        [topView setBackgroundColor:XWAdapterHead];

        [topView setUserInteractionEnabled:YES];
        [self addSubview:topView];
        
        UILabel *companyLabel = [UILabel new];
        [companyLabel setTextColor:[UIColor whiteColor]];
        [companyLabel setText:@"账号登陆"];
//        [companyLabel setFont:kFont(17)];
        [companyLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:17]];
        [topView addSubview:companyLabel];
        
//        LineView *lineView = [LineView new];
//        [lineView setLineColor:[UIColor whiteColor]];
//        [lineView setStyle:LineVerticalStyle];
//        [topView addSubview:lineView];
//
//        UILabel *subTitleLabel = [UILabel new];
//        [subTitleLabel setTextColor:[UIColor whiteColor]];
//        [subTitleLabel setText:@"账号登录"];
//        [subTitleLabel setFont:kFont(12)];
//        [topView addSubview:subTitleLabel];
        
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeViewAction)];
//        [topView addGestureRecognizer:tapGesture];
        
        
        
        self.usernameTextField = [XWUsernameTextField new];
        
        [self.usernameTextField setPlaceholder:@"请输入账号"];
        [self.usernameTextField showUserListButton];
        [self.usernameTextField.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_usernameTextField setIsLoginText:YES];
        [self addSubview:_usernameTextField];
        
        self.passwordTextField = [XWPasswordTextField new];
        
        [self addSubview:self.passwordTextField];
        
//        _autoLoginAgreementView = [[XWAgreementView alloc] initWithText:@"自动登录"];
//        [self addSubview:_autoLoginAgreementView];
        
        _userAgreementView = [XWUserAgreementView new];
        [self addSubview:_userAgreementView];
        
        [_userAgreementView setCheckClickBlock:^(BOOL isCheck) {
            [weakSelf textChanged];
        }];

        
        NSMutableAttributedString *forgetText = [NSMutableAttributedString new];
        NSMutableAttributedString *labelText = [[NSMutableAttributedString alloc] initWithString:@"忘记密码"];
        labelText.font = kTextFont;
        [labelText setColor:XWAdapterFont];
        [labelText setTextHighlightRange:NSMakeRange (0, 4)
                                   color:XWAdapterFont
                         backgroundColor:XWAdapterHead
                               tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                   if (weakSelf.forgetLabelClickBlock) {
                                       weakSelf.forgetLabelClickBlock();
                                   }
                               }];
        [forgetText appendAttributedString:labelText];
        
        CGSize size = CGSizeMake(100, CGFLOAT_MAX);
        YYTextLayout *forgetTextLayout = [YYTextLayout layoutWithContainerSize:size text:forgetText];
        
        YYLabel *forgetLabel = [YYLabel new];
        forgetLabel.attributedText = forgetText;
        forgetLabel.textAlignment = NSTextAlignmentRight;
        forgetLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        forgetLabel.numberOfLines = 0;
        forgetLabel.size = forgetTextLayout.textBoundingSize;
        forgetLabel.textLayout = forgetTextLayout;
        [self addSubview:forgetLabel];
        _forgetLabel = forgetLabel;

        _submitButton = [XWSubmitButton new];
        [_submitButton setTitle:@"登录"];
        [_submitButton setEnabled:NO];
        [self addSubview:_submitButton];
 
        _registerButton = [XWSubmitButton new];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册"];
        [self addSubview:_registerButton];

        _userListTableView = [XWUserListTableView new];
        [_userListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_userListTableView setHidden:YES];
        [_userListTableView setDataSource:self];
        [_userListTableView setDelegate:self];
        [self addSubview:_userListTableView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.left.mas_equalTo(15);
        }];
        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(companyLabel.mas_right).offset(5);
//            make.centerY.mas_equalTo(companyLabel.mas_centerY).offset(2);
//            make.height.mas_equalTo(15);
//            make.width.mas_equalTo(1);
//        }];
//
//        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lineView.mas_right).offset(5);
//            make.centerY.mas_equalTo(lineView.mas_centerY);
//        }];
    
        
        
        
        [_userAgreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).offset(10);
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
        }];
        
        
        [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        
        [self.usernameTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [self.passwordTextField setBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            [weakSelf textChanged];
        }];
        
        [_submitButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.submitButton startCircleAnimation];
            if (weakSelf.submitButtonClickBlock) {
                weakSelf.submitButtonClickBlock();
            }
        }];

        
        [self setBgClickClickBlock:^{
            [weakSelf.usernameTextField resignFirstResponder];
            [weakSelf.passwordTextField resignFirstResponder];
        }];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        [self updateRotationView:orientation animate:NO duration:0];
        
    }
    return self;
}

- (void)registerButtonClick
{
    if (self.registerButtonClickBlock) {
        self.registerButtonClickBlock();
    }
}


- (void)rightButtonClick
{
    [UIView animateWithDuration:0.0f animations:^{
        if (_userListTableView.hidden) {
            [_usernameTextField.rightButton setTransform:CGAffineTransformMakeRotation(M_PI)];
        }
        else
        {
            [_usernameTextField.rightButton setTransform:CGAffineTransformMakeRotation(0)];
        }
        
    }];
    
    
    [_submitButton setEnabled:!_userListTableView.hidden];
    [_registerButton setEnabled:!_userListTableView.hidden];
    [_userListTableView setHidden:!_userListTableView.hidden];
}


- (void)textChanged
{
    
    NSString *username = [_usernameTextField text];
    NSString *password = [_passwordTextField text];
    [_submitButton setEnabled:(([[username stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                               && ([[password stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 6)
                               && _userAgreementView.isCheck)];
    
}



#pragma mark 关闭登录窗


- (void)showView{
    
    self.transform = CGAffineTransformMakeScale(0.35, 0.35);
    
    [UIView animateWithDuration:.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    
     
    }];
    
    
}


- (void)closeViewAction{
    
    [UIView animateWithDuration:.2
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }completion:^(BOOL finish){
                         
                         [UIView animateWithDuration:.3
                                          animations:^{
                                              self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                                          }completion:^(BOOL finish){
                                              
                                              if (self.headTapBlock) {
                                                  self.headTapBlock();
                                              }
                                              
                                          }];
                         
                         
                     }];
    
 
    
}


- (void)updateRotationView:(UIInterfaceOrientation)orientation animate:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat width = 250;
    CGFloat margin = 15;
    WS(weakSelf)
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        width = 250;
        
        [_usernameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(margin + 44);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_userListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.usernameTextField.mas_left);
            make.right.mas_equalTo(weakSelf.usernameTextField.mas_right);
            make.top.mas_equalTo(weakSelf.usernameTextField.mas_bottom).with.offset(2);
            if (_count >= 3) {
                make.height.mas_equalTo(40 * 3);
            }
            else
            {
                make.height.mas_equalTo(40 * _count);
            }
        }];
        
        [_passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.usernameTextField.mas_left);
            make.width.mas_equalTo(weakSelf.usernameTextField.mas_width);;
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.top.mas_equalTo(weakSelf.usernameTextField.mas_bottom).with.offset(10);
        }];
        
        
//        [_autoLoginAgreementView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.passwordTextField.mas_left);
//            make.top.mas_equalTo(self.passwordTextField.mas_bottom).with.offset(10);
//            make.width.mas_equalTo(120);
//            make.height.mas_equalTo(30);
//        }];
        
        [_userAgreementView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).offset(10);
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
        }];
        
        
        [_forgetLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];

        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_forgetLabel.mas_bottom).with.offset(10);
        }];
        
        
        [_registerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(weakSelf.submitButton.mas_height);
            make.width.mas_equalTo(weakSelf.submitButton.mas_width);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(weakSelf.submitButton.mas_top);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(weakSelf.usernameTextField.mas_right).with.offset(margin);
        }];
        
        
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        width = 300;

        [_usernameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.top.mas_equalTo(margin + 44);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(40);
        }];
        
        [_userListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.usernameTextField.mas_left);
            make.right.mas_equalTo(self.usernameTextField.mas_right);
            make.top.mas_equalTo(self.usernameTextField.mas_bottom).with.offset(2);
            if (_count >= 3) {
                make.height.mas_equalTo(40 * 3);
            }
            else
            {
                make.height.mas_equalTo(40 * _count);
            }
            
        }];
        
        [_passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.usernameTextField.mas_left);
            make.width.mas_equalTo(weakSelf.usernameTextField.mas_width);;
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.top.mas_equalTo(weakSelf.usernameTextField.mas_bottom).with.offset(10);
        }];

//        [_autoLoginAgreementView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.passwordTextField.mas_left);
//            make.top.mas_equalTo(self.passwordTextField.mas_bottom).with.offset(10);
//            make.width.mas_equalTo(120);
//            make.height.mas_equalTo(30);
//        }];
        
//        [_forgetLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
//            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).with.offset(10);
//            make.height.mas_equalTo(30);
//        }];
        
        [_userAgreementView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordTextField.mas_bottom).offset(10);
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
        }];
        
        
        [_forgetLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.passwordTextField.mas_right);
            make.top.mas_equalTo(_userAgreementView.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.43);
            make.height.mas_equalTo(weakSelf.usernameTextField.mas_height);
            make.right.mas_equalTo(_forgetLabel.mas_right);
            make.top.mas_equalTo(_forgetLabel.mas_bottom).with.offset(10);
        }];
        
        [_registerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(weakSelf.submitButton.mas_height);
            make.width.mas_equalTo(weakSelf.submitButton.mas_width);
            make.left.mas_equalTo(weakSelf.passwordTextField.mas_left);
            make.top.mas_equalTo(weakSelf.submitButton.mas_top);
        }];
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.submitButton.mas_bottom).with.offset(margin);
            make.right.mas_equalTo(weakSelf.usernameTextField.mas_right).with.offset(margin);
        }];

    }
    
    if (animated) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:duration animations:^{
            [self layoutIfNeeded];
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userArray count];
}


- (XWUserListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexRow = indexPath.row;
    XWUserListTableViewCell *cell = (XWUserListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"XWUserListTableViewCell"];
    if(cell == nil)
    {
        cell = [[XWUserListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MKUserListTableViewCell"];
    }
    
    [[cell delButton] addTarget:self action:@selector(deleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    XWUserLoginRecordModel *userLoginRecordModel = self.userArray[indexRow];
    [cell setUserLoginRecordModel:userLoginRecordModel];
    
    if (indexRow == _count - 1)
    {
        [cell setIsLast:YES];
        
    }
    else
    {
        [cell setIsLast:NO];
    }
    return cell;
}


- (void)deleButtonClick:(UIButton *)sender
{
    XWUserListTableViewCell *cell = (XWUserListTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_userListTableView indexPathForCell:cell];
    NSInteger row = [indexPath row];
    XWUserLoginRecordModel *userLoginRecordModel = self.userArray[row];
    [[self mutableArrayValueForKey:@"userArray"] removeObjectAtIndex:row];
    [_userListTableView reloadData];
    [_userListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.userArray.count >= 3) {
            make.height.mas_equalTo(40 * 3);
        }
        else
        {
            make.height.mas_equalTo(40 * self.userArray.count);
        }
    }];
    if ([userLoginRecordModel.username isEqualToString:_usernameTextField.text]) {
        [_usernameTextField setText:@""];
        [_passwordTextField setText:@""];
    }
    
    [_userListTableView layoutIfNeeded];
    if (self.delButtonClickBlock) {
        self.delButtonClickBlock(userLoginRecordModel.username);
    }
}


#pragma mark -- observeValueForKeyPath --
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"userArray"] && object == self)
    {
        if ([self.userArray count] <= 0)
        {
            [_usernameTextField.rightButton setEnabled:NO];
            [UIView animateWithDuration:0.0f animations:^{
                [_usernameTextField.rightButton setTransform:CGAffineTransformMakeRotation(0)];
            }];
            [_usernameTextField setText:@""];
            [_passwordTextField setText:@""];
            [_submitButton setEnabled:NO];
            [_registerButton setEnabled:YES];
            
        }
        else
        {
            [_usernameTextField.rightButton setEnabled:YES];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexRow = indexPath.row;
    XWUserLoginRecordModel *userLoginRecordModel = self.userArray[indexRow];
    [_usernameTextField setText:userLoginRecordModel.username];
    [_passwordTextField setText:userLoginRecordModel.password];
    [_userListTableView setHidden:YES];
    if (_userAgreementView.isCheck)
    {
        [_submitButton setEnabled:YES];
    }
    else
    {
        [_submitButton setEnabled:NO];
    }
    [_registerButton setEnabled:YES];
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"userArray"];
}


@end

