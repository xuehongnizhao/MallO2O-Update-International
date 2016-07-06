//
//  HomeViewController.m
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
/**
 *
 *
 *  @param <UITableViewDataSource
 *  @param UITableViewDelegate
 *  @param AdBannerViewDelegate             点击轮播的代理
 *  @param ButtonTableViewCellDelegate      点击分类按钮
 *  @param HomeImageTableViewCellDelegate   点击推荐图片代理
 *  @param BannerTableViewCellDelegate      ？？
 *  @param FindCodeViewControllerDelegate   扫码页面的代理  用于传值
 *  @param HomeImageUpTableViewCellDelegate 点击推荐图片代理  上面和下面两种样式其中一个  我忘了是哪个了
 *  @param BMKLocationServiceDelegate       ！！！！！问题爆发点
 *  @param CLLocationManagerDelegate
 *  @param UIAlertViewDelegate
 *  @param strong
 *  @param nonatomic
 *
 *  @return
 */
/*-----三方库------*/
#import "AdBannerView.h"
#import "SwpGuidePage.h"
#import <MJRefresh.h>
//#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h> //菜单栏
#import "CSqlite.h"                             // 定位
/*-----三方库------*/

#import "HomeViewController.h"
/*-----分类按钮-----*/
#import "ButtonTableViewCell.h"
/*-----轮播cell-----*/
#import "BannerTableViewCell.h"
/*-----图片的cell----*/
#import "HomeImageTableViewCell.h"
/*-----首页图片的另一种格式cell-----*/
#import "HomeImageUpTableViewCell.h"
/*-----推荐商家cell----*/
#import "RecommendTableViewCell.h"
/*-----首页按钮模型----*/
#import "HomeBtnModel.h"
/*-----首页图片模型----*/
#import "HomeImgModel.h"
/*-----首页列表模型-----*/
#import "HomeListModel.h"
/*-----推荐商家页面-----*/
#import "SpecialViewController.h"
/*-----分类跳转页面-----*/
#import "CateJumpViewController.h"
/*-----搜索历史页面-----*/
#import "SearchHisViewController.h"
/*-----团购抢购页面-----*/
#import "TeamBuyingViewController.h"
/*-----首页跳转分类商品页面-----*/
#import "CateGoodsViewController.h"
/*-----附近商家页面-----*/
#import "NearByShopViewController.h"
/*-----首页商家列表跳转页面-----*/
#import "HomeRecJumpViewController.h"
/*-----排行榜页面-----*/
#import "SeleRankViewController.h"
/*-----积分商城页面-----*/
#import "PointShopViewController.h"
/*-----登录-----*/
#import "LoginViewController.h"
/*-----扫描条形码-----*/
#import "FindCodeViewController.h"
/*-----扫码后跳转的搜索结果页面-----*/
#import "SearchResultViewController.h"
#import "BannerImgModel.h"

#import "EditMapViewController.h"

//  跳转商品详情页   切换单商家时使用
#import "GoodsWebViewController.h"

#import "OrderDetailViewController.h"

#import "UINavigationController+FDFullscreenPopGesture.h"

// 跳转选择城市列表
#import "HomeSelectedCityViewController.h"

#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>

//#import <BaiduMapAPI/BMKLocationService.h>
//#import <BaiduMapAPI/BMKUserLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "ScottMapViewController.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


#define HomeAppKey @"action/ac_base/index_data"
#define APIKey      @"9a0ce02ea76ece93783f589406b0f19a"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,AdBannerViewDelegate, ButtonTableViewCellDelegate,HomeImageTableViewCellDelegate,BannerTableViewCellDelegate,FindCodeViewControllerDelegate,HomeImageUpTableViewCellDelegate ,BMKLocationServiceDelegate ,CLLocationManagerDelegate ,UIAlertViewDelegate ,HomeSelectedCityViewControllerDelegate,MAMapViewDelegate,AMapSearchDelegate, AMapLocationManagerDelegate>
//-----------
/** 定位 */
@property (strong, nonatomic) CLLocationManager *locationManager;

/** 查询sql */
@property (strong, nonatomic) CSqlite           *m_sqlite;

/** 定位纬度 */
@property (copy, nonatomic)   NSString          *baidu_lat;

/** 定位经度 */
@property (copy, nonatomic)   NSString          *baidu_lng;

//-----------
/**
 *  首页tableview
 */
@property (strong ,nonatomic) UITableView *homeTableView;
/**
 *  定位服务
 */
@property (strong ,nonatomic) BMKLocationService *locService;
/**
 *  定位管理者
 */
@property (strong ,nonatomic) CLLocationManager *locationgManager;
/**
 *  检查系统更新时的黑屏
 */
@property (strong ,nonatomic) UIView *blackView;
/**
 *  更新的视图
 */
@property (strong ,nonatomic) UIView *updateView;
/**
 *  更新视图的图片
 */
@property (strong ,nonatomic) UIImageView *updateImageView;
/**
 *  更新视图取消
 */
@property (strong ,nonatomic) UIButton *cancleButton;
/**
 *  确定
 */
@property (strong ,nonatomic) UIButton *updateButton;
/**
 *  更新视图的文字
 */
@property (strong ,nonatomic) UILabel *updateLabel;
/**
 *  城市按钮
 */
@property (strong ,nonatomic) UIButton *cityButton;

