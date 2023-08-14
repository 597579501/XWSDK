//
//  XWWebViewController.m
//  XWSDK
//
//  Created by Seven on 2023/5/10.
//

#import "XWWebViewController.h"
#import "XWSDKHeader.h"
#import "XWHelper.h"
#import <WebKit/WebKit.h>
#import "XWSDK.h"
#import "XWBaseServer.h"

#if DEBUG
#define NSLog(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__]);
#else
#define NSLog(...)
#endif

const float WebViewCtrlInitialProgressValue           = 0.1f;
const float WebViewCtrlInteractiveProgressValue       = 0.5f;
const float WebViewCtrlFinalProgressValue             = 0.9f;

#define LV_MAIN_HL_COLOR          UIColorHex(0x6F9EFF)//主屎黄色调
#define LV_VIEW_BG_COLOR          UIColorHex(0x262630)

@interface XWWebViewController()<WKUIDelegate,WKNavigationDelegate, UIScrollViewDelegate>
{
    WKWebView                   *_webView;
    NSString                    *_webTitle;
    UIButton                    *_goBackButton;
    UIButton                    *_goForwardButton;
    UIButton                    *_reloadButton;
    UIButton                    *_stopLoadingButton;
    UIBarButtonItem             *_reloadBarButton;
    UIBarButtonItem             *_stopBarButton;
    
    NSUInteger                  _loadingCount;
    NSUInteger                  _maxLoadCount;
    NSURL                       *_currentURL;
    BOOL                        _interactive;
    
    UIView                      *_progressBarView;
}

@property (nonatomic, copy,   readwrite) NSString *url;
@property (nonatomic, assign, readwrite) CGFloat progress;
@property (nonatomic, strong, readwrite) UIView  *bottomView;

@end

@implementation XWWebViewController

- (instancetype)initWithURL:(NSString*)urlStr webTitle:(NSString *)title
{
    self = [super init];
    if(self){
        self.isCanShowBack = YES;
        _url = urlStr;
        _webTitle = title;
        _isForbidScale = YES;
    }
    return self;
}

- (instancetype)initWithURL:(NSString*)urlStr
{
    self = [super init];
    if(self){
        self.isCanShowBack = YES;
        _url = urlStr;
        _isForbidScale = YES;
    }
    return self;
}

