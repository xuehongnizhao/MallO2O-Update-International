//
//  AdressDetailController.m
//  MallO2O
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AdressDetailController.h"
/**
 第三方库 用于cell左滑事件添加按钮 在ios8之后有原生的委托
 */
#import "DAContextMenuCell.h"

#import "AddressControlModel.h"

#import "PushOrderViewController.h"
#import "AddAdrsInforViewController.h"

@interface AdressDetailController ()

@property (assign ,nonatomic) NSInteger rowsCount;

@end

@implementation AdressDetailController{
    UIButton *rightBtn;
    
    NSMutableArray *tableViewArray;
    NSArray *addressArray;
    int page;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarTitle:NSLocalizedString(@"adressDetailNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    // Do any additional setup after loading the view.
    [self setRightButton];
    [self initData];
    
    [UZCommonMethod hiddleExtendCellFromTableview:self.tableView];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置返回按钮
/**
 *  设置返回按钮
 */
- (void) setBackButton {
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame     = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[UIImage imageNamed:@"return_no"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"navbar_return_sel"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageEdgeInsets            = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)popViewController {
    //    [self resignFirstResponder];
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setNavBarTitleWithFont
/**
 *  设置 导航控制器 title 文字
 *
 *  @param navTitle 标题名称
 *  @param navFont  文字大小
 */
- (void)setNavBarTitle:(NSString *)navTitle withFont:(CGFloat)navFont {
    //自定义标题
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.font            = [UIFont systemFontOfSize:navFont];
    titleLabel.backgroundColor = nil;                   //设置Label背景透明
    titleLabel.textColor       = [UIColor blackColor];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.opaque          = NO;
    titleLabel.text            = navTitle;              //设置标题
    self.navigationItem.titleView = titleLabel;
    
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataFromUrl];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (rightBtn)rightBtn.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(rightBtn)rightBtn.enabled = YES;
}

/**
 设置导航栏右侧按钮
 */
- (void)setRightButton{
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"add_address_sel"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"add_address_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

/**
 添加地址按钮点击事件
 */
- (void)addAddress{
    AddAdrsInforViewController *viewController = [[AddAdrsInforViewController alloc] init];
    viewController.naviTitle = NSLocalizedString(@"addAdrsInforAddAddressNavigationTitle", nil);
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)initData{
    page = 1;
    tableViewArray = [NSMutableArray array];
}

- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_address"];
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id"    : GetUserDefault(U_ID),
                          @"u_id"    : [PersonInfoModel shareInstance].uID,
                          @"page"    : [NSString stringWithFormat:@"%d",page]
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
            NSLog(@"%@",resultObject);
            if ([resultObject[@"code"] integerValue] == 200) {
                NSMutableArray *array = (NSMutableArray *)resultObject[@"obj"];
                for (int i = 0; i < array.count; i++) {
                    if ([[array[i] objectForKey:@"type"] integerValue] == 1) {
                        SetUserDefault(array[i], Address);
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }
                tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
                _rowsCount = tableViewArray.count;
                addressArray = resultObject[@"obj"];
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
            }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = tableViewArray;
    }
    for (NSDictionary *dic in param) {
        AddressControlModel *model = [AddressControlModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark - Private

- (void)setRowsCount:(NSInteger)rowsCount
{
    if (rowsCount < 0) {
        _rowsCount = 0;
    } else {
        _rowsCount = rowsCount;
    }
}

#pragma mark * Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DAContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[DAContextMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [UZCommonMethod settingTableViewAllCellWire:self.tableView andTableViewCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    AddressControlModel *model = tableViewArray[indexPath.row];
    cell.userNameLabel.text = model.consigneeString;
    cell.userTelLabel.text = model.telString;
    cell.addressLabel.text = model.addressInfo;
    if ([model.typeString integerValue] == 1) {
        [cell cellOfSelect:YES];
    }else{
        [cell cellOfSelect:NO];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressControlModel *model = tableViewArray[indexPath.row];
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"is_address"];
    NSDictionary *dic = @{
                          @"app_key"    : url,
//                          @"u_id"       : GetUserDefault(U_ID),
                          @"u_id"       : [PersonInfoModel shareInstance].uID,
                          @"address_id" : model.addressId
                          };
    
    [SwpRequest swpPOST:url parameters:dic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@",resultObject);
        if ([resultObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
            if ([_isSelectAddress boolValue]) {
                NSMutableArray *arr                       = self.navigationController.viewControllers.mutableCopy;
                self.navigationController.viewControllers = arr;
        //                        PushOrderViewController *viewController   = arr[1];
                SetUserDefault(addressArray[indexPath.row], Address);
                [[NSUserDefaults standardUserDefaults] synchronize];
        //                [self.navigationController popToViewController:viewController animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self getDataFromUrl];
        }else{
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        }
    

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showSuccessWithStatus:@"网络错误"];
    }];
}

#pragma mark * DAContextMenuCell delegate
- (void)contextMenuCellDidSelectDeleteOption:(DAContextMenuCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AddressControlModel *model = tableViewArray[indexPath.row];
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_my_address"];//connect_url(@"del_my_address");
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"address_id" : model.addressId
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        SetUserDefault(nil, Address);
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self getDataFromUrl];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

/**
 cell左滑的点击事件 点击编辑的按钮
 */
- (void)contextMenuCellDidSelectMoreOption:(DAContextMenuCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AddressControlModel *model = tableViewArray[indexPath.row];
    AddAdrsInforViewController *viewController = [[AddAdrsInforViewController alloc] init];
    viewController.naviTitle    = NSLocalizedString(@"addAdrsInforAddAddressNavigationTitle", nil);
    viewController.addressModel = model;
    viewController.editLatitude = model.latitude;
    viewController.editLongitude = model.longtitude;
    viewController.isEditStatus = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
