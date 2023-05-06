//

//
//  Created by 熙文 张 on 17/4/18.
//  Copyright © 2017年 熙文 张. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _style = LineHorizontaStyle;
        _lineColor = kTableLineViewColor;
    }
    return self;
}



- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGFloat lineMargin = 0;
    
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    CGFloat pixelAdjustOffset = 0;
    if (((int)(SINGLE_LINE_WIDTH * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    CGFloat xPos = pixelAdjustOffset - lineMargin;
    CGFloat yPos = pixelAdjustOffset - lineMargin;
    
    // 垂直
    if (_style == LineVerticalStyle)
    {
        CGContextMoveToPoint(context, xPos, 0);
        CGContextAddLineToPoint(context, xPos, kScreenWidth);
        xPos += lineMargin;
    }
    else if (_style == LineHorizontaStyle)
    {
        CGContextMoveToPoint(context, 0, yPos);
        CGContextAddLineToPoint(context, kScreenHeight, yPos);
        yPos += lineMargin;
    }
    
    CGContextSetLineWidth(context, SINGLE_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextStrokePath(context);
    
    
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGFloat lineMargin = 30;
    //
    //    /**
    //     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
    //     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
    //     */
    //    CGFloat pixelAdjustOffset = 0;
    //    if (((int)(SINGLE_LINE_WIDTH * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
    //        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    //    }
    //
    //    CGFloat xPos = lineMargin - pixelAdjustOffset;
    //    CGFloat yPos = lineMargin - pixelAdjustOffset;
    //    while (xPos < self.bounds.size.width) {
    //        CGContextMoveToPoint(context, xPos, 0);
    //        CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
    //        xPos += lineMargin;
    //    }
    //
    //    while (yPos < self.bounds.size.height) {
    //        CGContextMoveToPoint(context, 0, yPos);
    //        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
    //        yPos += lineMargin;
    //    }
    //
    //    CGContextSetLineWidth(context, SINGLE_LINE_WIDTH);
    //    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    //    CGContextStrokePath(context);
}


@end