- (instancetype)initWithHtml:(NSString *)html
{
    self = [super init];
    if(self){
        self.isCanShowBack = YES;
        _html = html;
        _isForbidScale = YES;
    }
    return self;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if (!self.isCanShowBack)
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)setIsCanShowBack:(BOOL)isCanShowBack
{
    [super setIsCanShowBack:isCanShowBack];
    
    if (!isCanShowBack) {
        self.navigationItem.hidesBackButton = YES;
        //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        //        self.navigationController.navigationBar.backItem.hidesBackButton = YES;
        //        UIBarButtonItem *nItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        //        self.navigationController.navigationBar.backItem = nItem;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO];
  
    
    [self setTitle:_webTitle];
    
    
    
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    int top = 0;
//    if (UIInterfaceOrientationIsLandscape(orientation))
//    {
//        if ([[UIDevice currentDevice] isPad])
//        {
//            top = 0;
//
//        }
//        else
//        {
//            top = 0;
//        }
//    }
//    else if (UIInterfaceOrientationIsPortrait(orientation))
//    {
//        top = 0;
//    }
    [self.webView.scrollView setContentInset:UIEdgeInsetsMake(top, 0, 0, 0)];
    [self.webView.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(top, 0, 0, 0)];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    //    [self.navigationItem setRightBarButtonItem:self.reloadBarButton];
    //
    //    [self.bottomView addSubview:self.goBackButton];
    //    [self.bottomView addSubview:self.goForwardButton];
    
    [self.view addSubview:self.webView];
    //    [self.view addSubview:self.bottomView];
    [self.webView addSubview:self.progressBarView];
    
    //    [self.bottomView setHidden:YES];
    
    WS(weakSelf)
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    //    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
    //        make.left.mas_equalTo(weakSelf.view.mas_left);
    //        make.right.mas_equalTo(weakSelf.view.mas_right);
    //        make.height.mas_equalTo(@(WebViewControllerFootBarHeight));
    //    }];
    //
    //    __weak UIView *wBottomView = self.bottomView;
    //
    //    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make){
    //        make.right.mas_equalTo(weakSelf.goForwardButton.mas_left);
    //        make.top.mas_equalTo(wBottomView.mas_top);
    //        make.width.mas_equalTo(@64);
    //        make.height.mas_equalTo(wBottomView.mas_height);
    //    }];
    //
    //    [self.goForwardButton mas_makeConstraints:^(MASConstraintMaker *make){
    //        make.right.mas_equalTo(wBottomView.mas_right);
    //        make.top.mas_equalTo(wBottomView.mas_top);
    //        make.width.mas_equalTo(@64);
    //        make.height.mas_equalTo(wBottomView.mas_height);
    //    }];
    if (![XWHelper isBlankString:_url])
    {
        if (self.isOpen)
        {
            XWCommonModel *commonModel = [XWCommonModel sharedInstance];
            NSMutableDictionary *commonDictionary = [commonModel modelToJSONObject];
            NSDictionary *params = @{
                @"money" : self.order.money ? self.order.money : @"",
                @"user_id" : [XWSDK sharedInstance].currUser.userId  ? [XWSDK sharedInstance].currUser.userId : @"",
                @"server_id" : self.order.serverId  ? self.order.serverId : @"",
                @"role_id" : self.order.roleId ? self.order.roleId : @"",
                @"role_level" : self.order.roleLevel ? self.order.roleLevel : @"",
                @"app_data" : self.order.appData ? self.order.appData : @"" ,
                @"app_order_id" : self.order.appOrderId ? self.order.appOrderId : @"",
                @"desc" : self.order.desc ? self.order.desc : @"",
                @"is_h5_pay" : @"1",
                @"order_type" : @"1",
                @"user_coupon_id" : @"0",
                @"use_platform_currency" : @"0",
            };
            [commonDictionary addEntriesFromDictionary:params];
            NSString *signString = [XWBaseServer signWithParams:commonDictionary];
            [commonDictionary setObject:signString forKey:@"sign"];
            
            NSString *query = [self queryStringWithDict:commonDictionary];
            NSString *urlString = [NSString stringWithFormat:@"http://gw.gzsdk.dakongy.com/pay/cashier.php?%@", query];
            NSURL *url = [NSURL URLWithString:urlString];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
        }
        else
        {
            [self loadWebPage];
            
        }
        
    }
    else
    {
        [self loadWebPage:self.html];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView reload];
    });
    //    NSLog(@"%@",NSStringFromCGRect(self.webView.frame));
}



//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.bottomView lsy_gradientWithColors:@[(id)[UIColor colorWithWhite:1 alpha:0].CGColor,
//                                          (id)[UIColor whiteColor].CGColor]
//                                  locations:@[@0.0,@0.95]];
//}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.navigationItem setRightBarButtonItem:nil];
//}

- (void)loadWebPage:(NSString *)html
{
    [_webView loadHTMLString:html baseURL:nil];
}

- (void)setWebTitle:(NSString *)webTitle
{
    if (_webTitle != webTitle) {
        _webTitle = [webTitle copy];
        [self.navigationItem setTitle:webTitle];
    }
}

- (void)setIsForbidScale:(BOOL)isForbidScale
{
    _isForbidScale = isForbidScale;
    if (_isForbidScale) {
        [_webView.scrollView setMinimumZoomScale:1.0f];
        [_webView.scrollView setMaximumZoomScale:1.0f];
    }
}

#pragma mark - NavigationBarItem Action

