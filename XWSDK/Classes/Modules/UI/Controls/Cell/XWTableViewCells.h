//

//  Created by 张熙文 on 2017/5/18.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"
#import "XWTableViewCell.h"

@interface XWTableViewCells : XWTableViewCell

@property (nonatomic, strong) LineView  *lineView;
@property (nonatomic, assign) BOOL       isLast;

- (void)setLineLeftMargin:(int)left;
- (void)setLineLeft:(MASViewAttribute *)left;

@end
