//
//  SeleRankViewController.m
//  MallO2O
//
//  Created by mac on 15/6/16.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SeleRankViewController.h"
#import "SecondModel.h"
#import "MiaoTableViewCell.h"
#import "GoodsWebViewController.h"
#import <MJRefresh.h>

@interface SeleRankViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *seleRankTableView;

@end

@implementation SeleRankViewController{
    int page;
    NSMutableArray *seleRankArray;
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
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
//    [self getDataFromUrl];
    
}

#pragma mark 获取排行榜列表的网络数据
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"charts_product"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"page"    : [NSString stringWithFormat:@"%d",page],
                          @"city_id" : GetUserDefault(City_ID)
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        seleRankArray = [self arrayWithParam:resultObject[@"obj"]];
        if ([(NSMutableArray *)resultObject[@"obj"] count] == 0) {
            [_seleRankTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [_seleRankTableView reloadData];
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 将网络数据转换成模型数组
 */
- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = seleRankArray;
    }
    for (NSDictionary *dic in param) {
        SecondModel *model = [SecondModel initWithModel:dic];
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
    [_seleRankTableView.mj_header beginRefreshing];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"seleRankNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _seleRankTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_seleRankTableView];
    _seleRankTableView.delegate = self;
    _seleRankTableView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_seleRankTableView];
    [self swpPublicToolSettingTableViewRefreshing:_seleRankTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
    
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [_seleRankTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_seleRankTableView.mj_header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_seleRankTableView.mj_footer endRefreshing];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_seleRankTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark 设置tableview数据源方法和委托
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return seleRankArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    cell.secondModel = seleRankArray[indexPath.row];
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondModel *model = seleRankArray[indexPath.row];
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.shopName = model.secondTitleText;
    viewController.webViewUrl = model.webUrl;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
