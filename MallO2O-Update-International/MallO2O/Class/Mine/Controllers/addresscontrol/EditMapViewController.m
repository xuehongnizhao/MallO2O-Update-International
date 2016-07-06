//
//  EditMapViewController.m
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "EditMapViewController.h"

#import <CoreLocation/CLLocationManager.h>


#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#import "UINavigationController+FDFullscreenPopGesture.h"
#import "AddAdrsInforViewController.h"

@interface EditMapViewController ()<BMKPoiSearchDelegate ,BMKMapViewDelegate ,UITableViewDataSource ,UITableViewDelegate ,BMKLocationServiceDelegate ,UISearchBarDelegate>

@property (strong ,nonatomic) BMKPoiSearch *poiSearch;

@property (strong ,nonatomic) BMKMapView *baiduMapView;

@property (strong ,nonatomic) UITableView *baiduListTableView;

@property (strong ,nonatomic) BMKLocationService *locService;

@property (strong ,nonatomic) UISearchBar *searchBar;

@end

@implementation EditMapViewController{
    CLLocationCoordinate2D nowLocation;
    NSMutableArray *mapListArray;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addMapView];
    
    [self initUI];
    NSLog(@"%@",self.navigationController);
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
    [_baiduMapView viewWillAppear];
    _baiduMapView.delegate = self;
    _poiSearch.delegate = self;
//    _locService.delegate = self;
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

/**
    即将退出视图
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    [self.view endEditing:YES];
    [_baiduMapView viewWillDisappear];
    if (_locService) {
        [_locService stopUserLocationService];
    }
//    if (!IOS8) {
        _baiduMapView.delegate = nil;
        _poiSearch.delegate = nil;
        _locService.delegate =nil;
//    }
//    self.searchBar.hidden = YES;
    [self.searchBar endEditing:YES];
    [self.searchBar removeFromSuperview];
    self.searchBar = nil;
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    option.pageIndex = 0;
    option.pageCapacity = 11;
    option.location = nowLocation;
    option.radius = 1000;
    option.keyword = @"小区";
    option.sortType = BMK_POI_SORT_BY_DISTANCE;
    BOOL flag = [_poiSearch poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
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
}

/**
 *  添加控件
 */
- (void) addUI {
    if (!_searchBar) {
        [self.navigationController.navigationBar addSubview:self.searchBar];
//        self.searchBar.tintColor = SWPColor(204, 204, 204, 1);
        [self.searchBar setBarTintColor:SWPColor(204, 204, 204, 1)];
    }else{
        self.searchBar.hidden = NO;
    }
    [self.view addSubview:self.baiduListTableView];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.baiduListTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.baiduListTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.baiduMapView withOffset:0];
}

- (void)getNowLocation{
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//    [BMKLocationService setLocationDistanceFilter:1000.f];
    
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locService.distanceFilter = 1000.0f;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    [self getNowLocation];
}

- (void)addMapView{
    _baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    _baiduMapView.userTrackingMode = 1;
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    _baiduMapView.delegate = self;
    status.fLevel = 17;
    [_baiduMapView setMapStatus:status withAnimation:YES withAnimationTime:0.5];
    UIImageView *addressImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address_mapview"]];
    addressImgView.frame = CGRectMake(self.baiduMapView.frame.size.width / 2 - 7, self.baiduMapView.frame.size.height / 2 - 10, 14, 20);
    [self.view addSubview:self.baiduMapView];
    [self.view addSubview:addressImgView];
}

- (void)willStartLocatingUser {
    NSLog(@"start locate");
}


//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"%@",poiResultList.poiInfoList);
        mapListArray = (NSMutableArray *)poiResultList.poiInfoList;
        BMKPoiInfo *info = mapListArray[mapListArray.count - 1];
        NSLog(@"%f %f",info.pt.latitude ,info.pt.longitude);
        [self.baiduListTableView reloadData];
        [self.baiduListTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)getLocationFromMapViewPoint:(BMKMapView *)mapView{
    CLLocationCoordinate2D dddd = [_baiduMapView convertPoint:mapView.center toCoordinateFromView:self.baiduMapView];
    nowLocation = dddd;
    [self initData];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self getLocationFromMapViewPoint:mapView];
}

//百度地图代理 刷新位置时调用
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.baiduMapView updateLocationData:userLocation];
    _baiduMapView.centerCoordinate = userLocation.location.coordinate;
    _baiduMapView.showsUserLocation = NO;
    _baiduMapView.userTrackingMode = BMKUserTrackingModeFollow;
    _baiduMapView.showsUserLocation = YES;
    [_locService stopUserLocationService];
    nowLocation = userLocation.location.coordinate;
//    [self getLocationFromMapViewPoint];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mapListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"address_firstadrs"];
        BMKPoiInfo *info = mapListArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"当前位置\n\n%@",info.address];;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"address_mark"];
        BMKPoiInfo *info = mapListArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n\n%@" ,info.name,info.address];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [UZCommonMethod settingTableViewAllCellWire:self.baiduListTableView andTableViewCell:cell];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *VCArray = self.navigationController.viewControllers;
    BMKPoiInfo *info = mapListArray[indexPath.row];
    for (MallO2OBaseViewController *addreViewController in VCArray) {
        if ([addreViewController isKindOfClass:[AddAdrsInforViewController class]]) {
            [self.searchBar endEditing:YES];
            AddAdrsInforViewController *addVC = (AddAdrsInforViewController *)addreViewController;
            addVC.textFieldString = info.name;
            addVC.searchString = nil;
            addVC.locationCoor = nowLocation;
            [self.navigationController popToViewController:addVC animated:YES];
        }
    }
}

- (void)popViewController{
    [self.searchBar endEditing:YES];
//    _baiduMapView.delegate = nil;
//    _poiSearch.delegate = nil;
//    _locService.delegate =nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSArray *VCArray = self.navigationController.viewControllers;
    for (MallO2OBaseViewController *addreViewController in VCArray) {
        if ([addreViewController isKindOfClass:[AddAdrsInforViewController class]]) {
            [self.searchBar endEditing:YES];
            AddAdrsInforViewController *addVC = (AddAdrsInforViewController *)addreViewController;
            addVC.searchString = self.searchBar.text;
            addVC.textFieldString = nil;
            addVC.locationCoor = nowLocation;
            [self.navigationController popToViewController:addVC animated:YES];
        }
    }
}

- (void)dealloc{
    NSLog(@"");
}

- (UITableView *)baiduListTableView{
    if (!_baiduListTableView) {
        _baiduListTableView = [[UITableView alloc] initForAutoLayout];
        [UZCommonMethod hiddleExtendCellFromTableview:_baiduListTableView];
        _baiduListTableView.delegate = self;
        _baiduListTableView.dataSource = self;
    }
    return _baiduListTableView;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return searchBar.textInputMode != nil;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 -100, 12, 240, 20)];
//        _searchBar.barTintColor = SWPColor(204, 204, 204, 1);
        _searchBar.placeholder = @"请输入您的详细地址";
        _searchBar.delegate = self;
//        _searchBar.layer.borderWidth = 0.5;
//        _searchBar.layer.cornerRadius = 18;
        _searchBar.barStyle = UIBarStyleBlack;
    }
    return _searchBar;
}

@end
