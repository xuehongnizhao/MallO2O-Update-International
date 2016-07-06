//
//  HomeRecJumpViewController.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeRecJumpViewController.h"
#import "SecondModel.h"
#import "RecShopTableViewCell.h"
#import "ImgCateListView.h"

/*------------添加分类下拉列表------------*/
#import "MXPullDownMenu.h"
#import "cateInfo.h"

#import "RecShopModel.h"
#import "RecShopTableViewCell.h"

#import "GoodsWebViewController.h"

#import <MJRefresh.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "LoginViewController.h"

@interface HomeRecJumpViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

/*--------添加首页跳转推荐商家的列表--------*/
@property (strong ,nonatomic) UITableView *recListTableView;

@property (strong ,nonatomic) MXPullDownMenu *menu;

@property (strong ,nonatomic) NSString *cate_id;
@property (strong ,nonatomic) NSString *cate_order;
//-------------关于分类----------------------
@property (strong, nonatomic) NSMutableArray *cateArray;//存储分类的数组
@property (strong, nonatomic) NSMutableArray *sortArray;//存储排序的数组

@end

@implementation HomeRecJumpViewController{
    NSMutableArray *listArray;
    NSString *cateID;
    NSString *orderCate;
    int page;
    UIButton *rightButton;
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
    
    NSLog(@"%@",_shopId);
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
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 20;
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    cateID = [[NSString alloc] init];
    orderCate = [[NSString alloc] init];
    listArray  = [[NSMutableArray alloc] init];
    _cateArray = [[NSMutableArray alloc] init];
    _sortArray = [[NSMutableArray alloc] init];
    [self addArray];
    [self getDataFromUrl];
    [self getIsCollect];
}

/**
 分类（横排）的数组初始化
 */
