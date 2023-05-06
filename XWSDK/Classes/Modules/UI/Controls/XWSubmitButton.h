//

//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>
#import "XWSDKHeader.h"

typedef NS_ENUM(NSInteger, MKButtonStyle) {
    MKNormalStyle,
    MKNowStyle,
    MKSuccessStyle,
};



@interface XWSubmitButton : UIButton
{
    CAShapeLayer *_animationLayer;
    CADisplayLink *_link;
    CGFloat _size;
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
}


@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) MKButtonStyle buttonStyle;


- (void)startCircleAnimation;
- (void)stopCircleAnimation;
@end
