//
//  XWView.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWView.h"

@implementation XWView

- (void)hiddenKeyBroad
{
    [self endEditing:YES];
    [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
    [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
    if (self.bgClickClickBlock)
    {
        self.bgClickClickBlock();
    }
}

@end