@property (strong ,nonatomic) UIButton *titleButton;
/**  单次定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager2;

@end

@implementation HomeViewController{
    NSMutableArray *cateArray;//分类数组
    NSMutableArray *specialArray;//推荐商家数组
    NSMutableArray *listArray;//推荐商家列表的数组
    NSMutableArray *bannerImgArray;//轮播图片数组
    int page;//分页数
    NSMutableArray *arraya;//图片的数组
    NSIndexPath *selectIndexPath;//选择的cell
    NSString *latitude;
    NSString *longtitude;
    BOOL isFirst;
    
    NSString *city;
    NSString *district_id;
    float longtitude1;
    
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    
     NSString *currentPosition;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingSwpGuidePage];
//    [self openLocation];
    [self settingNav];
    
    
    
    [self initUI];
    [self initData];
    //    [self checkUpdate];
    //    [self getDataFromUrl];
    //配置用户Key
    [MAMapServices sharedServices].apiKey = APIKey;
    
    [AMapLocationServices sharedServices].apiKey = APIKey;
    self.locationManager2 = [[AMapLocationManager alloc] init];
    self.locationManager2.delegate = self;
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager2 setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    self.locationManager2.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager2.reGeocodeTimeout = 3;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    [self initMapView];
}

/**
 *  选择其中一个方法
 */
- (void)cityBool{
//    多城市方法
    [self setCity];
//    单城市方法
//    [self settingNav];
}
/**
 *  设置城市按钮
 */
- (void)setCity{
    if (!_cityButton) {
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityButton.frame = CGRectMake(SCREEN_WIDTH/2 - 50, 8, 100, 30);
    }
    //    UIImageView *imageview = [[UIImageView alloc] init];
    //    imageview.frame = CGRectMake(_cityButton.frame.origin.x + _cityButton.frame.size.width, 10, 25, 25);
    //    imageview.image = [UIImage imageNamed:@"1"];
    UIImage *image = [UIImage imageNamed:@"select_city"];
    [_cityButton setImage:image forState:UIControlStateNormal];
    [_cityButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, 0)];
    [_cityButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, -20)];
    //    [self.navigationController.navigationBar addSubview:imageview];
    [_cityButton setTitle:@"选择城市" forState:UIControlStateNormal];
    _cityButton.hidden = YES;
    if (GetUserDefault(City_Name) != nil) {
        [_cityButton setTitle:[GetUserDefault(City_Name) stringByAppendingString:@""] forState:UIControlStateNormal];
    }
    [_cityButton addTarget:self action:@selector(selecCity) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_cityButton];
}

/**
 *  检查更新
 */
- (void)checkUpdate{
    NSString *ssss = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *array = [ssss componentsSeparatedByString:@"."];
    NSString *asdddddf= [[NSString alloc] init];
    for (NSString *asdf in array) {
        asdddddf = [asdddddf stringByAppendingString:asdf];
    }
    NSString *url = [NSString stringWithFormat:@"http://%@/%@", baseUrl, @"action/ac_base/check_version"];//@"action/ac_base/check_version";
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"version" : @"2",
                          @"city_id" : GetUserDefault(City_ID)
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        NSArray *versionArray = [resultObject[@"obj"][@"version"] componentsSeparatedByString:@"."];
        NSString *intVersion = [[NSString alloc] init];
        for (NSString *versionNum in versionArray) {
            intVersion = [intVersion stringByAppendingString:versionNum];
        }
        if ([intVersion integerValue] != [asdddddf integerValue]) {
            [UIView animateWithDuration:0.4 animations:^{
                self.blackView.alpha = 0.7;
                self.updateView.alpha = 1;
            }];
        }
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}
///**
// *  开启定位
// */
//- (void)getLocation{
//    if ([CLLocationManager locationServicesEnabled] &&
//        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
//         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
//            //定位功能可用，开始定位
//            _locationgManager = [[CLLocationManager alloc] init];
//            _locationgManager.delegate = self;
//            [_locationgManager startUpdatingLocation];
//        }
//    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
//        NSLog(@"定位功能不可用，提示用户或忽略");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未开启定位服务，将无法体验全部功能" delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去开启", nil];
//        [alert show];
//    }
////    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
////    [BMKLocationService setLocationDistanceFilter:1000.f];
//    _locService.distanceFilter = 1000.f;
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
//    
//}

