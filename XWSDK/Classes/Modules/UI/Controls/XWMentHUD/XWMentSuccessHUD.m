//

//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XWMentSuccessHUD.h"


static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;
static CGFloat lineWidth = 2.0f;
#define whiteColor [UIColor whiteColor]


@implementation XWMentSuccessHUD
{
    CALayer *_animationLayer;
}

//显示
+(XWMentSuccessHUD*)showIn:(UIView*)view{
    [self hideIn:view];
    XWMentSuccessHUD *hud = [[XWMentSuccessHUD alloc] initWithFrame:view.bounds];
//    [hud start];
    [view addSubview:hud];
    return hud;
}
//隐藏
+(XWMentSuccessHUD *)hideIn:(UIView *)view{
    XWMentSuccessHUD *hud = nil;
    for (XWMentSuccessHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[XWMentSuccessHUD class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

-(void)start{
    [self circleAnimation];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self checkAnimation];
    });
}

-(void)hide{
    for (CALayer *layer in _animationLayer.sublayers) {
        [layer removeAllAnimations];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI:frame.size];
    }
    return self;
}

-(void)buildUI:(CGSize)size{
    int width = 0;
    if (size.width > size.height)
    {
        width = size.height / 2;
    }
    else
    {
        width = size.width / 2;
    }
    _animationLayer = [CALayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, width, width);
    _animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f - 50, self.bounds.size.height / 2.0);
    [self.layer addSublayer:_animationLayer];
}

//画圆
-(void)circleAnimation{
    _animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f - 50, self.bounds.size.height / 2.0);
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = whiteColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    
    
    CGFloat lineWidth = 5.0f;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = circleDuriation;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:checkAnimation forKey:nil];
}

//对号
-(void)checkAnimation{
    _animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f - 50, self.bounds.size.height / 2.0);
    
    CGFloat a = _animationLayer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = whiteColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = checkDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self setUserInteractionEnabled:NO];
    NSLog(@"123");
 
}

@end
