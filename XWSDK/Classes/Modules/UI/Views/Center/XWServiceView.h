//

//  Created by 熙文 张 on 17/6/5.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"

typedef void (^mobileLabelClickBlock)(NSString *mobile);
typedef void (^qqLabelClickBlock)(NSString *qq);
@interface XWServiceView : XWView
{
    
}


- (instancetype)initWithMobile:(NSString *)mobile qqServiceGroup:(NSString *)qqServiceGroup qqPlayerGroup:(NSString *)qqPlayerGroup;

- (void)setMobileLabelClickBlock:(mobileLabelClickBlock)mobileLabelClickBlock;
- (void)setQQLabelClickBlock:(qqLabelClickBlock)qqLabelClickBlock;

@end
