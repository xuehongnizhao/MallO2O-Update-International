//
//  NearByShopViewController.m
//  MallO2O
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "NearByShopViewController.h"

#import "CSqlite.h"                             // 定位
#import "CoreLocation/CoreLocation.h"

#import "MXPullDownMenu.h"
#import "cateInfo.h"

/*-------跳转商家的商品列表-------*/
#import "HomeRecJumpViewController.h"
#import "ShopMapViewController.h"

/*--------可以用首页列表样式-------*/
#import "RecommendTableViewCell.h"
#import "HomeListModel.h"

#import <WebKit/WebKit.h>

/*--------添加上啦加载和下拉刷新空间-------*/
#import <MJRefresh.h>

@interface NearByShopViewController ()<CLLocationManagerDelegate,MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) WKWebView *webViewsd;

/** 定位 */
@property (strong, nonatomic) CLLocationManager *locationManager;
/** 查询sql */
@property (strong, nonatomic) CSqlite           *m_sqlite;

/** 定义一个分类下拉列表 */
//@property (strong ,nonatomic) MXPullDownMenu *menu;

@property (strong ,nonatomic) NSString *cate_id;//网络数据的分类ID
@property (strong ,nonatomic) NSString *cate_order;//自定义分类传递参数
@property (strong ,nonatomic) UITableView *cateTabelView;

//-------------关于分类----------------------
@property (strong, nonatomic) NSMutableArray *cateArray;//存储分类的数组
@property (strong, nonatomic) NSMutableArray *sortArray;//存储排序的数组
@property (strong, nonatomic) NSMutableArray *nearbyShopArray;
@property (copy ,nonatomic)   NSString       *cate_name;

//--------------添加tableview------------
@property (strong ,nonatomic) UITableView *nearbyTableView;

@end

@implementation NearByShopViewController{
    NSString *shopCateId;
    NSString *locationID;
    NSMutableArray *nearbyListArray;
    int page;
    MXPullDownMenu *menu;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDefaultCateList];
    [self openLocation];
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
    [SVProgressHUD showWithStatus:@"获取数据中..."];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    shopCateId = @"0";
    _nearbyShopArray = [NSMutableArray array];
    locationID = [[NSString alloc] init];
    _sortArray = [NSMutableArray array];//[[NSMutableArray alloc] init];
    [self addArray];
    _cateArray = [NSMutableArray array];//[[NSMutableArray alloc] init];
   
//    [self getLocationIdFromUrl];

}

- (void)addArray{
    [_sortArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_id   = @"0";
    info0.cate_name = @"默认排序";
    [_sortArray addObject:info0];
    cateInfo *info2 = [[cateInfo alloc] init];
    info2.cate_id = @"1";
    info2.cate_name = @"销量排序";
    [_sortArray addObject:info2];
    
    cateInfo *info3 = [[cateInfo alloc] init];
    info3.cate_id = @"2";
    info3.cate_name = @"好评排序";
    [_sortArray addObject:info3];
    
    cateInfo *info4 = [[cateInfo alloc] init];
    info4.cate_id = @"3";
    info4.cate_name = @"低价格排序";
    [_sortArray addObject:info4];
    
    cateInfo *info5 = [[cateInfo alloc] init];
    info5.cate_id = @"4";
    info5.cate_name = @"高价格排序";
    [_sortArray addObject:info5];
    
    [_nearbyShopArray removeAllObjects];
    cateInfo *info1 = [[cateInfo alloc] init];
    info1.cate_id = @"0";
    info1.cate_name = @"分类";
    [_nearbyShopArray addObject:info1];
}

#pragma mark 获取网络数据
/**
 * 获取列表信息
 */
- (void)getDataFromUrl{
    
    
    
//    if (self.newPage == YES) {
//        NSString *url = [SwpTools swpToolGetInterfaceURL:@"ac_shop/weishop_list"];
//        
//        NSDictionary *dict = @{
//                               @"app_key"   :   url,
//                               @"lat" : self.baidu_lat,
//                               @"lng" : self.baidu_lng,
//                               @"district_id"   :   locationID,
//                               @"order"     :   @"0",
//                               @"cate_id"   :
//                               }
//    }
    
    
    
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"shop_list"];
    if (locationID == nil || [locationID isEqualToString:@""]) {
        locationID = @"0";
    }
    if (self.baidu_lng == nil) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"nearByShopError01Title", nil)];
        return;
    }
    if (self.baidu_lat == nil) {
        _baidu_lat = @"0";
    }
    
    if (self.near == YES) {
        shopCateId = [NSString stringWithFormat:@"%@", self.typeID];
    }
    
    
    
    if (self.newPage == YES) {
//        NSString *url = [SwpTools swpToolGetInterfaceURL:@"weishop_list"];
        url = [SwpTools swpToolGetInterfaceURL:@"weishop_list"];
    }
    
    
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"lat" : self.baidu_lat,
                          @"lng" : self.baidu_lng,
                          @"district_id" : locationID,
                          @"page" : [NSString stringWithFormat:@"%d",page],
                          @"cate_id" : [NSString stringWithFormat:@"%@",shopCateId]
                          };