-(void)didPressedBackButton:(UIButton *)rightBtn
{
    if (self.WebViewControllerPopBlock) {
        self.WebViewControllerPopBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 构建子View方法


- (UIView *)progressBarView
{
    if (!_progressBarView) {
        NSString *machineModelName = [[UIDevice currentDevice] machineModelName];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        int top = 0;
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            if ([[UIDevice currentDevice] isPad])
            {
                top = kNavigationBarHeight;
            }
            else
            {
                if ([machineModelName hasSuffix:@"Plus"])
                {
                    top = 44;
                }
                else
                {
                    top = 32;
                }
            }
        }
        else
        {
            if ([machineModelName hasSuffix:@"X"]) {
                top = kNavigationBarHeight + 24;
            }
            else
            {
                top = kNavigationBarHeight;
            }
        }
        _progressBarView = [[UIView alloc] initWithFrame:CGRectMake(0, top, 0, 2)];
        _progressBarView.backgroundColor = LV_MAIN_HL_COLOR;
    }
    return _progressBarView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [_webView.scrollView setDelegate:self];
        [_webView setUIDelegate:self];
        [_webView setNavigationDelegate:self];
//        [_webView setDelegate:self];
//        [_webView setScalesPageToFit:YES];
        [_webView.scrollView setMinimumZoomScale:1.0f];
        [_webView.scrollView setMaximumZoomScale:1.0f];
        //        _webView.backgroundColor = LV_VIEW_BG_COLOR;
        
        [_webView setOpaque:NO];
    }
    
    return _webView;
}

//底部工具栏
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UIBarButtonItem *)stopBarButton
{
    if (!_stopBarButton) {
        _stopBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.stopLoadingButton];
    }
    
    return _stopBarButton;
}

- (UIBarButtonItem *)reloadBarButton
{
    if (!_reloadBarButton) {
        _reloadBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.reloadButton];
    }
    
    return _reloadBarButton;
}

- (UIButton *)goBackButton
{
    if (!_goBackButton) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setImage:[UIImage imageNamed:@"icon_bottomWeb_back_normal"] forState:UIControlStateNormal];
        [_goBackButton setImage:[UIImage imageNamed:@"icon_bottomWeb_back_highlight"] forState:UIControlStateHighlighted];
    }
    return _goBackButton;
}

- (UIButton *)goForwardButton
{
    if (!_goForwardButton) {
        _goForwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goForwardButton setImage:[UIImage imageNamed:@"icon_bottomWeb_go_normal"] forState:UIControlStateNormal];
        [_goForwardButton setImage:[UIImage imageNamed:@"icon_bottomWeb_go_highlight"] forState:UIControlStateHighlighted];
        //        [_goForwardButton setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 0, -10))];
    }
    return _goForwardButton;
}

- (UIButton *)reloadButton
{
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadButton setSize:(CGSize){50,44}];
        [_reloadButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [_reloadButton setImage:[UIImage imageNamed:@"icon_bottomWeb_refresh_normal"] forState:UIControlStateNormal];
        [_reloadButton setImage:[UIImage imageNamed:@"icon_bottomWeb_refresh_highlight"] forState:UIControlStateHighlighted];
        [_reloadButton setImageEdgeInsets:(UIEdgeInsetsMake(0, 20, 0, -20))];
    }
    return _reloadButton;
}

- (UIButton *)stopLoadingButton
{
    if (!_stopLoadingButton) {
        
        _stopLoadingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopLoadingButton setSize:(CGSize){50,44}];
        [_stopLoadingButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [_stopLoadingButton setImage:[UIImage imageNamed:@"icon_bottomWeb_stop_normal"] forState:UIControlStateNormal];
        [_stopLoadingButton setImage:[UIImage imageNamed:@"icon_bottomWeb_stop_highlight"] forState:UIControlStateHighlighted];
        [_stopLoadingButton setImageEdgeInsets:(UIEdgeInsetsMake(0, 20, 0, -20))];
        
    }
    return _stopLoadingButton;
}

#pragma mark - Start load web page

- (void)loadWebPage
{
    NSMutableURLRequest *request = [self setupUrlRequest];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_webView loadRequest:request];
    });
    
}

- (NSMutableURLRequest *)setupUrlRequest{
    NSURL *url = [NSURL URLWithString:_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"gw.gzsdk.dakongy.com" forHTTPHeaderField:@"Referer"];
    return request;
    
}

#pragma mark - Button Action

//- (void)backButtonOverrideAction:(id)sender
//{
////    [self.navigationController.view removeFromSuperview];
////    [self.navigationController removeFromParentViewController];
////    if (self.webView.canGoBack)
////    {
////        [_webView goBack];
////    }
////    else
////    {
//        [self.navigationController popViewControllerAnimated:YES];
////    }
//}

