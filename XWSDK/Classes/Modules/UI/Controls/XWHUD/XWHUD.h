#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XWProgressHUD.h"

@interface XWHUD : NSObject

/**
 *  只显示文本
 *
 *  @param view 要添加的view
 *  @param text 文本信息
 */
+ (void)showOnlyText:(UIView *)view text:(NSString *)text;


/**
 *  显示hud
 *
 *  @param view 要添加的view
 *
 *  @return 返回hud实例
 */
+ (XWProgressHUD *)showHUD:(UIView *)view;

/**
 *  隐藏hud
 *
 *  @param hud hud实例。要和showHUD成对出现
 */
+ (void)hideHUD:(XWProgressHUD *)hud;

@end
