//
//  MyOrderViewController.m
//  MallO2O
//
//  Created by mac on 15/6/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "OrderDetailViewController.h"
#import "MyOrderTimeModel.h"
#import <MJRefresh.h>

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UISegmentedControl *segmentControl;

@property (strong ,nonatomic) UIView *headerView;



@end

@implementation MyOrderViewController{
    NSMutableArray *orderArray;
    NSMutableArray *orderTimeArray;
    int segPage;
    int page;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"数据加载中"];

    [self initData];
    [self initUI];
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    if (![_tishiString isEqualToString:@""] && _tishiString != nil) {
        [SVProgressHUD showSuccessWithStatus:_tishiString];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [self.myOrderTableView.mj_header beginRefreshing];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    segPage = 0;
    orderArray = [[NSMutableArray alloc] init];
    orderTimeArray = [[NSMutableArray alloc] init];
//    [self getDataFromUrl];
}

/**
    从网络获取数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_order"];
    if (_selectIndex == 4) {
        _selectIndex = 5;
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id"    : GetUserDefault(U_ID),
                          @"u_id"    : [PersonInfoModel shareInstance].uID,
                          @"type"    : [NSString stringWithFormat:@"%d",(int)_selectIndex],
                          @"page"    : [NSString stringWithFormat:@"%d",page]
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        orderArray = [self arrayWithParam:resultObject[@"obj"]];
        NSArray *array = resultObject[@"obj"];
        if (array.count == 0) {
            _myOrderTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        orderTimeArray = [self arrayWithParamTwo:resultObject[@"obj"]];
        [_myOrderTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = orderArray;
        if (orderArray.count == 0) {
            page --;
        }
        NSLog(@"%@",array);
    }
    for (NSDictionary *dic in param) {
        MyOrderModel *model = [MyOrderModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

- (NSMutableArray *)arrayWithParamTwo:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = orderTimeArray;
        NSLog(@"%@",array);
    }
    for (NSDictionary *dic in param) {
        MyOrderTimeModel *model = [MyOrderTimeModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark 下拉刷新和上拉加载
- (void)headerRefreshingData{
    page = 1;
    [_myOrderTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_myOrderTableView.mj_header endRefreshing];
}

- (void)footerRefreshingData{
    page ++;
    [self getDataFromUrl];
    [_myOrderTableView.mj_footer endRefreshing];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"myOrderNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.myOrderTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_headerView autoSetDimension:ALDimensionHeight toSize:50 * Balance_Heith];
    UIView *xian = [[UIView alloc] initForAutoLayout];
    [_headerView addSubview:xian];
    [xian autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, -0.5, 0) excludingEdge:ALEdgeTop];
    [xian autoSetDimension:ALDimensionHeight toSize:1];
    xian.backgroundColor = UIColorFromRGB(0xd9d9d9);
    
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6 * Balance_Heith];
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6 * Balance_Heith];
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5 * Balance_Width];
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5 * Balance_Width];
}

#pragma mark tableview数据源方法和委托
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell = [MyOrderTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.modela = orderArray[indexPath.section];
    cell.modelb = orderTimeArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * Balance_Heith + 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webTitle = NSLocalizedString(@"orderDetailNavigationTitle", nil);
    MyOrderModel *model = orderArray[indexPath.section];
    viewController.webUrl = model.webUrl;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_user_order"];//connect_url(@"del_user_order");
        MyOrderModel *model = orderArray[indexPath.section];
        MyOrderTimeModel *timeModel = orderTimeArray[indexPath.section];
        if ([timeModel.statusString isEqualToString:@"已完成"] || [timeModel.statusString isEqualToString:@"未付款"] || [timeModel.statusString isEqualToString:@"已取消"]) {
            NSDictionary *dic = @{
                                  @"app_key" : url,
                                  @"order_id" : model.orderId
                                  };
            
            [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
                [self.myOrderTableView.mj_header beginRefreshing];
                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"myOrderDeleteSuccessMessage", nil)];
            } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
                [SVProgressHUD showErrorWithStatus:errorMessage];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"myOrderDeleteErrorMessage", nil)];
        }
    }
}

#pragma mark 初始化控件
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initForAutoLayout];
        [_headerView addSubview:self.segmentControl];
    }
    return _headerView;
}

- (UISegmentedControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initForAutoLayout];
        _segmentControl.tintColor = UIColorFromRGB(DefaultColor);
        [_segmentControl insertSegmentWithTitle:NSLocalizedString(@"myOrderAll", nil) atIndex:0 animated:NO];
        [_segmentControl insertSegmentWithTitle:NSLocalizedString(@"myOrderPendingPayment", nil) atIndex:1 animated:NO];
        [_segmentControl insertSegmentWithTitle:NSLocalizedString(@"myOrderInProgress", nil) atIndex:2 animated:NO];
        [_segmentControl insertSegmentWithTitle:NSLocalizedString(@"myOrderEvaluation", nil) atIndex:3 animated:NO];
        [_segmentControl insertSegmentWithTitle:NSLocalizedString(@"myOrderRefund", nil) atIndex:4 animated:NO];
        _segmentControl.selectedSegmentIndex = _selectIndex;
        [_segmentControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (void)segmentAction:(UISegmentedControl *)seg{
    page = 1;
    switch (seg.selectedSegmentIndex) {
            
        case 0:
            segPage = 0;
            _selectIndex = segPage;
            break;
        case 1:
            segPage = 1;
            _selectIndex = segPage;
            break;
        case 2:
            segPage = 2;
            _selectIndex = segPage;
            break;
        case 3:
            segPage = 3;
            _selectIndex = segPage;
            break;
        case 4:
            segPage = 5;
            _selectIndex = segPage;
            break;
        default:
            break;
    }
    [self.myOrderTableView.mj_header beginRefreshing];
}

- (UITableView *)myOrderTableView{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 * Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 114 * Balance_Heith) style:UITableViewStyleGrouped];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
//        [_myOrderTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshingData)];
//        [_myOrderTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingData)];
//        _myOrderTableView.header.stateHidden = YES;
//        _myOrderTableView.header.updatedTimeHidden = YES;
//        [_myOrderTableView.footer setTitle:LoadOver forState:3];
        [self swpPublicToolSettingTableViewRefreshing:_myOrderTableView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
    }
    return _myOrderTableView;
}

@end
