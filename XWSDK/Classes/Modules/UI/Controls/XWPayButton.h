
#import <UIKit/UIKit.h>



//typedef void (^payButtonClickBlock)();

@interface XWPayButton : UIButton
{
//    payButtonClickBlock _payButtonClickBlock;
}
@property (nonatomic, strong) NSString *title;
- (void)excuting;
- (void)paySuccess;
@end
