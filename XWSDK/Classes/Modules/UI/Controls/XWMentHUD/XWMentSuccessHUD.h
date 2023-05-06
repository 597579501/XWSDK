//

//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XWView.h"

@interface XWMentSuccessHUD : XWView<CAAnimationDelegate>
{
    
}
-(void)start;

-(void)hide;

- (void)circleAnimation;
- (void)checkAnimation;

+(XWMentSuccessHUD *)showIn:(UIView*)view;

+(XWMentSuccessHUD *)hideIn:(UIView*)view;

@end
