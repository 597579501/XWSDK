//

//  Created by 熙文 张 on 17/6/5.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWServiceView.h"


@interface XWServiceView ()
@property (nonatomic, copy) mobileLabelClickBlock mobileLabelClickBlock;
@property (nonatomic, copy) qqLabelClickBlock qqLabelClickBlock;
@end

@implementation XWServiceView


- (instancetype)initWithMobile:(NSString *)mobile qqServiceGroup:(NSString *)qqServiceGroup qqPlayerGroup:(NSString *)qqPlayerGroup
{
    self = [super init];
    if (self) {
        WS(weakSelf);
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:8];
        
        if (!mobile || [mobile isEqualToString:@""]) mobile = @"9527";
        if (!qqServiceGroup || [qqServiceGroup isEqualToString:@""]) qqServiceGroup = @"89757";
        if (!qqPlayerGroup || [qqPlayerGroup isEqualToString:@""]) qqPlayerGroup = @"12831245";
        
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"XW_SDK_BarItem_Back_Highlighted"];
        UIButton *backButton = [UIButton new];
        [backButton setImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        [self addSubview:backButton];
        
//        UIImageView *logoImageView = [UIImageView new];
//        [logoImageView setImage:kImage(@"XW_SDK_FloatIcon")];
//        [self addSubview:logoImageView];
        
        UILabel *mobileDesLabel = [UILabel new];
        [mobileDesLabel setText:@"客服电话："];
        [mobileDesLabel setFont:kFont(14)];
        [mobileDesLabel setTextColor:kTextColor];
        [self addSubview:mobileDesLabel];
        
        NSMutableAttributedString *mobileAttributedString = [[NSMutableAttributedString alloc] initWithString:mobile];
        mobileAttributedString.font = kTextFont;
        mobileAttributedString.underlineColor = UIColorHex(0x6EB5E4);
        [mobileAttributedString setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, mobile.length)];
        [mobileAttributedString setTextHighlightRange:NSMakeRange(0, mobile.length)
                                                color:UIColorHex(0x6EB5E4)
                                      backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                                if (weakSelf.mobileLabelClickBlock) {
                                                    weakSelf.mobileLabelClickBlock(mobile);
                                                }
                                            }];

        
        YYLabel *mobileLabel = [YYLabel new];
        [mobileLabel setAttributedText:mobileAttributedString];
        [self addSubview:mobileLabel];
        
        
        UILabel *qqServiceDesLabel = [UILabel new];
        [qqServiceDesLabel setText:@"客服  QQ："];
        [qqServiceDesLabel setFont:kFont(14)];
        [qqServiceDesLabel setTextColor:kTextColor];
        [self addSubview:qqServiceDesLabel];
        
        NSMutableAttributedString *qqServiceAttributedString = [[NSMutableAttributedString alloc] initWithString:qqServiceGroup];
        qqServiceAttributedString.font = kTextFont;
        qqServiceAttributedString.underlineColor = UIColorHex(0x6EB5E4);
        [qqServiceAttributedString setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, qqServiceGroup.length)];
        [qqServiceAttributedString setTextHighlightRange:NSMakeRange(0, qqServiceGroup.length)
                                                color:UIColorHex(0x6EB5E4)
                                      backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                                if (weakSelf.qqLabelClickBlock) {
                                                    weakSelf.qqLabelClickBlock(qqServiceGroup);
                                                }
                                            }];
        
        
        YYLabel *qqServiceLabel = [YYLabel new];
        [qqServiceLabel setAttributedText:qqServiceAttributedString];
        [self addSubview:qqServiceLabel];
        
        
        UILabel *qqPlayerDesLabel = [UILabel new];
        [qqPlayerDesLabel setText:@"玩家QQ群："];
        [qqPlayerDesLabel setFont:kFont(13)];
        [qqPlayerDesLabel setTextColor:kTextColor];
        [self addSubview:qqPlayerDesLabel];
        
        NSMutableAttributedString *qqPlayerAttributedString = [[NSMutableAttributedString alloc] initWithString:qqPlayerGroup];
        qqPlayerAttributedString.font = kTextFont;
        qqPlayerAttributedString.underlineColor = UIColorHex(0x6EB5E4);
        [qqPlayerAttributedString setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, qqPlayerGroup.length)];
        [qqPlayerAttributedString setTextHighlightRange:NSMakeRange(0, qqPlayerGroup.length)
                                                   color:UIColorHex(0x6EB5E4)
                                         backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                               tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                                   if (weakSelf.qqLabelClickBlock) {
                                                       weakSelf.qqLabelClickBlock(qqServiceGroup);
                                                   }
                                               }];
        
        YYLabel *qqPlayerLabel = [YYLabel new];
        [qqPlayerLabel setAttributedText:qqPlayerAttributedString];
        [self addSubview:qqPlayerLabel];
        
        
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(5);
        }];
        
//        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
////            make.centerX.mas_equalTo(self.mas_centerX);
//            make.right.mas_equalTo(self.mas_right).offset(-10);
//        }];
        
        
        [mobileDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backButton.mas_bottom).with.offset(10);
            make.left.mas_equalTo(15);

        }];
        
        [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(mobileDesLabel.mas_top);
            make.left.mas_equalTo(mobileDesLabel.mas_right).with.offset(0);
        }];
        
        [qqServiceDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(mobileDesLabel.mas_bottom).with.offset(10);
            make.left.mas_equalTo(mobileDesLabel.mas_left);
        }];
        
        [qqServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(qqServiceDesLabel.mas_top);
            make.left.mas_equalTo(qqServiceDesLabel.mas_right).with.offset(0);
        }];
        
        [qqPlayerDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(qqServiceDesLabel.mas_bottom).with.offset(10);
            make.left.mas_equalTo(qqServiceDesLabel.mas_left);
        }];
    
        
        [qqPlayerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(qqPlayerDesLabel.mas_top);
            make.left.mas_equalTo(qqPlayerDesLabel.mas_right).with.offset(0);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(qqPlayerDesLabel.mas_bottom).with.offset(25);
            make.left.mas_equalTo(qqServiceDesLabel.mas_left).with.offset(-15);
            make.width.mas_equalTo(260);
          
        }];

        
        [backButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weakSelf.backButtonClickBlock) {
                weakSelf.backButtonClickBlock();
            }
        }];
    }
    return self;
}


- (void)setMobileLabelClickBlock:(mobileLabelClickBlock)mobileLabelClickBlock
{
    _mobileLabelClickBlock = mobileLabelClickBlock;
}


- (void)setQQLabelClickBlock:(qqLabelClickBlock)qqLabelClickBlock
{
    _qqLabelClickBlock = qqLabelClickBlock;
}


@end
