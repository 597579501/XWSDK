//
//  XWUIHelper.h
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWUIHelper : NSObject
+ (void)textFieldVerificationFailedAnimation:(UITextField *)textField;
+ (UIAlertView *)showAlertView:(NSString *)titleText message:(NSString *)messageText cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles;
+ (UIImage *)drawRoundRectImageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageFromView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
