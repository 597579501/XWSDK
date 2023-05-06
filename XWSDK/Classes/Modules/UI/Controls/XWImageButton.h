//

//  Created by 张熙文 on 2017/5/22.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import "XWView.h"

typedef void (^imageButtonClickBlock)(void);

@interface XWImageButton : XWView
{
    YYLabel *_label;
}

@property (nonatomic, copy) imageButtonClickBlock imageButtonClickBlock;

- (void)setImageButtonClickBlock:(imageButtonClickBlock)imageButtonClickBlock;
- (void)setTitle:(NSString *)title image:(UIImage *)image;
@end
