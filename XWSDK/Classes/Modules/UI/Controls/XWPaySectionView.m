//

//  Created by 熙文 张 on 17/5/31.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWPaySectionView.h"
#import "LineView.h"

@implementation XWPaySectionView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:kTableViewBGColor];
        
        UILabel *sectionLable = [UILabel new];
        _sectionLable = sectionLable;
        [sectionLable setFont:kSectionFont];
        [self addSubview:sectionLable];
        
        LineView *lineView = [LineView new];
        [lineView setStyle:LineHorizontaStyle];
        [self addSubview:lineView];
        
        [sectionLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(20);
            make.height.mas_equalTo(33);
            make.centerY.mas_equalTo(self.mas_centerY).with.offset(5);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(1);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [_sectionLable setText:text];
}
@end
