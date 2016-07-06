//
//  ShopMapViewController.m
//  MallO2O
//
//  Created by mac on 9/21/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "ShopMapViewController.h"

#import "HomeListModel.h"


#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKOverlayView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

#import "UINavigationController+FDFullscreenPopGesture.h"

#import "MapShopTurnView.h"
#import "HomeRecJumpViewController.h"

@interface ShopMapViewController ()<BMKMapViewDelegate ,BMKLocationServiceDelegate ,MapShopTurnViewDelegate>

@property (strong ,nonatomic) BMKMapView *baiduMapView;

@property (strong ,nonatomic) BMKLocationService *locService;

@end

@implementation ShopMapViewController{
    NSMutableArray *annotationArray;
    int i;
    MapShopTurnView *view1;
    BOOL isFirstClickAnnotation;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getBaiduLocation];
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
    [_baiduMapView viewWillAppear];
    _baiduMapView.delegate = self;
    _locService.delegate = self;
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 20;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_baiduMapView viewWillDisappear];
    if (_locService) {
        [_locService stopUserLocationService];
    }
    _baiduMapView.delegate = nil;
    _locService.delegate = nil;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    annotationArray = [NSMutableArray array];
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
    [self setNavBarTitle:@"地图" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.baiduMapView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    [_baiduMapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)getBaiduLocation{
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//    [BMKLocationService setLocationDistanceFilter:1000.f];
    
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locService.distanceFilter = 1000.f;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];
}

//百度地图代理 刷新位置时调用
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.baiduMapView updateLocationData:userLocation];
    _baiduMapView.centerCoordinate = userLocation.location.coordinate;
    _baiduMapView.showsUserLocation = NO;
    _baiduMapView.userTrackingMode = BMKUserTrackingModeFollow;
    _baiduMapView.showsUserLocation = YES;
//    [self getMapAnnotationFormUrl:userLocation];
    [self addAnnotation];
    [_locService stopUserLocationService];
}


- (void)addAnnotation{
    for (i = 0; i < _shopArray.count; i ++) {
        HomeListModel *model = _shopArray[i];
        // 添加一个PointAnnotation
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = CLLocationCoordinate2DMake([model.latitude floatValue], [model.longtitude floatValue]);
        annotation.title = model.shopAddress;
        [_baiduMapView addAnnotation:annotation];
    }
}

- (NSMutableArray *)shopArrayFromParamArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        HomeListModel *model = [HomeListModel homeListWithDic:dic];
        [array addObject:model];
    }
    return array;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.tag = i;
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        NSLog(@"%@",annotation);
        HomeListModel *model = _shopArray[i];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [img sd_setImageWithURL:[NSURL URLWithString:[@"http:// shop.youzhiapp.com/" stringByAppendingString:model.shopImg]]];
        newAnnotationView.image = [UIImage imageNamed:@"address_mapview"];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    if (view1) {
        view1.hidden = YES;
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    if (!isFirstClickAnnotation) {
        if (!view1) {
            view1 = [[MapShopTurnView alloc] initForAutoLayout];
            [self.view addSubview:view1];
            [view1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 20, 0, 20) excludingEdge:ALEdgeBottom];
            [view1 autoSetDimension:ALDimensionHeight toSize:80];
            view1.tag = view.tag;
            HomeListModel *model = _shopArray[view.tag];
            view1.model = model;
            view1.delegate = self;
            view1.layer.cornerRadius = 5;
            view1.layer.masksToBounds = YES;
            view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        }else{
            HomeListModel *model = _shopArray[view.tag];
            view1.model = model;
            view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
            view1.tag = view.tag;
            view1.hidden = NO;
        }
    }else{
        HomeListModel *model = _shopArray[view.tag];
        view1.model = model;
        view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        view1.tag = view.tag;
        view1.hidden = YES;
    }
}

- (void)clickMapShopToTurnView:(NSInteger)index{
    HomeListModel *model = _shopArray[index];
    HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
    viewController.imgUrl = model.shopImg;
    viewController.naviTitle = model.shopName;
    viewController.shopId = model.shopId;
    viewController.shopAddress = model.shopAddress;
    viewController.shopName = model.shopName;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    view1.hidden = YES;
}

- (void)dealloc{
    NSLog(@"——asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf内存释放asdfadsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfasdf");
}

- (BMKMapView *)baiduMapView{
    if (!_baiduMapView) {
        _baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _baiduMapView.delegate = self;
        BMKMapStatus *status = [[BMKMapStatus alloc] init];
        status.fLevel = 17;
        _baiduMapView.showsUserLocation = NO;
        _baiduMapView.delegate          = self;
        _baiduMapView.userTrackingMode  = BMKUserTrackingModeFollow;
        [_baiduMapView setMapStatus:status withAnimation:YES withAnimationTime:10];
        _baiduMapView.showsUserLocation = YES;
        _baiduMapView.zoomLevel = 17;
    }
    return _baiduMapView;
}

@end
