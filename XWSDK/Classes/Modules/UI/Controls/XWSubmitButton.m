//

//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWSubmitButton.h"

#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]
#define WhiteColor [UIColor whiteColor]
static CGFloat lineWidth = 2.0f;



#if LOG_Manager
static Logger *logger = nil;
#endif


#if LOG_Manager
__attribute__((constructor)) static void Inject(void) {
    logger = [Logger new];
    logger.type = kLogTypeManager;
}
#endif


@implementation XWSubmitButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.layer setCornerRadius:5];
        [self setClipsToBounds:YES];
//        [self setBackgroundImage:kImage(@"XW_SDK_Button_Normal") forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithColor:XWAdapterBtnNomal] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:XWAdapterBtnHigh] forState:UIControlStateHighlighted];
        
        [[self titleLabel] setFont:[UIFont systemFontOfSize:15]];
//        [self setBackgroundImage:kImage(@"XW_SDK_Button_Highlighted") forState:UIControlStateHighlighted];
//        [self setBackgroundImage:kImage(@"XW_SDK_Button_Disabled") forState:UIControlStateDisabled];
        
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.strokeColor = WhiteColor.CGColor;
        _animationLayer.lineWidth = lineWidth;
        _animationLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:_animationLayer];

    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _size = self.bounds.size.height / 2;
    _animationLayer.bounds = CGRectMake(0, 0, _size, _size);
    _animationLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}


- (void)displayLinkAction
{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}


- (void)updateAnimationLayer
{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress) / 0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    _animationLayer.path = path.CGPath;
}

- (void)start
{
    [self setUserInteractionEnabled:NO];
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link.paused = false;
    }
}

- (void)hide
{
    [self setUserInteractionEnabled:YES];
    
    _progress = 0;
    _startAngle = 0;
    _endAngle = 0;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    _animationLayer.path = path.CGPath;
    _link.paused = true;
    [_link invalidate];
    _link = nil;
    [self setTitle:_title forState:UIControlStateNormal];
}


- (CGFloat)speed
{
    if (_endAngle > M_PI) {
        return 0.3 / (_size * 2);
    }
    return 2 / (_size * 2);
}


- (void)startCircleAnimation
{
    [self setTitle:@"" forState:UIControlStateNormal];
    [self start];
}


- (void)stopCircleAnimation
{
    [self setTitle:_title forState:UIControlStateNormal];
    [self hide];
}


- (void)setButtonStyle:(MKButtonStyle)buttonStyle
{
    if (buttonStyle == MKNormalStyle)
    {
        [self setTitle:_title forState:UIControlStateNormal];
        [self hide];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    else if (buttonStyle == MKNowStyle)
    {
        [self setTitle:@"" forState:UIControlStateNormal];
        int size = self.bounds.size.height / 2;
        _animationLayer.bounds = CGRectMake(0, 0, size, size);
        _animationLayer.position = CGPointMake(self.bounds.size.width / 2 - size + 40, self.bounds.size.height / 2);
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, size, 0, 0)];
    }
    else if(buttonStyle == MKSuccessStyle)
    {
        
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
}


- (void)dealloc
{
    _link.paused = true;
#if LOG_Manager
    NSString *selfClass = NSStringFromClass([self class]);
    [logger log:@"%@ - dealloc", selfClass];
#endif
}



@end