//    [SVProgressHUD showWithStatus:@"获取数据中..." maskType:SVProgressHUDMaskTypeBlack];
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        nearbyListArray = [self modelArrayWithNetArray:resultObject[@"obj"]];
        NSArray *array = resultObject[@"obj"];
        if ([array count] == 0) {
            [_nearbyTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [_nearbyTableView reloadData];
        [SVProgressHUD dismiss];
//        [self setNaviText:NSLocalizedString(@"nearByShopNavigationTitle", nil)];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 数据转换成数组模型
 */
- (NSMutableArray *)modelArrayWithNetArray:(NSMutableArray *)param{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (page != 1) {
        array = nearbyListArray;
    }
    for (NSDictionary *dic in param) {
        HomeListModel *model = [[HomeListModel alloc] modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

/**
 * 获取地区ID
 */
- (void)getLocationIdFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"area_list"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        NSDictionary *dic = (NSDictionary *)resultObject;
        //            [SVProgressHUD showSuccessWithStatus:@"定位成功"];
        [self parseCateDic:dic];
        [self getShopCateFromUrl];
        //            [self getDataFromUrl];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}
/**
 *  获取分类数据 
 */
- (void)getShopCateFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"new_shop_cate_list"];
    NSDictionary *dic = @{
                          @"app_key" : url
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [self shopCateDic:resultObject];
        [self addCateList];

    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

#pragma mark-----解析商家分类
-(void)parseCateDic :(NSDictionary*)dic
{
    [_cateArray removeAllObjects];
//    cateInfo *info0 = [[cateInfo alloc] init];
//    info0.cate_name = NSLocalizedString(@"nearByShopNearbyTitle", nil);
//    info0.cate_id = @"0";
//    info0.son = [[NSMutableArray alloc] init];
//    [_cateArray addObject:info0];
    
    NSArray *cateArr = [dic objectForKey:@"obj"];
    for (NSDictionary *ele in cateArr) {
        cateInfo *info = [[cateInfo alloc] initWithDictinoary:ele];
        [_cateArray addObject:info];
    }
}

- (void)shopCateDic:(NSDictionary *)dic{
    [_nearbyShopArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = @"分类";
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    [_nearbyShopArray addObject:info0];
    NSArray *cateArray = [dic objectForKey:@"obj"];
    for (NSDictionary *ele in cateArray) {
        cateInfo *info = [[cateInfo alloc] initWithDictinoary:ele];
        [_nearbyShopArray addObject:info];
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
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setBackButton];
    [self setNavBarTitle:self.naviTitle withFont:NAV_TITLE_FONT_SIZE];
    
    [self settingRightButton];
}

/**
 设置导航栏右侧按钮
 */
- (void)settingRightButton{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(mapView) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"near_shop_map_no"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"near_shop_map_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)mapView{
    ShopMapViewController *viewController = [[ShopMapViewController alloc] init];
    viewController.shopArray = nearbyListArray;
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    _nearbyTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_nearbyTableView];
    [_nearbyTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(33, 0, 0, 0)];
    _nearbyTableView.delegate = self;
    _nearbyTableView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_nearbyTableView];
//    [_nearbyTableView.footer setTitle:LoadOver forState:3];
//    [_nearbyTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshingData)];
//    [_nearbyTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingData)];
//    _nearbyTableView.header.updatedTimeHidden = YES;
//    _nearbyTableView.header.stateHidden = YES;
    [self swpPublicToolSettingTableViewRefreshing:_nearbyTableView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
}

/**
 *  添加分类下拉列表
 */
-(void)addCateList
{
    NSArray *testArray = [NSArray array];
    
    NSLog(@"%@ - %@",_cateArray, _sortArray);
    testArray = @[ _cateArray,_nearbyShopArray];
    NSLog(@"%@",testArray);
    if (menu) {
        [menu removeFromSuperview];
        menu = nil;
    }
    menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    CGRect rect = [[UIScreen mainScreen] bounds];
    menu.frame = CGRectMake(0, 0, rect.size.width, 37 * Balance_Heith);
    menu.layer.borderWidth = 0.5;
    menu.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
    [self.view addSubview:menu];
    if (self.cate_name!=nil && self.cate_name.length > 0) {
        //设置标题
        [menu setCateTitle:self.cate_name];
    }
    [menu setCateTitle:NSLocalizedString(@"nearByShopNearbyTitle", ni)];
    [_nearbyTableView.mj_header beginRefreshing];
}

/**
    添加一个默认分类
    提高用户体验度
 */
- (void)addDefaultCateList{
    NSArray *testArray = [NSArray array];
    NSLog(@"%@ - %@",self.cateArray, _sortArray);
    _cateArray = [[NSMutableArray alloc] init];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = NSLocalizedString(@"nearByShopNearbyTitle", nil);
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    [_cateArray addObject:info0];
    
    _nearbyShopArray = [[NSMutableArray alloc] init];
    cateInfo *info2 = [[cateInfo alloc] init];
    info2.cate_id = @"0";
    info2.cate_name = NSLocalizedString(@"nearByShopCateTitle", nil);
    info2.son = [[NSMutableArray alloc] init];
    [_nearbyShopArray addObject:info2];
    
    _sortArray = [[NSMutableArray alloc] init];
    cateInfo *info1 = [[cateInfo alloc] init];
    info1.cate_name = @"默认排序";
    info1.cate_id = @"0";
    info1.son = [[NSMutableArray alloc] init];
    [_sortArray addObject:info1];
    
    testArray = @[ _cateArray,_nearbyShopArray];
    NSLog(@"%@",testArray);
    
    menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    CGRect rect = [[UIScreen mainScreen] bounds];
    menu.frame = CGRectMake(0, 0, rect.size.width, 33 * Balance_Heith);
    menu.layer.borderWidth = 0.5;
    menu.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
    [self.view addSubview:menu];
    if (self.cate_name!=nil && self.cate_name.length > 0) {
        //设置标题
        [menu setCateTitle:self.cate_name];
    }
    [menu setCateTitle:NSLocalizedString(@"nearByShopNearbyTitle", nil)];
//    [_nearbyTableView.header beginRefreshing];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark 上啦加载和下拉刷新
- (void)headerRefreshingData{
    page = 1;
    [_nearbyTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_nearbyTableView.mj_header endRefreshing];
}

- (void)footerRefreshingData{
    page ++;
    [self getDataFromUrl];
    [_nearbyTableView.mj_footer endRefreshing];
}

#pragma mark------定位功能
-(void)openLocation {
    [self setNavBarTitle:@"asdf" withFont:NAV_TITLE_FONT_SIZE];
    self.m_sqlite = [[CSqlite alloc]init];
    [self.m_sqlite openSqlite];
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate        = self;
        self.locationManager.distanceFilter  = 0.5;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation]; // 开始定位
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [self.locationManager requestAlwaysAuthorization];
        }
    }
}


#define x_pi (3.14159265358979324 * 3000.0 / 180.0)
#pragma mark------转换坐标
-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    NSLog(@"slq = %@", sql);
    sqlite3_stmt* stmtL = [self.m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
    }
    yGps.latitude = yGps.latitude + offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
}

#pragma mark------定位delegate
// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"定位成功");
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    NSString *u_lat = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    NSString *u_lng = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    NSLog(@"未经过转换的经纬度是%@---%@",u_lat,u_lng);
    mylocation = [self zzTransGPS:mylocation];
    self.baidu_lat = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
    self.baidu_lng = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
    double lat     = [self.baidu_lat floatValue];
    double lng     = [self.baidu_lng floatValue];
    double baiDuLat , baiDuLng;
    double x = lng, y = lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    baiDuLng = z * cos(theta) + 0.0065;
    baiDuLat = z * sin(theta) + 0.006;
    self.baidu_lat = [NSString stringWithFormat:@"%f",baiDuLat];
    self.baidu_lng = [NSString stringWithFormat:@"%f",baiDuLng];
    [self.locationManager stopUpdatingLocation]; // 关闭定位
    
    NSLog(@"%@", self.baidu_lat);
    NSLog(@"%@", self.baidu_lng);
    
    self.baidu_lng = self.baidu_lng == nil ? @"0" : self.baidu_lng;
    self.baidu_lat = self.baidu_lat == nil ? @"0" : self.baidu_lat;
    
    SetUserDefault(self.baidu_lat, @"baidu_lat");
    SetUserDefault(self.baidu_lng, @"baidu_lng");
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.latitude longitude:mylocation.longitude];
    ///获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks,NSError *error)
     {
//         if (placemarks.count >0   )
//         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSString * country     = plmark.country;
             NSString * cityName    = plmark.locality;
             //将城市地址 显示并获取城市id
             //             [leftButton setTitle:[NSString stringWithFormat:@"%@﹀",cityName] forState:UIControlStateNormal];
             //             [self getCity:cityName];
             cityName               = cityName == nil ? @"定位失败" : cityName;
//             self.currentCityName   = cityName;
//             [self leftButtonSetTitle:cityName];
//             [self getCityIdData:cityName];
             [self getLocationIdFromUrl];
             
             NSLog(@"%@-%@-%@",country,cityName,plmark.name);
//         }
         NSLog(@"%@",placemarks);
     }];
    
    
    //    [self getHomeImageData];
