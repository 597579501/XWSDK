
//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XWView.h"

@interface XWMentLoadingHUD : XWView
{
    CGSize _size;
}
-(void)start;

-(void)hide;

+(XWMentLoadingHUD *)showIn:(UIView*)view;

+(XWMentLoadingHUD *)hideIn:(UIView*)view;

@end
