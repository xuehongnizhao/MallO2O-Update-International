//
//  PointHistoryViewController.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointHistoryViewController.h"
#import "PointHisTableViewCell.h"
#import "PointHisModel.h"
#import <MJRefresh.h>
#import "ExchangDetailViewController.h"

@interface PointHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *historyTableView;

@end

@implementation PointHistoryViewController{
    NSMutableArray *tableViewArray;
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
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    tableViewArray = [[NSMutableArray alloc] init];
    [self getDataFromUrl];
}

/**
    从网络获取数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_mall_order"];//[NSString stringWithFormat:@"http://%@/%@",baseUrl, connect_url(@"my_mall_order")];
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id"    : GetUserDefault(U_ID),
                          @"u_id"    : [PersonInfoModel shareInstance].uID,
                          @"page"    : [NSString stringWithFormat:@"%d",page]
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
        [_historyTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (NSMutableArray *)arrayWithParam:(NSDictionary *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = tableViewArray;
    }
    for (NSDictionary *dic in param) {
        PointHisModel *model = [PointHisModel arrayWithDic:dic];
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
    [self setNavBarTitle:@"兑换记录" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _historyTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_historyTableView];
    [UZCommonMethod hiddleExtendCellFromTableview:_historyTableView];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;

    [self swpPublicToolSettingTableViewRefreshing:_historyTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_historyTableView.mj_footer endRefreshing];
}

- (void)refreshingHeaderData{
    page = 1;
    [self getDataFromUrl];
    [_historyTableView.mj_header endRefreshing];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_historyTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark tableview代理方法和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PointHisTableViewCell *cell = [PointHisTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    cell.model = tableViewArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangDetailViewController *viewController = [[ExchangDetailViewController alloc] init];
    PointHisModel *model = tableViewArray[indexPath.row];
    viewController.webUrl = model.messageUrl;
    viewController.naviTitle = model.goodsName;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