/**
 *  alert的委托   判断是否允许定位
 *
 *  @param alertView
 *  @param buttonIndex button的索引
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if(IOS8) {
            NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:url];
            return;
        }
    }
    if (buttonIndex == 0) {
//        [self settingSwpGuidePage];
//        [self initData];
//        [self initUI];
//        [self getDataFromUrl];
    }
}

////百度地图代理 刷新位置时调用
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    BMKUserLocation *location = userLocation;
//    latitude = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
//    longtitude = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
//    [self initUI];
//    [self initData];
//    
//    [self getDataFromUrl];
////    if (!isFirst) {
//        [self checkUpdate];
//        isFirst = !isFirst;
////    }
//    [_locService stopUserLocationService];
//}

- (void)didFailToLocateUserWithError:(NSError *)error{
    [self settingSwpGuidePage];
    [self initData];
    [self initUI];
//    [self getDataFromUrl];
//    [_locService stopUserLocationService];
//    [self initMapView];
}

#pragma mark - 设置引导页
- (void)settingSwpGuidePage{
    __weak typeof(self) selfViewController = self;
    SwpGuidePage *guidPage = [SwpGuidePage swpGuidePage];
    
    guidPage.swpGuidePageControlHidden = YES;
    // 设置 引导页 图片数据源
    guidPage.swpGuidePageImageArray = @[@"guidePage1", @"guidePage2", @"guidePage3"];
    
    // 是否打开 滑动进入app
    guidPage.swpGuidePageOpenSlidingGesture  = YES;
    // 调用方法 判断 是否版本 不同
//    __weak typeof(HomeViewController *) vc = self;
    [guidPage swpGuidePageCheckAppVersionIntoApp:^{
        // 版本相同
//        [SVProgressHUD showWithStatus:self.swpNetwork.swpNetworkGetDagaingTitle maskType:SVProgressHUDMaskTypeBlack];
        if (GetUserDefault(City_ID) == nil) {
            SetUserDefault(@"0", City_ID);
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
//        if (GetUserDefault(City_ID) == nil || [GetUserDefault(City_ID) isEqualToString:@"0"]) {
//            HomeSelectedCityViewController *viewCtroller = [[HomeSelectedCityViewController alloc] init];
//            viewCtroller.delegate = self;
//            [vc.navigationController pushViewController:viewCtroller animated:YES];
//            return;
//        }
//        [vc getLocation];
//        [vc initMapView];
//        [guidPage swpGuidePageShow:self.navigationController animated:YES completion:^{}];
    } intoSwpGuidePage:^{
        // 版本不同 跳转引导页
        [SVProgressHUD dismiss];
//        [vc getLocation];
//        [vc initMapView];
        [guidPage swpGuidePageShow:selfViewController.navigationController animated:YES completion:^{
            
        }];
    }];
    
    [guidPage swpGuidePageClose:^{
//        [SVProgressHUD showWithStatus:self.swpNetwork.swpNetworkGetDagaingTitle maskType:SVProgressHUDMaskTypeBlack];
        if (GetUserDefault(City_ID) == nil) {
            SetUserDefault(@"0", City_ID);
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
//        if (GetUserDefault(City_ID) == nil || [GetUserDefault(City_ID) isEqualToString:@"0"]) {
//            HomeSelectedCityViewController *viewCtroller = [[HomeSelectedCityViewController alloc] init];
//            viewCtroller.delegate = self;
//            [vc.navigationController pushViewController:viewCtroller animated:YES];
//            return;
//        }
//        [vc getLocation];
//        [vc initMapView];
    }];
    
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
    SetUserDefault(@"111", @"back_home_view");
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.fd_interactivePopDisabled = YES;

    
    
    if (self.nameAddress != nil || [self.nameAddress isEqualToString:@""]) {
        [self.titleButton setTitle:[NSString stringWithFormat:@"%@", self.nameAddress] forState:UIControlStateNormal];
    }
    
    if (self.laString.length > 0) {
//        [self getDataFromUrl];
        [self initMapView];
        
    }
    
    
    _locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    if (_locService) {
        [_locService stopUserLocationService];
    }
//    if (self.cityButton) {
//        self.cityButton.hidden = YES;
//    }
    _locService.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    SetUserDefault(@"111", @"back_home_view");
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

#pragma mark - 轮播图的代理方法
- (void)adBannerView:(AdBannerView *)adBannerView itemIndex:(int)index{
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    selectIndexPath = [[NSIndexPath alloc] init];
    listArray = [[NSMutableArray alloc] init];
    arraya = [NSMutableArray array];
    specialArray = [NSMutableArray array];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
//    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
}

/**
 更新
 */
- (void)addUpdateView{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.blackView];
    self.updateView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [window addSubview:self.updateView];
    self.blackView.alpha = 0;
    self.updateView.alpha = 0;
    [self.updateView addSubview:self.updateImageView];
    [self.updateView addSubview:self.cancleButton];
    [self.updateView addSubview:self.updateButton];
    [self.updateView addSubview:self.updateLabel];
    
    [_blackView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_updateView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(140, 40, 100, 40) excludingEdge:ALEdgeBottom];
    [_updateView autoSetDimension:ALDimensionHeight toSize:230];
    
    [_updateImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:35];
    [_updateImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_updateImageView autoSetDimension:ALDimensionHeight toSize:65];
    [_updateImageView autoSetDimension:ALDimensionWidth toSize:100];
    
    [_updateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_updateImageView withOffset:20];
    [_updateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_updateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_updateLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    [_cancleButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [_cancleButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_updateLabel withOffset:20];
    [_cancleButton autoSetDimension:ALDimensionWidth toSize:(SCREEN_WIDTH - 80) /2 - 40];
    [_cancleButton autoSetDimension:ALDimensionHeight toSize:35];
    [_cancleButton setTitle:NSLocalizedString(@"Cancel",  nil) forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _cancleButton.layer.borderWidth = 0.7;
    _cancleButton.layer.borderColor = UIColorFromRGB(0xc9c9c9).CGColor;
    _cancleButton.backgroundColor = [UIColor whiteColor];
    _cancleButton.layer.cornerRadius = 4;
    _cancleButton.layer.masksToBounds = YES;
    
    [_updateButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_updateLabel withOffset:20];
    [_updateButton autoSetDimension:ALDimensionWidth toSize:(SCREEN_WIDTH - 80)/2 - 40];
    [_updateButton autoSetDimension:ALDimensionHeight toSize:35];
    [_updateButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    [_updateButton setTitle:NSLocalizedString(@"homeDownloadTheUpdate", nil) forState:UIControlStateNormal];
    _updateButton.backgroundColor = UIColorFromRGB(0xff5c5c);
    _updateButton.layer.masksToBounds = YES;
    _updateButton.layer.cornerRadius = 4;
}

#pragma mark - 更新的视图懒加载
/**
 *  黑图
 *
 *  @return 返回这个view
 */
- (UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc] initForAutoLayout];
        _blackView.backgroundColor = [UIColor blackColor];
    }
    return _blackView;
}

