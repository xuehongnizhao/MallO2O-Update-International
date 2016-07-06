//
//  MyCollectionViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "GoodsWebViewController.h"
#import "MiaoTableViewCell.h"
#import "SecondModel.h"
#import <MJRefresh.h>

@interface MyCollectionViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *myCollectionTableView;

@end

@implementation MyCollectionViewController{
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
    page = 1;
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
    [self.myCollectionTableView.mj_header beginRefreshing];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    tableViewArray = [[NSMutableArray alloc] init];
}

/**
    获取网络数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_collect"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"page"    : [NSString stringWithFormat:@"%d",page],
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
    
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
        [_myCollectionTableView reloadData];
        if ([(NSArray *)resultObject[@"obj"] count] == 0) {
            [_myCollectionTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [self.myCollectionTableView.mj_header endRefreshing];
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
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"myCollectionNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _myCollectionTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_myCollectionTableView];
    _myCollectionTableView.delegate = self;
    _myCollectionTableView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_myCollectionTableView];
//    [_myCollectionTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshingFooterData)];
//    [_myCollectionTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshingHeaderData)];
    [self swpPublicToolSettingTableViewRefreshing:_myCollectionTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [_myCollectionTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
//    [_myCollectionTableView.header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_myCollectionTableView.mj_footer endRefreshing];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_myCollectionTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark tableview的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    cell.secondModel = tableViewArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController= [[GoodsWebViewController alloc] init];
    SecondModel *model = tableViewArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}


//进入编辑模式，按下出现的编辑按钮后  点击删除按钮执行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1");
    SecondModel *model = tableViewArray[indexPath.row];
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_collect"];//connect_url(@"del_collect");
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"collect_id" : model.collect_id
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        //            [self getDataFromUrl];
        [_myCollectionTableView.mj_header beginRefreshing];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    [tableView setEditing:NO animated:YES];
}

@end
