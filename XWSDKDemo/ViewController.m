//
//  ViewController.m
//  XWSDKDemo
//
//  Created by Seven on 2023/4/25.
//

#import "ViewController.h"
#import "XWSDK.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *userId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [[XWSDK sharedInstance] setLoginCallBack:^(XWUserModel * _Nonnull user) {
            
    }];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[XWSDK sharedInstance] conf:@"11105" appKey:@"45f6202f5365130f8a500c4b770b42b7" completion:^{
            cell.detailTextLabel.text = @"init success";
            [tableView reloadData];
        } failure:^(NSString * _Nonnull errorMessage) {
            cell.detailTextLabel.text = errorMessage;
            [tableView reloadData];
        }];
//        [[XWSDK sharedInstance] conf:@"11105" appKey:@"45f6202f5365130f8a500c4b770b42b7" completion:^(NSString * _Nonnull userId) {
//            
//        } failure:^(NSString * _Nonnull errorMessage) {
//            
//        }];
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[XWSDK sharedInstance] reg:@"xwtest5" password:@"xwtest1" code:@"" completion:^(NSString * _Nonnull userId) {
            self.userId = userId;
            cell.detailTextLabel.text = userId;
            [tableView reloadData];
        } failure:^(NSString * _Nonnull errorMessage) {
            cell.detailTextLabel.text = errorMessage;
            [tableView reloadData];
        }];
        
    }
    else if (indexPath.row == 2)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[XWSDK sharedInstance] login];
//        [[XWSDK sharedInstance] login:@"xwtest5" password:@"xwtest1" completion:^(XWUserModel * _Nonnull userModel) {
//            self.userId = userModel.userId;
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", userModel.userName , userModel.userId];
//            [tableView reloadData];
//        } failure:^(NSString * _Nonnull errorMessage) {
//            cell.detailTextLabel.text = errorMessage;
//            [tableView reloadData];
//        }];
        
    }
    else if (indexPath.row == 3)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[XWSDK sharedInstance] start:^(XWUserModel * _Nonnull userModel) {
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", userModel.userName , userModel.userId];
            [tableView reloadData];
        } failure:^(NSString * _Nonnull errorMessage) {
            cell.detailTextLabel.text = errorMessage;
            [tableView reloadData];
        }];
    }
    else if (indexPath.row == 4)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        XWRoleModel *roleModel = [[XWRoleModel alloc] init];
        roleModel.roleId = @"1";
        roleModel.roleName = @"测试";
        roleModel.userId = self.userId;
        roleModel.serverId = @"server1";
        roleModel.serverName = @"serverName1";
        roleModel.roleLevel = @"188";
        
        [[XWSDK sharedInstance] alive:roleModel completion:^(XWUserModel * _Nonnull userModel) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", userModel.userName , userModel.userId];
            [tableView reloadData];
        } failure:^(NSString * _Nonnull errorMessage) {
            cell.detailTextLabel.text = errorMessage;
            [tableView reloadData];
        }];
    }
    else if (indexPath.row == 5)
    {
        
    }
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        XWOrderModel *order = [[XWOrderModel alloc] init];
        order.roleId = @"1";
        order.roleName = @"测试";
        order.userId = self.userId;
        order.serverId = @"server1";
        order.serverName = @"serverName1";
        order.roleLevel = @"188";
        
        order.money = @"1";
        order.appData = @"appdata";
        order.appOrderId = @"orderid101";
        order.desc = @"desc";
        order.payType = @"5";
        
        [[XWSDK sharedInstance] open:order completion:^(NSString * _Nonnull orderId, NSString * _Nonnull url) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"orderId %@", orderId ];
            [tableView reloadData];
        } failure:^(NSString * _Nonnull errorMessage) {
            cell.detailTextLabel.text = errorMessage;
            [tableView reloadData];
        }];
    }
    
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@"初始化", @"注册", @"登录", @"激活上报", @"角色上报", @"用户中心",@"请求支付"];
    }
    return _dataArray;;
}

@end
