//
//  XWWebViewController.h
//  XWSDK
//
//  Created by Seven on 2023/5/10.
//

#import "XWViewController.h"
#import "XWOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWWebViewController : XWViewController


@property (nonatomic, strong) XWOrderModel *order;
@property (nonatomic, copy,   readonly) NSString *url;


@property (nonatomic, copy,   readonly) NSString *html;
@property (nonatomic, strong, readonly) UIButton *reloadButton;
@property (nonatomic, strong, readonly) UIView   *bottomView;   //底部前进、后退按钮容器，默认隐藏

@property (nonatomic, assign) BOOL  isForbidScale;//default is YES
@property (nonatomic, assign) BOOL  isOpen;//default is YES

@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) void (^WebViewControllerPopBlock)(void);

- (instancetype)initWithURL:(NSString*)urlStr webTitle:(NSString *)title;

- (instancetype)initWithURL:(NSString*)urlStr;

- (instancetype)initWithHtml:(NSString *)html;

- (void)setProgress:(CGFloat)progress;

/**
 *  设置请求实体,默认实现只使用初始化时候的urlStr生成一个默认的url,如果需要自定义请求,需要建立自己的子类去重写该方法,生成自定义的NSURLRequest
 *
 *  @return 请求实体
 */
- (NSMutableURLRequest *)setupUrlRequest;


- (void)webViewloadingStatus:(BOOL)loading;
- (void)loadWebPage:(NSString *)html;

@end

NS_ASSUME_NONNULL_END
