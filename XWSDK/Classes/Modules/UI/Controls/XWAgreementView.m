//

//  Created by 张熙文 on 2017/5/24.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWAgreementView.h"


#define kExplanationText                @"我同意XW“用户协议”"
//#define kExplanationTextRange           NSMakeRange (5, 6)
#define kExplanationTextRange           NSMakeRange (0, 4)

#if LOG_Manager
static Logger *logger = nil;
#endif


#if LOG_Manager
__attribute__((constructor)) static void Inject(void) {
    logger = [Logger new];
    logger.type = kLogTypeManager;
}
#endif

@interface XWAgreementView ()
@property (nonatomic, strong) UIButton *checkButton;
@end

@implementation XWAgreementView

- (instancetype)initWithText:(NSString *)textString
{
    self = [super init];
    if (self)
    {
        WS(weakSelf);
        _isCheck = YES;
        
        self.checkButton = [UIButton new];
        [self.checkButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            weakSelf.isCheck = !weakSelf.isCheck;
            UIImage *showImage = [UIImage imageNamed:@"XW_SDK_CheckboxYes"];
            UIImage *hideImage = [UIImage imageNamed:@"XW_SDK_Checkbox"];
            [weakSelf.checkButton setImage:weakSelf.isCheck ? showImage : hideImage
                                  forState:UIControlStateNormal];
            if (weakSelf.checkClickBlock)
            {
                weakSelf.checkClickBlock(weakSelf.isCheck);
            }
        }];
        
        [self.checkButton setImage:[UIImage imageNamed:@"XW_SDK_CheckboxYes"] forState:UIControlStateNormal];
        [self addSubview:self.checkButton];
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:textString];
        one.font = kTextFont;
        [one setColor:UIColorHex(0x77ADEE)];
        [one setTextHighlightRange:kExplanationTextRange
                             color:kMainColor
                   backgroundColor:UIColorHexAlpha(0x77ADEE, 0.2)
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                             if (weakSelf.labelClickBlock) {
                                 weakSelf.labelClickBlock();
                             }
                         }];
        [text appendAttributedString:one];
        
        CGSize size = CGSizeMake(100, CGFLOAT_MAX);
        YYTextLayout *userAgreementLayout = [YYTextLayout layoutWithContainerSize:size text:text];
        
        YYLabel *userAgreementLabel = [YYLabel new];
        userAgreementLabel.attributedText = text;
        userAgreementLabel.textAlignment = NSTextAlignmentCenter;
        userAgreementLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        userAgreementLabel.numberOfLines = 0;
        userAgreementLabel.size = userAgreementLayout.textBoundingSize;
        userAgreementLabel.textLayout = userAgreementLayout;
        [self addSubview:userAgreementLabel];
        
        
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(20);
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [userAgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.checkButton.mas_right).with.offset(5);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}


- (void)setCheckClickBlock:(checkClickBlock)checkClickBlock
{
    _checkClickBlock = checkClickBlock;
}


- (void)setLabelClickBlock:(labelClickBlock)labelClickBlock
{
    _labelClickBlock = labelClickBlock;
}


- (void)dealloc
{
#if LOG_Manager
    NSString *selfClass = NSStringFromClass([self class]);
    [logger log:@"%@ - dealloc", selfClass];
#endif
}


@end
