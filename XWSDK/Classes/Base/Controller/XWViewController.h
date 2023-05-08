//
//  XWViewController.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>
#import "XWSDKViewModel.h"
#import "XWHUD.h"

typedef void (^closeButtonClickBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface XWViewController : UIViewController

@property (nonatomic, assign) BOOL                  isCanShowBack;
@property (nonatomic, copy)   closeButtonClickBlock closeButtonClickBlock;

@property (nonatomic, copy)   XWSDKViewModel *viewModel;

- (void)bgClick;
- (void)closeButtonClick;
- (void)backButtonClick;
- (void)closeView;
- (void)setCloseButtonClickBlock:(closeButtonClickBlock)closeButtonClickBlock;

@end

NS_ASSUME_NONNULL_END
