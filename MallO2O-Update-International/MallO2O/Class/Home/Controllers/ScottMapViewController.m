//
//  ScottMapViewController.m
//  MallO2O
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ScottMapViewController.h"
#import "MapTableViewCell.h"
#import "HomeViewController.h"

#import "NearbyShopsViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "TheSearchBox.h"                //搜索框View
#import "AddressSearchViewController.h"





@interface ScottMapViewController ()<MAMapViewDelegate,AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, AMapLocationManagerDelegate, MapButtonDelega, SearchBoxDelegate>{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    NSString *currentPosition;
    NSMutableArray *cpArray;
    NSMutableArray *dataArray;
    NSArray *_pois;
    NSMutableArray *mutableArray;
}
/** 附近商家的tableView */
@property (nonatomic, strong) UITableView *scottTableView;
/**  单次定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager;
//@property (strong ,nonatomic) UISearchBar *searchBar;
/** 搜索框View */
@property (nonatomic, strong) TheSearchBox *searchBox;



@end

@implementation ScottMapViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    [self initMapView];
    
    
}

/*!
 *  视图控制器 已经显示窗口时 调用
 *
 *  @param animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self reGeoAcion];
    
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
    
    [self.navigationController.navigationBar addSubview:self.searchBox];
    
}


/*!
 *  视图控制器 即将消失, 被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
    [SVProgressHUD dismiss];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    [self.searchBar removeFromSuperview];
    [self.searchBox removeFromSuperview];
}

/*!
 *  视图控制器 已经消失, 被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}




#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
    cpArray = [NSMutableArray array];
}



- (void)initMapView{
    //配置用户Key
    [MAMapServices sharedServices].apiKey = APIKey;
    
    [AMapLocationServices sharedServices].apiKey = APIKey;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;

    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    self.locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager.reGeocodeTimeout = 3;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    //选择地图模式
//    _mapView.userTrackingMode = 1;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [_mapView setZoomLevel:16.1 animated:YES];
    // 带逆地理（返回坐标和地址信息） 
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            [SVProgressHUD showErrorWithStatus:@"网络太差了"];
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
                
            }
        }
        
        NSLog(@"location:%@", location);
//        _currentLocation = [location copy];
        self.laString = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        self.longString = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            currentPosition = [NSString stringWithFormat:@"%@%@%@",regeocode.district, regeocode.street, regeocode.number];
            [cpArray addObject:currentPosition];
        }
        
//        [UIView animateWithDuration:10 animations:^{
            [SVProgressHUD dismiss];
//        }];
        
//        [self.scottTableView reloadData];
        [self initSearch];

    }];
    
    
}




- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    } 
}

- (void)initSearch{
    [AMapSearchServices sharedServices].apiKey = APIKey;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:[self.laString floatValue] longitude:[self.longString floatValue]];
//    request.keywords = @"方恒";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
//    request.types = @"生活服务";
    request.sortrule = 0;
    request.offset = 7;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}




//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    
    NSLog(@"request: %@", request);
    NSLog(@"response: %@", response);
    
    if (response.pois.count > 0)
    {
        _pois = [response.pois mutableCopy] ;
        
        NSString *string = @"更多地址";
        
        mutableArray = [NSMutableArray arrayWithArray:_pois];
        
        [mutableArray addObject:string];
        
        dataArray = [NSMutableArray arrayWithObjects:cpArray, mutableArray,  nil];
        
        [self.scottTableView reloadData];
        
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
//    [self setNavBarTitle:@"模板控制器" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.scottTableView];
//    [self.view addSubview:self.searchBox];
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}




#pragma mark 首页tableview代理方法和数据源方法

/*
 设置tableview的组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/*
 设置tableview每组的cell数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
        return mutableArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cpCellID = @"cpCellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cpCellID];
//    if (!cell) {
//        cell =      [[UITableViewCell alloc] init];
//    }
    
    
    MapTableViewCell *cell = [MapTableViewCell mapTableViewCell:tableView cellForRowAtIndexPath:indexPath cellID:cpCellID];
    cell.delegate = self;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = currentPosition;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row < 7 ) {
            AMapPOI *poi = mutableArray[indexPath.row];
            cell.textLabel.text = poi.name;
        }else{
            cell.textLabel.text = @"更多地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
  
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 33;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"    当前地址";
    }else{
        return @"    附近地址";
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMapPOI *poi = mutableArray[indexPath.row];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 7) {
            NearbyShopsViewController *nearby = [[NearbyShopsViewController alloc] init];
            [self.navigationController pushViewController:nearby animated:YES];
        }else{
            NSArray *VCArray = self.navigationController.viewControllers;
            for (MallO2OBaseViewController *addreViewController in VCArray) {
                if ([addreViewController isKindOfClass:[HomeViewController class]]) {
                    
                    HomeViewController *addVC = (HomeViewController *)addreViewController;
                    //            addVC.name = str;
                    addVC.nameAddress = poi.name;
                    addVC.laString = [NSString stringWithFormat:@"%f", poi.location.latitude];
                    addVC.longString = [NSString stringWithFormat:@"%f", poi.location.longitude];
                    [self.navigationController popToViewController:addVC animated:YES];
                }
            }
        }
    }else{
        NSArray *VCArray = self.navigationController.viewControllers;
        for (MallO2OBaseViewController *addreViewController in VCArray) {
            if ([addreViewController isKindOfClass:[HomeViewController class]]) {
                
                HomeViewController *addVC = (HomeViewController *)addreViewController;
                //            addVC.name = str;
                addVC.laString = [NSString stringWithFormat:@"%f", poi.location.latitude];
                addVC.longString = [NSString stringWithFormat:@"%f", poi.location.longitude];
                addVC.nameAddress = currentPosition;
                [self.navigationController popToViewController:addVC animated:YES];
            }
        }
    }
    
}


- (void)buttonClick:(UIButton *)button{
    [SVProgressHUD showWithStatus:@"重新刷新中..."];
    [self initMapView];
}


#pragma mark - 代理实现
#pragma mark 开始企业车辆搜索
- (void) SearchWithString:(NSString *)string
{
    AddressSearchViewController *addressSearch = [[AddressSearchViewController alloc]init];
    addressSearch.type = string;
    [self.navigationController pushViewController:addressSearch animated:YES];
}

#pragma mark 取消企业车辆搜索
- (void) ClearSearch
{
    [self initSearch];
}



#pragma mark - 懒加载
- (UITableView *)scottTableView{
    if (!_scottTableView) {
        _scottTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _scottTableView.dataSource = self;
        _scottTableView.delegate = self;
    }
    return _scottTableView;
}


/**
 *  搜索栏
 *
 *  @return _searchBox
 */
- (TheSearchBox *) searchBox
{
    if (!_searchBox) {
        _searchBox = [[TheSearchBox alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 120 * Balance_Width, 0, 278 * Balance_Width, 40)];
//        _searchBox.layer.borderWidth = 1;
        _searchBox.searchImage  = [UIImage imageNamed:@"gray_shopcar"];
        _searchBox.tips         = @"搜索关键字";
        _searchBox.searchDelegate   = self;
    }
    return _searchBox;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
