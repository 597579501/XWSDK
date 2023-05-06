//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWImageButton.h"
//#import "Logger.h"
//
//#if LOG_Manager
//static Logger *logger = nil;
//#endif


#if LOG_Manager
__attribute__((constructor)) static void Inject(void) {
    logger = [Logger new];
    logger.type = kLogTypeManager;
}
#endif

@implementation XWImageButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        _label = [YYLabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _label.numberOfLines = 0;
        [self addSubview:_label];
        
    }
    return self;
}


- (void)setImageButtonClickBlock:(imageButtonClickBlock)imageButtonClickBlock
{
    _imageButtonClickBlock = imageButtonClickBlock;
}


- (void)setTitle:(NSString *)title image:(UIImage *)image
{
    WS(weakSelf);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];

    
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen screenScale] orientation:UIImageOrientationUp];
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(25, 25) alignToFont:kFont(14) alignment:YYTextVerticalAlignmentCenter];
    [attributedString appendAttributedString:attachText];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", title] attributes:nil]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    [attributedString setTextHighlightRange:NSMakeRange(0, attributedString.length)
                         color:UIColorHex(0x000000)
               backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                     tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                                 if (weakSelf.imageButtonClickBlock) {
                                     weakSelf.imageButtonClickBlock();
                                 }
                     }];

    _label.attributedText = attributedString;

    CGSize size = CGSizeMake(200, CGFLOAT_MAX);
    YYTextLayout *userAgreementLayout = [YYTextLayout layoutWithContainerSize:size text:attributedString];
    _label.size = userAgreementLayout.textBoundingSize;
    _label.textLayout = userAgreementLayout;

    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(userAgreementLayout.textBoundingSize);
    }];

    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(userAgreementLayout.textBoundingSize);

    }];
}

- (void)dealloc
{
#if LOG_Manager
    NSString *selfClass = NSStringFromClass([self class]);
    [logger log:@"%@ - dealloc", selfClass];
#endif
}



@end
