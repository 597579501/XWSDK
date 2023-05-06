//

//  Created by 熙文 张 on 17/5/31.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWNavigationBar : UIView
{
    UILabel *_titleLabel;
}

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *closeButton;

/**
 *  NavigationBar顶部标题
 */
@property (nonatomic, strong) NSString *title;



/**
 *  关闭的按钮回调事件
 */
@property (nonatomic, copy) void (^closeButtonClickBlock)(void);
@end