//    [self getDataFromUrl];
}

// 定位失败时调用
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"nearByShopLocationErrorTitle", nil)];
    [self setNavBarTitle:NSLocalizedString(@"nearByShopLocationErrorTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
//    [self getHomeImageData];
}

/**
 mxpull的委托 点击事件
 */
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row selectText:(NSString *)text{
    page = 1;
    if (self.baidu_lng == nil) {
        [SVProgressHUD showErrorWithStatus:@"未获取到经纬度"];
        return;
    }
    switch (column) {
        case 0:
            NSLog(@"%@",text);
            locationID = text;
            break;
        case 1:
            shopCateId = text;
            break;
        default:
            break;
    }
    [_nearbyTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
}

#pragma mark tableview的委托和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return nearbyListArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTableViewCell *cell = [RecommendTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
    [UZCommonMethod settingTableViewAllCellWire:_nearbyTableView andTableViewCell:cell];
    cell.listModel = nearbyListArray[indexPath.row];
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.0f * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
    HomeListModel *model = nearbyListArray[indexPath.row];
    viewController.naviTitle = model.shopName;
    viewController.imgUrl = model.shopImg;
    viewController.shopId = model.shopId;
    viewController.shopName = model.shopName;
    viewController.shopAddress = model.shopAddress;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
