//
//  SearchResultViewController.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SearchResultViewController.h"
#import "MiaoTableViewCell.h"
#import "SecondModel.h"
#import "GoodsWebViewController.h"
#import <MJRefresh.h>

@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SearchResultViewController{
    NSMutableArray *searchResultArray;
    int page;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
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
    searchResultArray = [[NSMutableArray alloc] init];
    [self getDataFromUrl];
}

/**
 *  获取网络数据
 */
- (void)getDataFromUrl{
    if (self.codeText == nil || [self.codeText isEqualToString:@""]) {
        NSString *str = [SwpTools swpToolGetInterfaceURL:@"product_serch"];//[NSString stringWithFormat:@"http://%@/%@",baseUrl,connect_url(@"product_serch")];//connect_url(@"product_serch");
        NSDictionary *dic = @{
                              @"app_key" : str,
                              @"like_message" : self.searchText,
                              @"page" : [NSString stringWithFormat:@"%d",page],
                              @"city_id" : GetUserDefault(City_ID)
                              };
        [self swpPublicTooGetDataToServer:str parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            
            searchResultArray = [self arrayWithParam:resultObject[@"obj"]];
            [self.searchResultTableView reloadData];
            if ([(NSMutableArray *)[resultObject objectForKey:@"obj"] count] == 0) {
                if (page == 1) {
                    [SVProgressHUD showErrorWithStatus:@"未搜索到商品"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"已获取全部商品"];
                }
                [_searchResultTableView.mj_footer setState:MJRefreshStateNoMoreData];
            }
            
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }else{
        NSString     *url = [SwpTools swpToolGetInterfaceURL:@"sweep"];//connect_url(@"sweep");
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"sweep_id" : _codeText,
                              @"page" : [NSString stringWithFormat:@"%d",page],
                              @"city_id" : GetUserDefault(City_ID),
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            if ([(NSMutableArray *)[resultObject objectForKey:@"obj"] count] == 0) {
                if (page == 1) {
                    UILabel *label = [[UILabel alloc] initForAutoLayout];
                    [self.view addSubview:label];
                    [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
                    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
                    [label autoSetDimension:ALDimensionHeight toSize:50];
                    [label autoSetDimension:ALDimensionWidth toSize:250];
                    label.numberOfLines = 2;
                    _searchResultTableView.hidden = YES;
                    label.text = @"抱歉！未找到此商品，您可以试试关键词搜索";
                    label.textColor = [UIColor grayColor];
                    return;
                }else{
                    [self.searchResultTableView.mj_footer setState:MJRefreshStateNoMoreData];
                }
            }
            searchResultArray = [self arrayWithParam:resultObject[@"obj"]];
            [self.searchResultTableView reloadData];
            
            
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }
}

/**
 *数据转模型
 */
- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = searchResultArray;
    }
    for (NSDictionary *dic in param) {
        SecondModel *model = [[SecondModel alloc] arrayWithDic:dic];
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
    [self setNavBarTitle:NSLocalizedString(@"searchHisSearchResultsNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _searchResultTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_searchResultTableView];
    _searchResultTableView.dataSource = self;
    _searchResultTableView.delegate = self;
    [SwpTools swpToolHiddleExcessedCellFromTableview:_searchResultTableView];
    
    [self swpPublicToolSettingTableViewRefreshing:_searchResultTableView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)headerRefreshingData{
    page = 1;
    [self.searchResultTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [self.searchResultTableView.mj_header endRefreshing];
}

- (void)footerRefreshingData{
    page ++;
    [self getDataFromUrl];
    [self.searchResultTableView.mj_footer endRefreshing];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_searchResultTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark 搜索结果列表委托和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchResultArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:_searchResultTableView cellForRowAtIndex:indexPath];
    [UZCommonMethod settingTableViewAllCellWire:_searchResultTableView andTableViewCell:cell];
    cell.secondModel = searchResultArray[indexPath.row];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}   
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondModel *model = searchResultArray[indexPath.row];
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.imageUrl = model.secondImgUrlText;
    viewController.shopName = model.secondTitleText;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