- (void)buttonPress:(UIButton *)sender
{
    if ([sender isEqual:_goBackButton])
    {
        [_webView goBack];
    }
    else if ([sender isEqual:_goForwardButton])
    {
        [_webView goForward];
    }
    else if ([sender isEqual:_reloadButton])
    {
        [self reset];
        [_webView reload];
        
    }
    else if ([sender isEqual:_stopLoadingButton])
    {
        [_webView stopLoading];
    }
    
}

- (void)toggleState
{
    _goBackButton.enabled = _webView.canGoBack;
    _goForwardButton.enabled = _webView.canGoForward;
    
}

- (void)webViewloadingStatus:(BOOL)loading {
    
    [self toggleState];
    
    //    if (loading)
    //    {
    //        [self.navigationItem setRightBarButtonItem:self.stopBarButton];
    //
    //        [_reloadButton setAlpha:0.0f];
    //        [_stopLoadingButton setHidden:NO];
    //    }
    //    else
    //    {
    //        [self.navigationItem setRightBarButtonItem:self.reloadBarButton];
    //        [_reloadButton setAlpha:1.0f];
    //        [_stopLoadingButton setHidden:YES];
    //    }
}



#pragma mark - Handle Progress

- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}

- (void)startProgress
{
    if (_progress < WebViewCtrlInitialProgressValue) {
        [self setProgress:WebViewCtrlInitialProgressValue];
    }
}

- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? WebViewCtrlFinalProgressValue : WebViewCtrlInteractiveProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}

- (void)completeProgress
{
    [self setProgress:1.0];
}

- (void)setProgress:(CGFloat)progress
{
    // progress should be incremental only
    if (progress > _progress || progress == 0) {
        _progress = progress;
        [self setProgress:progress animated:YES];
    }
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? 0.27 : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _progressBarView.frame;
        frame.size.width = progress * self.view.width;
        _progressBarView.frame = frame;
    } completion:nil];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? 0.27 : 0.0 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? 0.27 : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 1.0;
        } completion:nil];
    }
}

- (NSString *)noScaleJSString
{
    return @"function setScale(){\
    var all_metas=document.getElementsByTagName('meta');\
    if (all_metas){\
    var k;\
    for (k=0; k<all_metas.length;k++){\
    var meta_tag=all_metas[k];\
    var viewport= meta_tag.getAttribute('name');\
    if (viewport&& viewport=='viewport'){\
    meta_tag.setAttribute('content',\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\");\
    }\
    }\
    }\
    }";
}

