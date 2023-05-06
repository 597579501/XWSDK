//
//  XWUIHelper.m
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import "XWUIHelper.h"


@implementation XWUIHelper
#pragma mark -- 文本框验证失败抖动动画 --
+ (void)textFieldVerificationFailedAnimation:(UITextField *)textField
{
    CGFloat t = 4.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    textField.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        textField.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished)
        {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                textField.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished)
                {
                    [textField becomeFirstResponder];
                }
            }];
        }
    }];
}

+ (UIAlertView *)showAlertView:(NSString *)titleText message:(NSString *)messageText cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleText message:messageText delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    [alertView show];
    return alertView;
}


+ (UIImage *)drawRoundRectImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