- (UIView *)updateView{
    if (!_updateView) {
        _updateView = [[UIView alloc] initForAutoLayout];
        _updateView.backgroundColor = [UIColor whiteColor];
        _updateView.layer.cornerRadius = 5;
        _updateView.layer.masksToBounds = YES;
    }
    return _updateView;
}

- (UIImageView *)updateImageView{
    if (!_updateImageView) {
        _updateImageView = [[UIImageView alloc] initForAutoLayout];
        _updateImageView.image = [UIImage imageNamed:@"update_image"];
    }
    return _updateImageView;
}

- (UILabel *)updateLabel{
    if (!_updateLabel) {
        _updateLabel = [[UILabel alloc] initForAutoLayout];
        _updateLabel.textColor = UIColorFromRGB(0xff5c5c);
        _updateLabel.font = [UIFont systemFontOfSize:18];
        _updateLabel.text = NSLocalizedString(@"homeDiscoverTheLatestVersionTitle", nil);
        _updateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _updateLabel;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc] initForAutoLayout];
        [_cancleButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cancleButton;
}

- (UIButton *)updateButton{
    if (!_updateButton) {
        _updateButton = [[UIButton alloc] initForAutoLayout];
        [_updateButton addTarget:self action:@selector(clickUpdateButton) forControlEvents:UIControlEventTouchUpInside];
        _updateButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _updateButton;
}

#pragma mark - 从应用跳转到safari下载应用
- (void)clickUpdateButton{
    NSLog(@"%@",GetUserDefault(@"ios_download"));
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:GetUserDefault(@"ios_download")]];
}

- (void)clickCancelButton{
    [UIView animateWithDuration:0.4 animations:^{
        _blackView.alpha = 0;
        _updateView.alpha = 0;
    }];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    self.titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
    [self.titleButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.titleButton setImage:[UIImage imageNamed:@"location_index"] forState:UIControlStateNormal];
//    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,self.titleButton.titleLabel.bounds.size.width);
    [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
   
    self.navigationItem.titleView = self.titleButton;
    [self.titleButton setTitle:@"定位中...." forState:UIControlStateNormal];

}

- (void)didButton:(UIButton *)btn {
    NSLog(@"导航的按钮");
    ScottMapViewController *scottView = [[ScottMapViewController alloc] init];
//    scottView.laString = latitude;
//    scottView.longString = longtitude;
    [self.navigationController pushViewController:scottView animated:YES];
//    EditMapViewController *viewController = [[EditMapViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    /*========>
            添加首页tableview
    <=======*/
    page = 1;
    [self.view addSubview:self.homeTableView];
    [self addItemButton];
    [self addUpdateView];
}

#pragma mark - 屏蔽多城市

/*
    添加导航栏搜索按钮
 */
- (void)addItemButton{
    //右侧的是搜索按钮
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"search_no"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"search_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //左侧的是扫描条形码按钮
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame     = CGRectMake(0, 0, 34, 34);
    leftBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [leftBtn addTarget:self action:@selector(saoma) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"find_code_no"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"find_code_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [self cityBool];
}

/**
 *  点击选择城市方法
 */
- (void)selecCity{
    
    ScottMapViewController *scottView = [[ScottMapViewController alloc] init];
    scottView.laString = latitude;
    scottView.longString = longtitude;
    [self.navigationController pushViewController:scottView animated:YES];
}

/**
 跳转扫码页面
 */
- (void)saoma{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        NSLog(@"相机权限受限");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未开启相机权限，无法扫描条形码" delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去开启", nil];
        [alert show];
        return;
    }
    FindCodeViewController *viewController = [[FindCodeViewController alloc] init];
    viewController.delegate = self;
    
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

#pragma mark 扫码委托
/**
 获取扫码值 并进行操作
 */
-(void)getFindCodeFVCCodeNum:(NSString *)string{
    SearchResultViewController *viewController = [[SearchResultViewController alloc] init];
    viewController.codeText = string;
    [viewController setNavBarTitle:@"扫一扫" withFont:NAV_TITLE_FONT_SIZE];
//    viewController.searchResultTableView.hidden = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark 搜索按钮
/*
    实现搜索按钮的点击事件
 */
- (void)search{
    NSLog(@"搜索");
    SearchHisViewController *viewController = [[SearchHisViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    [self.homeTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-2, 0, 0, 0)];
}

#pragma mark 获取网络数据
- (void)getDataFromUrl{
//============获取首页轮播、分类、图片那个接口
    NSString *string = [NSString stringWithFormat:@"http://%@/%@", baseUrl, HomeAppKey];
    NSLog(@"%@",string);
    if (city == nil) {
        city = @"0";
    }
    NSDictionary *dic = @{
                          @"app_key" : string,
                          @"city_id" : city
                          };
    
    [SVProgressHUD showWithStatus:@"获取数据中..."];
    [self swpPublicTooGetDataToServer:string parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        cateArray = [[NSMutableArray alloc] init];
        cateArray = [self homeParamArray:[[resultObject objectForKey:@"obj"] objectForKey:@"cate"]];
        
        NSLog(@"%@",cateArray);
        
        specialArray = [[NSMutableArray alloc] init];
        specialArray = [self specialParamArray:[[resultObject objectForKey:@"obj"] objectForKey:@"special"]];
        NSLog(@"%@",specialArray);
        
//        [SVProgressHUD dismiss];
        bannerImgArray = [[NSMutableArray alloc] init];
        
        bannerImgArray = [self bannerParamArray:[resultObject[@"obj"] objectForKey:@"slide_list"]];
        [self.homeTableView reloadData];
        
        //将数据装换成模型================
        
        //============获取首页推荐商家的接口
        if (latitude  == nil) {
            [self.homeTableView reloadData];
            [SVProgressHUD dismiss];
            return;
        }
        
//        if (self.laString.length != 0 || longtitude.length != 0) {
//            latitude = self.laString;
//            longtitude = self.longString;
////            [self getDataFromUrl];
//        }
        
        if (self.laString != nil ) {
            latitude = self.laString;
            longtitude = self.longString;
        }
        
        
        NSString *listUrl = [NSString stringWithFormat:@"http://%@/action/ac_base/re_shop", baseUrl];
        NSDictionary *listDic = @{
                                  @"app_key" : listUrl,
                                  @"page"       : [NSString stringWithFormat:@"%d",page],
                                  @"lat" : latitude,
                                  @"lng" : longtitude,
                                  @"city_id" : city
                                  };
        
        [self swpPublicTooGetDataToServer:listUrl parameters:listDic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            listArray = [self listParamArray:[resultObject objectForKey:@"obj"]];
            NSLog(@"%@",listArray);
            //                    [SVProgressHUD showSuccessWithStatus:param[@"message"]];
            [SVProgressHUD dismiss];
            [self.homeTableView reloadData];
            
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];

        
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {

        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
}

#pragma mark 字典转成模型
//===============数据转换=============//
/**
 转换分类按钮
 */
- (NSMutableArray *) homeParamArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in param) {
        HomeBtnModel *btnModel = [[HomeBtnModel alloc] initWithDict:dict];
        [array addObject:btnModel];
    }
    return array;
}
/**
 转换推荐商家
 */
- (NSMutableArray *) specialParamArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in param) {
        HomeImgModel *imgModel = [[HomeImgModel alloc] initWithDic:dict];
        [array addObject:imgModel];
    }
    return array;
}
/**
 转换商家列表数组
 */
- (NSMutableArray *)listParamArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = listArray;
    }
    for (NSDictionary *dic in param) {
        HomeListModel *listModel = [[HomeListModel alloc] modelWithDic:dic];
        [array addObject:listModel];
    }
    return array;
}
/**
 转换轮播数组
 */