#pragma mark - UIWebViewDelegate
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
////- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
//{
////- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
////{
//
//    //OC调用JS是基于协议拦截实现的 下面是相关操作
////    NSString *absolutePath = request.URL.absoluteString;
////
////    NSString *scheme = @"rrcc://";
////
////    if ([absolutePath hasPrefix:scheme]) {
////        NSString *subPath = [absolutePath substringFromIndex:scheme.length];
////        if ([subPath containsString:@"?"]) {//1个或多个参数
////            if ([subPath containsString:@"&"]) {//多个参数
////                NSArray *components = [subPath componentsSeparatedByString:@"?"];
////
////                NSString *methodName = [components firstObject];
////
////                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
////                SEL sel = NSSelectorFromString(methodName);
////
////                NSString *parameter = [components lastObject];
////                NSArray *params = [parameter componentsSeparatedByString:@"&"];
////
////                if (params.count == 2) {
////                    if ([self respondsToSelector:sel]) {
////                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
////                    }
////                }
////
////
////            } else {//1个参数
////                NSArray *components = [subPath componentsSeparatedByString:@"?"];
////
////                NSString *methodName = [components firstObject];
////                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
////                SEL sel = NSSelectorFromString(methodName);
////
////                NSString *parameter = [components lastObject];
////
////                if ([self respondsToSelector:sel]) {
////                    [self performSelector:sel withObject:parameter];
////                }
////
////            }
////
////        } else {//没有参数
////            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
////            SEL sel = NSSelectorFromString(methodName);
////
////            if ([self respondsToSelector:sel]) {
////                [self performSelector:sel];
////            }
////        }
////    }
//
//
//
//
////    if ([request.URL.path isEqualToString:completeRPCURLPath]) {
////        [self completeProgress];
////        return NO;
////    }
//
//    //    if([LSYAppJumpHandler shouldJumpToViewControllerFromWeb:request.URL]){ // 判断是否从web跳到app
//    //        [LSYAppJumpHandler jumpToViewControllerFromWeb:request.URL]; //根据URL跳转到对应的控制器
//    //        return NO;
//    //    }
//
//
//    return YES;
//}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
////    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
////        [_webViewProxyDelegate webViewDidStartLoad:webView];
////    }
//
//    _loadingCount++;
//    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
//
//    [self webViewloadingStatus:YES];
//
//    [self startProgress];
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
////- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    // Disable callout
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//
//    if (!_webTitle) {
//        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    }
//    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//    //    NSString *urlString =  [NSString stringWithFormat:@"%@",webView.request.URL];
//    //    NSLog(@"urlString- %@",urlString);
//
//
//
//    [self webViewloadingStatus:NO];
//
//    //禁止webView放缩
//    if (self.isForbidScale) {
////        [webView stringByEvaluatingJavaScriptFromString:[self noScaleJSString]];
//    }
//
//
//
//    _loadingCount--;
//    [self incrementProgress];
//
//    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
//
//    BOOL interactive = [readyState isEqualToString:@"interactive"];
//    if (interactive) {
//        _interactive = YES;
////        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
////        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
//    }
//
//    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
//    BOOL complete = [readyState isEqualToString:@"complete"];
//    if (complete && isNotRedirect) {
//        [self completeProgress];
//    }
//}
//
//
//- (void)closeButtonClick
//{
//    [super closeButtonClick];
//}
//
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
//{
//    [self webViewloadingStatus:NO];
//
//
//
//    _loadingCount--;
//    [self incrementProgress];
//
//    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
//
//    BOOL interactive = [readyState isEqualToString:@"interactive"];
//    if (interactive) {
//        _interactive = YES;
////        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
////        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
//    }
//
//    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
//    BOOL complete = [readyState isEqualToString:@"complete"];
//    if ((complete && isNotRedirect) || error) {
//        [self completeProgress];
//    }
//
//
//}
//
//#pragma mark -
//#pragma mark Method Forwarding
//// for future UIWebViewDelegate impl
//
//- (BOOL)respondsToSelector:(SEL)aSelector
//{
//    if ( [super respondsToSelector:aSelector] )
//        return YES;
//
//    if ([self.webViewProxyDelegate respondsToSelector:aSelector])
//        return YES;
//
//    return NO;
//}


#pragma mark - # Delegate
//MARK: WKNavigationDelegate
// 开始加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

// 开始返回页面内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}

// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation");
}

// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation error %@", error.description);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *urlString = navigationAction.request.URL.absoluteString;
    NSLog(@"decidePolicyForNavigationAction  %@", urlString);
    BOOL isIt = [urlString rangeOfString:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb"].location != NSNotFound;
    BOOL isSet = [[navigationAction.request.allHTTPHeaderFields objectForKey:@"Referer"] isEqualToString:@"gw.gzsdk.dakongy.com"];
    if (isIt && !isSet)
    {
        
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [req setValue:@"gw.gzsdk.dakongy.com" forHTTPHeaderField:@"Referer"];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [webView loadRequest:req];
        });
        

        
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
        if ([navigationAction.request.URL.scheme isEqualToString:@"weixin"])
        {
            if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL])
            {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
    
                }];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
        }
        else
        {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
        
    }
    
//    decisionHandler(WKNavigationActionPolicyAllow);
    
    
}


- (NSString *)queryStringWithDict:(NSDictionary *)dict {
    // shareType=%@&mediaType=%@
    NSMutableString *result = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        if (key)
        {
            [result appendString:key];
        }
        [result appendString:@"="];
        
        if ([obj isKindOfClass:[NSNumber class]]) {
            if ([obj description])
            {
                NSString *encodedString = [[obj description] stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!@$^&%*+,;='\"`<>()[]{}\\| "] invertedSet]];
                [result appendString:encodedString];
            }
        } else {
            if (obj)
            {
                NSString *encodedString = [obj stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!@$^&%*+,;='\"`<>()[]{}\\| "] invertedSet]];
                [result appendString:encodedString];
            }
            
        }
        
        [result appendString:@"&"];
    }];
    if (result.length > 0) {
        return [result substringToIndex:result.length - 1];
    }
    return nil;
}




@end

