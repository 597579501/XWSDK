//

//  Created by 熙文 张 on 2017/11/9.
//  Copyright © 2017年 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"
#import "XWUserLoginRecordModel.h"
#import "XWTableViewCell.h"

@interface XWUserListTableViewCell : XWTableViewCell
{
    UIImageView *_userImageView;
    UILabel     *_userNameLabel;
    
    LineView  *_lineView;
}


/**
 *  是否为最后一行
 */
@property (nonatomic, assign) BOOL            isLast;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) XWUserLoginRecordModel *userLoginRecordModel;
@end
