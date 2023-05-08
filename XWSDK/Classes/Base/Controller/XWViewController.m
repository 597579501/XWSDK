//
//  XWViewController.m
//  XWSDK
//
//  Created by Seven on 2023/4/25.
//

#import "XWViewController.h"
#import <YYKit/YYKit.h>

@interface XWViewController ()
//<YYKeyboard>
{
    UIButton *_bgButton;
    UIView *_bgView;
}
@end

@implementation XWViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        [_bgView setAlpha:0.4];
        
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        [_bgView setAlpha:0.0];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing: YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
//    _bgButton = [UIButton new];
//    [_bgButton addTarget:self action:@selector(bgClick) forControlEvents:UIControlEventTouchUpInside];
//    [_bgButton setBackgroundColor:[UIColor blackColor]];
//    [_bgButton setAlpha:0];
//    [self.view addSubview:_bgButton];
//
//
//    [_bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [_bgView setAlpha:0.0];
    [self.view addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);

    }];
//
    YYTextKeyboardManager *keyboardManager = [YYTextKeyboardManager defaultManager];
    [keyboardManager addObserver:self];
//
//
    // 重写leftBarButtonItems后push滑动手势消失解决方案
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    if (self.isCanShowBack) {
        UIBarButtonItem *backSpacerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        backSpacerButton.width = -18;
        UIImage *backButtonNormalImage = [UIImage imageNamed:@"DH_SDK_BarItem_Back_Normal"];
        UIImage *backButtonHighlightedImage = [UIImage imageNamed:@"DH_SDK_BarItem_Back_Highlighted"];
        backButtonHighlightedImage = [backButtonHighlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIButton *backButton = [UIButton new];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [backButton setFrame:CGRectMake(10, 0, 40, 40)];

        [backButton setBackgroundImage:backButtonNormalImage forState:UIControlStateNormal];
        [backButton setBackgroundImage:backButtonHighlightedImage forState:UIControlStateHighlighted];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItems:@[backSpacerButton, backButtonItem]];
    }
    
//
//
    UIBarButtonItem *closeSpacerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    closeSpacerButton.width = -10;

    UIImage *closeButtonNormalImage = [UIImage imageNamed:@"DH_SDK_UserListDel"];
    UIImage *closeButtonHighlightedImage = [UIImage imageNamed:@"DH_SDK_UserListDel"];
    closeButtonHighlightedImage = [closeButtonHighlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//
    UIButton *closeButton = [UIButton new];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setFrame:CGRectMake(10, 0, 40, 40)];
//

//
    [closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_lessThanOrEqualTo(40);

    }];
    

    
 
    [closeButton setBackgroundImage:closeButtonNormalImage forState:UIControlStateNormal];
    [closeButton setBackgroundImage:closeButtonHighlightedImage forState:UIControlStateHighlighted];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    [self.navigationItem setRightBarButtonItems:@[closeSpacerButton, closeButtonItem]];

    
}


#pragma mark - @protocol YYKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        CGRect kbFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
        
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption animations:^{
            [[self.view superview] layoutIfNeeded];
            if (transition.toVisible)
            {
                self.view.centerY = self.view.size.height / 2 - (kbFrame.size.height / 2);
            }
            else
            {
                self.view.centerY = self.view.size.height / 2;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)setCloseButtonClickBlock:(closeButtonClickBlock)closeButtonClickBlock
{
    _closeButtonClickBlock = closeButtonClickBlock;
}


- (void)bgClick
{
    
   
}


- (void)backButtonClick
{
    [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)closeButtonClick
{

    //todo
//    if ([self isKindOfClass:[DHWebViewController class]])
//    {
//        DHWebViewController *webViewController = (DHWebViewController *)self;
//        if (webViewController.isPay)
//        {
//            [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//        }
//        else
//        {
//            [self.navigationController.view removeFromSuperview];
//            [self.navigationController removeFromParentViewController];
//        }
//    }
//    else
    {
        [self.navigationController.view removeFromSuperview];
        [self.navigationController removeFromParentViewController];
    }
    if (_closeButtonClickBlock) {
        _closeButtonClickBlock();
    }
//    [self dismissViewControllerAnimated:YES completion:^{
//        if (_closeButtonClickBlock) {
//            _closeButtonClickBlock();
//        }
//    }];
}


- (void)closeView
{
    [self.navigationController.view removeFromSuperview];
    [self.navigationController removeFromParentViewController];
    if (_closeButtonClickBlock) {
        _closeButtonClickBlock();
    }
}

- (XWSDKViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [[XWSDKViewModel alloc] init];
    }
    return _viewModel;
}

@end
