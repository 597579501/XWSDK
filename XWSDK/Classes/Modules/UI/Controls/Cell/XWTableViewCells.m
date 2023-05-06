//

//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWTableViewCells.h"

@implementation XWTableViewCells

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _lineView = [LineView new];
        [_lineView setStyle:LineHorizontaStyle];
        [self.contentView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0.5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}


- (void)setLineLeftMargin:(int)left
{
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
}

- (void)setLineLeft:(MASViewAttribute *)left
{
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.bottom.mas_equalTo(0.5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
