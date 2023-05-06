
#import <UIKit/UIKit.h>
#import "XWGQOrderInfoModel.h"
#import "LineView.h"
#import "XWTableViewCell.h"

@interface XWOrderInfoViewCell : XWTableViewCell
{
    YYLabel     *_textLabel;
    UILabel     *_detailTextLabel;
    LineView    *_lineView;
}
@property (nonatomic, strong) UIColor        *detailTextColor;
@property (nonatomic, assign) BOOL            isLast;
@property (nonatomic, strong) XWGQOrderInfoModel *infoModel;
@end
 
