//
//  PointShopViewController.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointShopViewController.h"
#import "PointShopTableViewCell.h"
/*模型*/
#import "PointShopModel.h"
/*积分兑换web页面*/
#import "PointExchangeViewController.h"
/*各个web页面*/
#import "AboutUsViewController.h"
/*积分兑换历史*/
#import "PointHistoryViewController.h"
/*积分变化列表*/
#import "PointChangeViewController.h"

#import <MJRefresh.h>

#import "LoginViewController.h"


@interface PointShopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *pointShopTableView;

@property (strong ,nonatomic) UIView *headerView;

@end

@implementation PointShopViewController{
    NSMutableArray *tableViewArray;
    NSMutableDictionary *infoDic;
    UILabel *myPoint;
    UILabel *pointLabel;
    UIButton *button;
    int page;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    
    if (_svpShowMessage != nil) {
        [self getDataFromUrl];
        [SVProgressHUD showSuccessWithStatus:_svpShowMessage];
        _svpShowMessage = nil;
    }
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    infoDic      = [[NSMutableDictionary alloc] init];
    tableViewArray = [[NSMutableArray alloc] init];
    [self getDataFromUrl];
}

/**
    获取网络数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"mall_list"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"page"    : [NSString stringWithFormat:@"%d",page],
                          @"u_id"    : [UserModel shareInstance].u_id
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        infoDic = resultObject[@"obj"];
        NSArray *array = resultObject[@"obj"][@"mall_list"];
        if (array.count == 0) {
            [_pointShopTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        tableViewArray = [self arrayWithParam:resultObject[@"obj"][@"mall_list"]];
        [self addHeaderUI:_headerView];
        [_pointShopTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = tableViewArray;
    }
    for (NSDictionary *dic in param) {
        PointShopModel *model = [PointShopModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
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
    [self setNavBarTitle:NSLocalizedString(@"pointShopNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self setNaviRightButton];
}

- (void)setNaviRightButton{
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 60* Balance_Width, 30);
    rightButton.titleLabel.font=[UIFont systemFontOfSize:13];
    rightButton.titleLabel.textColor = [UIColor blackColor];
    rightButton.imageEdgeInsets=UIEdgeInsetsMake(10, 0, 0, -40);
    [rightButton setTitle:NSLocalizedString(@"pointShopIntegralDescription", nil) forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pointExplan) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

/**
 跳转积分说明
 */
- (void)pointExplan{
    AboutUsViewController *viewController = [[AboutUsViewController alloc] init];
    NSString *messageUrl = [SwpTools swpToolGetInterfaceURL:@"yz_integral_message"];
    if (messageUrl != nil && ![messageUrl isEqualToString:@""]) {
        viewController.webUrl = [SwpTools swpToolGetInterfaceURL:@"yz_integral_message"];
    }
    viewController.naviTitle =  NSLocalizedString(@"pointShopIntegralDescription", nil);
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    _pointShopTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_pointShopTableView];
    _pointShopTableView.dataSource = self;
    _pointShopTableView.delegate   = self;
//    [_pointShopTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshingFooterData)];
//    [_pointShopTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshingHeaderData)];
//    _pointShopTableView.header.updatedTimeHidden = YES;
//    _pointShopTableView.header.stateHidden = YES;
    
    [self swpPublicToolSettingTableViewRefreshing:_pointShopTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
    [UZCommonMethod hiddleExtendCellFromTableview:_pointShopTableView];
    
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    _headerView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:_headerView];
    _headerView.layer.borderWidth = 0.6;
    _headerView.layer.borderColor = [UIColorFromRGB(0xe3e3e3) CGColor];
    _headerView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [_pointShopTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_pointShopTableView.mj_header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_pointShopTableView.mj_footer endRefreshing];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-0.6];
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-0.6];
    [_headerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-0.6];
    [_headerView autoSetDimension:ALDimensionHeight toSize:40 * Balance_Heith];
    
    [_pointShopTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40 * Balance_Heith, 0, 0, 0)];
}

#pragma mark tableview的代理方法和数据源方法
/**
    行数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
    组数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

/**
    数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PointShopTableViewCell *cell = [PointShopTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = tableViewArray[indexPath.row];
    return cell;
}

/**
    cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}

/**
 添加头部控件
 */
- (void)addHeaderUI:(UIView *)headerView{
    [myPoint removeFromSuperview];
    [pointLabel removeFromSuperview];
    [button removeFromSuperview];
    myPoint = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 85, 30 * Balance_Heith)];
    myPoint.text = NSLocalizedString(@"pointShopMyPoints", nil);
    myPoint.font = [UIFont systemFontOfSize:14 * Balance_Width];
    myPoint.textColor = UIColorFromRGB(0x585757);
    [headerView addSubview:myPoint];
    
    pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(91, 5, 200, 30 * Balance_Heith)];

    pointLabel.text = [[infoDic objectForKey:@"integral"] stringByAppendingString:NSLocalizedString(@"Integral", nil)];
    pointLabel.font = [UIFont systemFontOfSize:14 * Balance_Width];
    pointLabel.textColor = UIColorFromRGB(0xf34453);
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointHitory)];
    pointLabel.userInteractionEnabled = YES;
    [pointLabel addGestureRecognizer:gesture];
    [headerView addSubview:pointLabel];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 5, 90, 30 * Balance_Heith)];
    [button setTitle:NSLocalizedString(@"pointShopExchangeRecords", nil) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x00b0c2) forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 00, 0, 0)];
    button.titleLabel.font = [UIFont systemFontOfSize:14*Balance_Width];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(duihuan) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
}

/**
    积分变化
 */
- (void)pointHitory{
    PointChangeViewController *viewController = [[PointChangeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
    选择cell跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PointExchangeViewController *viewController = [[PointExchangeViewController alloc] init];
    PointShopModel *model = tableViewArray[indexPath.row];
    viewController.pointText = model.pointText;
    viewController.imgUrl = model.imgUrl;
    viewController.webUrl = model.messageUrl;
    viewController.model  = tableViewArray[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
    点击跳转兑换详情
 */
- (void)duihuan{
    PointHistoryViewController *viewController = [[PointHistoryViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
