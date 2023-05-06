//
//  XWView.h
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import <UIKit/UIKit.h>
#import "XWSDKHeader.h"
#import <Masonry/Masonry.h>
//#import <YYText/YYText.h>
#import <YYKit/YYKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWView : UIView

@property (nonatomic, copy) void (^bgClickClickBlock)(void);
@property (nonatomic, copy) void (^backButtonClickBlock)(void);
@property (nonatomic, copy) void (^submitButtonClickBlock)(void);
- (void)hiddenKeyBroad;

@end

NS_ASSUME_NONNULL_END