- (NSMutableArray *)bannerParamArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        BannerImgModel *bannerModel = [[BannerImgModel alloc] initWithDic:dic];
        [array addObject:bannerModel];
    }
    return array;
}
//===============数据转换=============//

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
        return 2;
    }
//    else if (section == 1)
//        return 1;
//    else if (section == 2)
//        return 1;
    else{
        if (listArray == nil) {
            [listArray addObject:@""];
        }
        return listArray.count;
    }
}

/**
    设置数据源方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            //分类按钮
            ButtonTableViewCell *cell = [ButtonTableViewCell buttonCellWithHomeTableView:self.homeTableView cellForRowAtIndexpath:indexPath];
            cell.delegate = self;
            cell.cateArray = cateArray;
            __weak typeof(HomeViewController) *homeVC = self;
            [cell clickButton:^(ButtonTableViewCell *cell, NSInteger index ) {
                CateJumpViewController *a = [[CateJumpViewController alloc] init];
                HomeBtnModel *model = [cateArray objectAtIndex:index - 1];
                NearByShopViewController *nearbyViewController = [[NearByShopViewController alloc] init];
                switch ([model.cateID intValue]) {
                    case 1:
                        nearbyViewController.naviTitle = model.cateName;
//                        nearbyViewController.newPage = YES;
//                        nearbyViewController.baidu_lat = self.laString;
//                        nearbyViewController.baidu_lng = self.longString;
                        [homeVC.navigationController pushViewController:nearbyViewController animated:YES];
                        break;
                    case 2:
                        nearbyViewController.naviTitle = model.cateName;
                        nearbyViewController.newPage = YES;
//                        nearbyViewController.baidu_lat = self.laString;
//                        nearbyViewController.baidu_lng = self.longString;
                        
                        [homeVC.navigationController pushViewController:nearbyViewController animated:YES];
                        
                        break;
                    case 3:
                        a.nameTitle = model.cateName;
                        [homeVC.navigationController pushViewController:a animated:YES];
                        break;
                    case 4:
                    {
                        SeleRankViewController *viewController = [[SeleRankViewController alloc] init];
                        [homeVC.navigationController pushViewController:viewController animated:YES];
                    }
                        break;
                    case 5:
                    {
                        if ([GetUserDefault(IsLogin) boolValue]) {
                            PointShopViewController *viewController = [[PointShopViewController alloc] init];
                            [homeVC.navigationController pushViewController:viewController animated:YES];
                        }else{
                            LoginViewController *viewController = [[LoginViewController alloc] init];
                            viewController.identifier = @"";
                            [viewController setBackButton];
                            [homeVC.navigationController pushViewController:viewController animated:YES];
                        }
                    }
                        break;
                    default:
//                        [homeVC pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName];
                        [homeVC pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName addModel:model];
                        break;
                }
            }];
            return cell;
        }
        else{
            //轮播
            BannerTableViewCell *cell = [BannerTableViewCell buttonCellWithHomeTableView:tableView cellForRowAtIndexpath:indexPath];
            cell.bannerImgArray = bannerImgArray;
            cell.delegate = self;
            NSLog(@"%@",bannerImgArray);
            return cell;
        }
    }
//    else if(indexPath.section == 1){
//        //图片
//        HomeImageTableViewCell *cell = [HomeImageTableViewCell cellWithTableView:_homeTableView cellForRowAtIndexpath:indexPath];
//        cell.array = specialArray;
//        cell.layer.borderWidth = 0.6;
//        cell.layer.borderColor = [UIColorFromRGB(0xd9d9d9) CGColor];
//        cell.delegate = self;
//        return cell;
//    }else if (indexPath.section == 2){
//        //第二行图片
//        HomeImageUpTableViewCell *cell = [HomeImageUpTableViewCell cellWithTableView:_homeTableView cellForRowAtIndexpath:indexPath];
//        arraya = [NSMutableArray array];
//        if (specialArray.count > 0) {
//            for (int i = 0 ; i < specialArray.count ;i ++) {
//                if (i > 2) {
//                    HomeImgModel *model = [specialArray objectAtIndex:i];
//                    [arraya addObject:model];
//                }
//            }
//        }
//        cell.array = arraya;
//        cell.delegate = self;
//        cell.layer.borderWidth = 0.5;
//        cell.layer.borderColor = [UIColorFromRGB(0xe1e1e1) CGColor];
//        return cell;
//    }
    else{
        //商家列表
        RecommendTableViewCell *cell = [RecommendTableViewCell cellOfTableView:_homeTableView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@",listArray);
        cell.listModel = listArray[indexPath.row];
        return cell;
    }
}

/*
    编写首页推荐列表的头部控件
 */
