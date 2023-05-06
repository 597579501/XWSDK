
#import "XWOrderInfoViewCell.h"

@implementation XWOrderInfoViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        CGSize size = CGSizeMake(100, CGFLOAT_MAX);
        NSMutableAttributedString *textLabelText = [[NSMutableAttributedString alloc] initWithString:@"订单号："];
        [textLabelText setFont:kTextFont];
        [textLabelText setColor:kTextColor];
        YYTextLayout *textLabelLayout = [YYTextLayout layoutWithContainerSize:size text:textLabelText];
        
        _textLabel = [YYLabel new];
        _textLabel.attributedText = textLabelText;
        [self.contentView addSubview:_textLabel];
        
        _detailTextLabel = [UILabel new];
        [_detailTextLabel setTextColor:kTextDetailColor];
        [_detailTextLabel setFont:kTextFont];
        [self.contentView addSubview:_detailTextLabel];
        
        _lineView = [LineView new];
        [_lineView setStyle:LineHorizontaStyle];
        [self.contentView addSubview:_lineView];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(textLabelLayout.textBoundingSize);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [_detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_textLabel.mas_right).with.offset(15);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.centerY.mas_equalTo(_textLabel.mas_centerY);
        }];
        
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0.5);
            make.left.mas_equalTo(_textLabel.mas_left);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}


- (void)setDetailTextColor:(UIColor *)detailTextColor
{
    _detailTextColor = detailTextColor;
    [_detailTextLabel setTextColor:detailTextColor];
}


///todo
//- (void)setinfoModel
//{
//    _infoModel = infoModel;
//    [_textLabel setText:payOrderInfoModel.orderKeyString];
//    [_detailTextLabel setText:payOrderInfoModel.orderValueString];
//}

- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_isLast ? self.contentView.mas_left : _textLabel.mas_left);
        make.bottom.mas_equalTo(0.5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}


@end
