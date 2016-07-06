//
//  MyCollectionShopViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/4.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MyCollectionShopViewController.h"
//商家cell视图
#import "RecommendTableViewCell.h"
//商家数据模型
#import "HomeListModel.h"
//商家详情
#import "HomeRecJumpViewController.h"

@interface MyCollectionShopViewController ()<UITableViewDataSource ,UITableViewDelegate>

/**
 *  收藏商家列表
 */
@property (strong ,nonatomic) UITableView *myCollectShopTableView;

/**
 *  收藏商家模型数组
 */
@property (copy ,nonatomic)   NSArray     *collectionShopArray;

@end

@implementation MyCollectionShopViewController

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
    [self getDataFromUrl];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
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
    [self setBackButton];
    [self setNavBarTitle:NSLocalizedString(@"myCollectionShopNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.myCollectShopTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.myCollectShopTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

/**
 *  从网络获取数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"collect_shop_list"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id"    : [UserModel shareInstance].u_id
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        _collectionShopArray = [self arrayFormCollectionData:resultObject[@"obj"]];
        [self.myCollectShopTableView reloadData];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 *  数据转模型数组
 *
 *  @param paramArray 网络数据数组
 *
 *  @return 模型数组
 */
- (NSMutableArray *)arrayFormCollectionData:(NSArray *)paramArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in paramArray) {
        HomeListModel *model = [HomeListModel homeListWithDic:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark - tableview delegate  and tableview datasource
/**
 *  tableview的组数
 *
 *  @param tableView
 *
 *  @return
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 *  tableview每组的行数
 *
 *  @param tableView
 *  @param section 第几组
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionShopArray.count;
}

/**
 *  数据源方法
 *
 *  @param tableView
 *  @param indexPath 索引
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTableViewCell *cell = [RecommendTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.listModel = self.collectionShopArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82.0f * Balance_Heith;
}

/**
 *  跳转商家详情
 *
 *  @param tableView
 *  @param indexPath 索引
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeListModel *model                      = self.collectionShopArray[indexPath.row];
    HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
    viewController.imgUrl                     = model.shopImg;
    viewController.naviTitle                  = NSLocalizedString(@"homeRecJumpBusinessDetailsNavigationTitle", nil);
    viewController.shopId                     = model.shopId;
    viewController.shopAddress                = model.shopAddress;
    viewController.shopName                   = model.shopName;
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  删除收藏商家
 *
 *  @param tableView
 *  @param editingStyle 编辑模式
 *  @param indexPath 索引
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HomeListModel *model = self.collectionShopArray[indexPath.row];
        NSString *url = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_user/collect_shop"];
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"u_id" : [UserModel shareInstance].u_id,
                              @"shop_id" : model.shopId
                              };
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            [SVProgressHUD showSuccessWithStatus:@"删除收藏成功"];
            [self getDataFromUrl];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }
}

#pragma mark - 控件的懒加载
/**
 *  收藏商家列表
 *
 *  @return
 */
- (UITableView *)myCollectShopTableView{
    if (!_myCollectShopTableView) {
        _myCollectShopTableView = [[UITableView alloc] initForAutoLayout];
        [UZCommonMethod hiddleExtendCellFromTableview:_myCollectShopTableView];
        _myCollectShopTableView.delegate = self;
        _myCollectShopTableView.dataSource = self;
    }
    return _myCollectShopTableView;
}

@end
