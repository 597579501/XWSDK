//

//  Created by 熙文 张 on 2017/11/9.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWUserListTableViewCell.h"

#define borderColor UIColorHex(0xC1C1C1)

@implementation XWUserListTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
        _userImageView = [UIImageView new];
        [_userImageView setImage:kImage(@"XW_SDK_Username")];
        [self.contentView addSubview:_userImageView];
        
        _userNameLabel = [UILabel new];
        [_userNameLabel setFont:kTextFont];
        [_userNameLabel setTextColor:UIColorHex(0x000000)];
        [self.contentView addSubview:_userNameLabel];
        
        _delButton = [UIButton new];
        UIImage *isSelectImage = [UIImage imageNamed:@"XW_SDK_UserListDel"];
        [_delButton setImage:isSelectImage forState:UIControlStateNormal];
        [self.contentView addSubview:_delButton];
        
        _lineView = [LineView new];
        _lineView.hidden = YES;
        [_lineView setStyle:LineHorizontaStyle];
        [self.contentView addSubview:_lineView];
        
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(5);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        
        
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userImageView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        [_delButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-3);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(40);
        }];
        
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setUserLoginRecordModel:(XWUserLoginRecordModel *)userLoginRecordModel
{
    _userLoginRecordModel = userLoginRecordModel;
    [_userNameLabel setText:userLoginRecordModel.username];
}

- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
    [_lineView setHidden:isLast];
}


@end
