#import "XWAutoLoginViewController.h"
#import "XWAutoLoginView.h"

@interface XWAutoLoginViewController ()

@end

@implementation XWAutoLoginViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _autoLoginView = [XWAutoLoginView new];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.autoLoginView];
    
    [self.autoLoginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
