#import "XWHUD.h"
#import "XWProgressHUD.h"

@implementation XWHUD


+ (void)showOnlyText:(UIView *)view text:(NSString *)text;
{
    XWProgressHUD *hud = [XWProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = XWProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.label.numberOfLines = 2;
    hud.userInteractionEnabled = NO;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, XWProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.f];
}


+ (XWProgressHUD *)showHUD:(UIView *)view
{
    XWProgressHUD *hud = [XWProgressHUD showHUDAddedTo:view animated:YES];
    return hud;
}


+ (void)hideHUD:(XWProgressHUD *)hud
{
    [hud hideAnimated:YES];
}



@end