- (void)addArray{
    [_sortArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = NSLocalizedString(@"homeRecJumpDefaultSort", nil);
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    cateInfo *info = [[cateInfo alloc] init];
    info.cate_name = NSLocalizedString(@"homeRecJumpSalesSort", nil);
    info.cate_id = @"4";
    info.son = [[NSMutableArray alloc] init];
    cateInfo *info1 = [[cateInfo alloc] init];
    info1.cate_name = NSLocalizedString(@"homeRecJumpTheLatestReleaseSort", nil);
    info1.cate_id = @"3";
    info1.son = [[NSMutableArray alloc] init];
    cateInfo *info2 = [[cateInfo alloc] init];
    info2.cate_name = NSLocalizedString(@"homeRecJumpHighestPriceSort", nil);
    info2.cate_id = @"1";
    info2.son = [[NSMutableArray alloc] init];
    cateInfo *info3 = [[cateInfo alloc] init];
    info3.cate_name = NSLocalizedString(@"homeRecJumpTheLowestPriceSort", nil);
    info3.cate_id = @"2";
    info3.son = [[NSMutableArray alloc] init];
    [_sortArray addObjectsFromArray:@[info0,info,info1,info2,info3]];
}

#pragma mark 获取网络数据
- (void)getIsCollect{
    NSString *url = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_user/if_collect_shop"];
//    if ([GetUserDefault(U_ID) isEqualToString:@""] || GetUserDefault(U_ID) == nil) {
//        SetUserDefault(@"0", U_ID);
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id" : [PersonInfoModel shareInstance].uID,
                          @"shop_id" : _shopId
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        if ([resultObject[@"obj"][@"shoucang"] integerValue] == 0) {
//            [rightButton setTitle:@"未收藏" forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"no_collect_shop"] forState:UIControlStateNormal];
            self.isCollect = @"0";
        }else{
//            [rightButton setTitle:@"已收藏" forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"is_collect_shop"] forState:UIControlStateNormal];
            self.isCollect = @"1";
        }
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
//        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}
/**
 * 获取分类信息
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"shop_cate"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"shop_id" : _shopId,
                          @"city_id" : GetUserDefault(City_ID)
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork swpResultSuccess:^(id  _Nonnull resultObject) {
        NSDictionary *dic = (NSDictionary *)resultObject;
        [self parseCateDic:dic];
        [self addCateList];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {

//        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 *  从网络获取列表数据
 */
- (void)getListInfoFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"shop_goods"];
    if (cateID == nil || cateID.length == 0) {
        cateID = @"0";
    }
    if (orderCate == nil || orderCate.length == 0) {
        orderCate = @"0";
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"shop_id" : _shopId,
                          @"page"    : [NSString stringWithFormat:@"%d",page],
                          @"cate_id" : cateID,
                          @"order"   : orderCate,
                          @"city_id" : GetUserDefault(City_ID),
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        listArray = [self arrayWithUrlArray:resultObject[@"obj"]];
        if ([(NSMutableArray *)resultObject[@"obj"] count] == 0) {
            [_recListTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [self.recListTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
//        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 数据转换成模型数组
 */
- (NSMutableArray *)arrayWithUrlArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = listArray;
    }
    for (NSDictionary *dic in param) {
        RecShopModel *model = [RecShopModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}


#pragma mark-----解析商家分类
-(void)parseCateDic :(NSDictionary*)dic
{
    [_cateArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = NSLocalizedString(@"homeRecJumpCataTitle", nil);
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    [_cateArray addObject:info0];
    
    NSArray *cateArr = [dic objectForKey:@"obj"];
    for (NSDictionary *ele in cateArr) {
        cateInfo *info = [[cateInfo alloc] initWithDictinoary:ele];
        [_cateArray addObject:info];
    }
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    [_recListTableView.mj_header beginRefreshing];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    rightButton.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([self.isCollect integerValue] == 0) {
//        [rightButton setTitle:@"未收藏" forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"no_collect_shop"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(setCollectionStatusFromNet) forControlEvents:UIControlEventTouchUpInside];
    }else{
//        [rightButton setTitle:@"已收藏" forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"is_collect_shop"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(setCollectionStatusFromNet) forControlEvents:UIControlEventTouchUpInside];
    }
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:UIColorFromRGB(0x898989) forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self setNavBarTitle:_naviTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 判断商家是否已经收藏
 */
- (void)setCollectionStatusFromNet{
    if ([GetUserDefault(IsLogin) boolValue] == NO) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if ([self.isCollect integerValue] == 0) {
        NSString *url = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_user/collect_shop"];
        self.isCollect = @"1";
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"u_id" : [PersonInfoModel shareInstance].uID,
                              @"shop_id" : _shopId
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
           
//            [rightButton setTitle:@"已收藏" forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"is_collect_shop"] forState:UIControlStateNormal];
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];

        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
//            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }else{
        self.isCollect = @"0";
        NSString *url = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_user/collect_shop"];
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"shop_id" : _shopId,
                              @"u_id" : [PersonInfoModel shareInstance].uID
                              };
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
//            [rightButton setTitle:@"未收藏" forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"no_collect_shop"] forState:UIControlStateNormal];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
//            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }
}

/**
 *  添加控件
 */
- (void) addUI {
    ImgCateListView *view = [[ImgCateListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 83 *Balance_Heith)];
//    view.layer.borderWidth = 1;
//    view.backgroundColor = [UIColor grayColor];
    [view setImgUrl:_imgUrl];
    [view setShopAddressText:_shopAddress];
    [view setDistance:_distance];
    [view setShopNameText:_shopName];
    [self.view addSubview:view];
    
    _recListTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_recListTableView];
    [_recListTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(120 * Balance_Heith, 0, 0, 0)];
    _recListTableView.delegate = self;
    _recListTableView.dataSource = self;
//    [_recListTableView.footer setTitle:LoadOver forState:3];
    [UZCommonMethod hiddleExtendCellFromTableview:_recListTableView];
    [self setRefresh];
}
/**
 給tableview添加刷新和加载
 */
- (void)setRefresh{
    [self swpPublicToolSettingTableViewRefreshing:_recListTableView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)footerRefreshingData{
    page ++;
    [self getListInfoFromUrl];
    [_recListTableView.mj_footer endRefreshing];
}

- (void)headerRefreshingData{
    page = 1;
    [_recListTableView.mj_footer setState:MJRefreshStateIdle];
    [self getListInfoFromUrl];
    [_recListTableView.mj_header endRefreshing];
}

/**
 * 添加分类列表
 */
-(void)addCateList
{
    NSArray *testArray;
    testArray = @[ _cateArray,_sortArray ];
    NSLog(@"%@",testArray);
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    CGRect rect = [[UIScreen mainScreen] bounds];
    menu.frame = CGRectMake(0, 85 * Balance_Heith, rect.size.width, 37 * Balance_Heith);
    menu.layer.borderWidth = 0.5;
    menu.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
    [self.view addSubview:menu];
    if (self.cate_name!=nil && self.cate_name.length > 0) {
        //设置标题
        [menu setCateTitle:self.cate_name];
    }
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark 分类列表的代理方法
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row selectText:(NSString *)text{
    switch (column) {
        case 0:
            cateID = text;
            break;
        case 1:
            orderCate = text;
            break;
        default:
            break;
    }
    [self getListInfoFromUrl];
}

#pragma mark talbeview的代理方法和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecShopTableViewCell *cell = [RecShopTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    cell.model = listArray[indexPath.row];
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83 * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    RecShopModel *model = listArray[indexPath.row];
    viewController.webViewUrl = model.urlStr;
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.shopName = model.goods_name;
    viewController.imageUrl = model.imgUrl;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