-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 37 * Balance_Heith)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * Balance_Width, 8 * Balance_Heith, 200, 20* Balance_Heith)];
        view.backgroundColor = [UIColor whiteColor];
        label.text = @"推荐商家"; NSLocalizedString(@"homeRecommendedBusinessesTitle", nil); //@"推荐商家";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(0x444444);
        
        UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 37 * Balance_Heith, SCREEN_WIDTH, 0.6)];
        xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [view addSubview:xian];
        xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [view addSubview:xian];
        
        [view addSubview:label];
        return view;
    }
    return nil;
}

/*
    section头部空距
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section != 3) {
//        return 2;
//    }
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return 40;
    }
    return 38.0f *Balance_Heith;
}

/*
    section尾部空距
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 4;
    }
    return 2;
}

/*
    cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SCREEN_WIDTH/3;
        }else{
            return 160.0f * Balance_Heith;
        }
    }
//    if (indexPath.section == 1 || indexPath.section == 2) {
//        return 160 * Balance_Heith;
//    }
    return 82.0f * Balance_Heith;
}

/**
 tableview的懒加载
 */
-  (UITableView *)homeTableView {
    
    if (!_homeTableView) {
    
        _homeTableView = [[UITableView alloc] initForAutoLayout];
        _homeTableView.delegate     = self;
        _homeTableView.dataSource = self;
//        [_homeTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingData)];
//        [_homeTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshingData)];
//        _homeTableView.header.updatedTimeHidden = YES;
//        _homeTableView.header.stateHidden = YES;
        [self swpPublicToolSettingTableViewRefreshing:_homeTableView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
    }
    return _homeTableView;
}

#pragma mark 点击首页列表跳转页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndexPath = indexPath;
    if (indexPath.section == 1) {
        HomeListModel *model = listArray[indexPath.row];
        HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
        viewController.imgUrl = model.shopImg;
        viewController.naviTitle = NSLocalizedString(@"homeRecJumpBusinessDetailsNavigationTitle", nil);
        viewController.shopId = model.shopId;
        viewController.shopAddress = model.shopAddress;
        viewController.shopName = model.shopName;
        viewController.distance = model.distance;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
#pragma mark 上拉加载下拉刷新
- (void)headerRefreshingData{
    page = 1;
//    [self getDataFromUrl];
    [self initMapView];
    [self.homeTableView.mj_header endRefreshing];
}

- (void)footerRefreshingData{
    page ++;
//    [self getDataFromUrl];
    [self initMapView];
    [self.homeTableView.mj_footer endRefreshing];
}

#pragma mark 首页的点击事件
/*
   点击分类按钮
 */
- (void) buttonTableViewCell:(ButtonTableViewCell *)buttonTableViewCell didViewIndex:(NSInteger)index {
    NSLog(@"%ld", (long)index);
    CateJumpViewController *a = [[CateJumpViewController alloc] init];
    TeamBuyingViewController *teamBuying = [[TeamBuyingViewController alloc] init];
    HomeBtnModel *model = [cateArray objectAtIndex:index - 1];
    NearByShopViewController *nearbyViewController = [[NearByShopViewController alloc] init];
    switch (index) {
        case 1:
            nearbyViewController.naviTitle = model.cateName;
            [self.navigationController pushViewController:nearbyViewController animated:YES];
            break;
        case 2:
            NSLog(@"%@",model.cateID);
//            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName];
            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName addModel:model];
            break;
        case 3:
            NSLog(@"%@",model.cateID);
//            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName];
            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName addModel:model];
            break;
        case 4:
            NSLog(@"%@",model.cateID);
//            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName];
            [self pushToCateTwoThrFourView:model.cateID andNavigationName:model.cateName addModel:model];
            break;
        case 5:
            
            [self.navigationController pushViewController:teamBuying animated:YES];
            break;
        case 6:
            [self.navigationController pushViewController:a animated:YES];
            break;
        case 7:
        {
            SeleRankViewController *viewController = [[SeleRankViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 8:
        {
            if ([GetUserDefault(IsLogin) boolValue]) {
                PointShopViewController *viewController = [[PointShopViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }else{
                LoginViewController *viewController = [[LoginViewController alloc] init];
                viewController.identifier = @"";
                [viewController setBackButton];
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
            break;
        default:
            break;
    }
    
}

/**
 点击分类的按钮
 点击第一排按钮时候调用此方法
 */
- (void)pushToCateTwoThrFourView:(NSString *)cateId andNavigationName:(NSString *)name addModel:(HomeBtnModel *)model{
//    CateGoodsViewController *viewController = [[CateGoodsViewController alloc] init];
//    viewController.cate_id = cateId;
//    viewController.cate_name = name;
//    [self.navigationController pushViewController:viewController animated:YES];
    
    NearByShopViewController *nearbyViewController = [[NearByShopViewController alloc] init];
//    HomeBtnModel *model = [cateArray objectAtIndex:index - 1];
    nearbyViewController.near = YES;
    nearbyViewController.naviTitle = name;
    nearbyViewController.typeID = cateId;
    nearbyViewController.baidu_lng = self.laString;
    nearbyViewController.baidu_lat = self.longString;
    
    
    [self.navigationController pushViewController:nearbyViewController animated:YES];
}

/*
    点击推荐的图片
 */
- (void)homeImageTableViewCell:(HomeImageTableViewCell *)cell withIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    if (specialArray.count > 0) {
        HomeImgModel *amodel = [specialArray objectAtIndex:index - 1];
        SpecialViewController *viewController = [[SpecialViewController alloc] init];
        viewController.specialId = amodel.imgID;
        viewController.navTitle = amodel.imgName;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/**
 *  点击下面部分的图片
 *
 *  @param cell  点击的cell
 *  @param index cell索引
 */
- (void)homeImageUpTableViewCell:(HomeImageUpTableViewCell *)cell withIndex:(NSInteger)index{
    if (arraya.count > 0) {
        if (index <= arraya.count) {
            HomeImgModel *amodel = [arraya objectAtIndex:index - 1];
            SpecialViewController *viewController = [[SpecialViewController alloc] init];
            viewController.specialId = amodel.imgID;
            viewController.navTitle = amodel.imgName;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

/*
    点击轮播
 */
- (void)bannerTableViewCell:(BannerTableViewCell *)cell cellForRowAtIndex:(int)index{
    NSLog(@"%d",index);
    NSLog(@"%@",bannerImgArray);
    BannerImgModel *model = bannerImgArray[index];
    NSLog(@"%@",model.bannerTurnUrl);
    
    if ([model.shop_id isEqualToString:@"0"] || model.shop_id == 0) {
        OrderDetailViewController *webViewController = [[OrderDetailViewController alloc] init];
        //    if (model.bannerDetialUrl != nil && ![model.bannerDetialUrl isEqualToString:@""]) {
        //        webViewController.webUrl = model.bannerDetialUrl;
        //    }else{
        //        webViewController.webUrl = model.bannerTurnUrl;
        //    }
        webViewController.webUrl = model.bannerTurnUrl;
        webViewController.webTitle = @"详情";
        [self.navigationController pushViewController:webViewController animated:YES];
    }else{
        HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
        viewController.imgUrl = model.shop_img;
        viewController.naviTitle = NSLocalizedString(@"homeRecJumpBusinessDetailsNavigationTitle", nil);
        viewController.distance = model.long_me;
        viewController.shopId = model.shop_id;
        viewController.shopAddress = model.shop_address;
        viewController.shopName = model.shop_name;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    
}


#pragma mark - 选择城市的委托
- (void)choseTheCity:(NSString*)cityName{

}

- (void)choseTheCityModule:(CityModule*)module{
    NSLog(@"%@",module);
    [SVProgressHUD showWithStatus:@"获取数据中"];
    [self.homeTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self initData];
//    [self getLocation];
    [self initMapView];
}

- (void)homeSelectedCityViewController:(HomeSelectedCityViewController *)homeSelectedCityViewController currentCityName:(NSString *)cityName currentCityID:(NSString *)ciytID{
    NSLog(@"%@   %@",cityName,ciytID);
    [SVProgressHUD showWithStatus:@"获取数据中"];
    [self.homeTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self initData];
//    [self getLocation];
    [self initMapView];
}


//#pragma mark------定位功能
//-(void)openLocation {
//    [self.titleButton setTitle:@"定位中..." forState:UIControlStateNormal];
//    self.m_sqlite = [[CSqlite alloc]init];
//    [self.m_sqlite openSqlite];
//    if([CLLocationManager locationServicesEnabled]) {
//        self.locationManager = [[CLLocationManager alloc] init];
//        self.locationManager.delegate        = self;
//        self.locationManager.distanceFilter  = 0.5;
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        [self.locationManager startUpdatingLocation]; // 开始定位
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//            [self.locationManager requestAlwaysAuthorization];
//        }
//    }
//}
//
//
//#define x_pi (3.14159265358979324 * 3000.0 / 180.0)
//#pragma mark------转换坐标
//-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
//{
//    int TenLat=0;
//    int TenLog=0;
//    TenLat = (int)(yGps.latitude*10);
//    TenLog = (int)(yGps.longitude*10);
//    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
//    NSLog(@"slq = %@", sql);
//    sqlite3_stmt* stmtL = [self.m_sqlite NSRunSql:sql];
//    int offLat=0;
//    int offLog=0;
//    while (sqlite3_step(stmtL)==SQLITE_ROW)
//    {
//        offLat = sqlite3_column_int(stmtL, 0);
//        offLog = sqlite3_column_int(stmtL, 1);
//    }
//    yGps.latitude = yGps.latitude + offLat*0.0001;
//    yGps.longitude = yGps.longitude + offLog*0.0001;
//    return yGps;
//}
//
//#pragma mark------定位delegate
//// 定位成功时调用
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"定位成功");
//    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
//    NSString *u_lat = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
//    NSString *u_lng = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
//    NSLog(@"未经过转换的经纬度是%@---%@",u_lat,u_lng);
//    mylocation = [self zzTransGPS:mylocation];
//    self.baidu_lat = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
//    self.baidu_lng = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
//    double lat     = [self.baidu_lat floatValue];
//    double lng     = [self.baidu_lng floatValue];
//    double baiDuLat , baiDuLng;
//    double x = lng, y = lat;
//    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
//    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
//    baiDuLng = z * cos(theta) + 0.0065;
//    baiDuLat = z * sin(theta) + 0.006;
//    self.baidu_lat = [NSString stringWithFormat:@"%f",baiDuLat];
//    self.baidu_lng = [NSString stringWithFormat:@"%f",baiDuLng];
//    [self.locationManager stopUpdatingLocation]; // 关闭定位
//    
//    NSLog(@"%@", self.baidu_lat);
//    NSLog(@"%@", self.baidu_lng);
//    
//    self.baidu_lng = self.baidu_lng == nil ? @"0" : self.baidu_lng;
//    self.baidu_lat = self.baidu_lat == nil ? @"0" : self.baidu_lat;
//    
//    SetUserDefault(self.baidu_lat, @"baidu_lat");
//    SetUserDefault(self.baidu_lng, @"baidu_lng");
//    
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.latitude longitude:mylocation.longitude];
//    ///获取位置信息
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks,NSError *error)
//     {
//         //         if (placemarks.count >0   )
//         //         {
//         CLPlacemark * plmark = [placemarks objectAtIndex:0];
//         
//         NSString * country     = plmark.country;
//         NSString * cityName    = plmark.locality;
//         //将城市地址 显示并获取城市id
//         //             [leftButton setTitle:[NSString stringWithFormat:@"%@﹀",cityName] forState:UIControlStateNormal];
//         //             [self getCity:cityName];
//         cityName               = cityName == nil ? @"定位失败" : cityName;
//         //             self.currentCityName   = cityName;
//         //             [self leftButtonSetTitle:cityName];
//         //             [self getCityIdData:cityName];
////         [self getLocationIdFromUrl];
//         
//         NSLog(@"%@-%@-%@",country,cityName,plmark.name);
//
//         [self.titleButton setTitle:[NSString stringWithFormat:@"%@", plmark.thoroughfare] forState:UIControlStateNormal];
//         //         }
//         NSLog(@"%@",[NSString stringWithFormat:@"%@%@", plmark.thoroughfare, plmark.subThoroughfare]);
//         NSLog(@"%@",[NSString stringWithFormat:@"%@", plmark.subThoroughfare]);
//     }];
//    
//    
//    //    [self getHomeImageData];
//    //    [self getDataFromUrl];
//}




- (void)initMapView{
    
    
    //选择地图模式
    //    _mapView.userTrackingMode = 1;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [_mapView setZoomLevel:16.1 animated:YES];
    // 带逆地理（返回坐标和地址信息）
    [self.locationManager2 requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        _currentLocation = [location copy];
        
        latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        longtitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            currentPosition = [NSString stringWithFormat:@"%@%@%@",regeocode.district, regeocode.street, regeocode.number];
            city = [NSString stringWithFormat:@"%@", regeocode.city];
            
            if (self.laString.length > 0) {
                
            }else{
                [self.titleButton setTitle:[NSString stringWithFormat:@"%@", currentPosition] forState:UIControlStateNormal];
            }
            
        }
        
        
        if (regeocode == nil) {
//            [SVProgressHUD showErrorWithStatus:@"网络不给力"];
            return;
        }

        [self getDataFromUrl];

        
    }];
    
}


// 定位失败时调用
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"nearByShopLocationErrorTitle", nil)];
    [self setNavBarTitle:NSLocalizedString(@"nearByShopLocationErrorTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    //    [self getHomeImageData];
}


@end
