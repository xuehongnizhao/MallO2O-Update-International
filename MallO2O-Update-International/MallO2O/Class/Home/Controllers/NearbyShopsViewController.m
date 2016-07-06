//
//  NearbyShopsViewController.m
//  MallO2O
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "NearbyShopsViewController.h"
#import "HomeViewController.h"

#import "HTHorizontalSelectionList.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>



@interface NearbyShopsViewController ()<MAMapViewDelegate,AMapSearchDelegate,HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate, AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    NSString *laString;
    NSString *longSting;
    
    CLLocationCoordinate2D centerLocation;
}

/** 菜单栏 */
@property (nonatomic, strong)HTHorizontalSelectionList *selectionList;
/** 菜单数组 */
@property (nonatomic, strong) NSArray *carMakes;
/**  单次定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager;
/** 定位数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** tableView */
@property (nonatomic, strong) UITableView *moreTableView;

/** <#描述属性#> */
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;


@end

@implementation NearbyShopsViewController

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
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT /2 - 30)];
    _mapView.delegate = self;
    
    //选择地图模式
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [_mapView setZoomLevel:16.1 animated:YES];
    
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    self.locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager.reGeocodeTimeout = 3;
//    [self initMapView];
    [self singleLocation];
    
    
    self.pointAnnotation = [[MAPointAnnotation alloc] init];
    
    
    
    self.dataArray = [NSMutableArray array];
    //菜单栏数据
    self.carMakes = @[@"全部",
                      @"写字楼",
                      @"小区",
                      @"学校",//🏁这里设置为4个文字 显示就会出问题。
                      ];
//    _search = [[AMapSearchAPI alloc] init];
//    _search.delegate = self;
//    AMapNearbySearchRequest *AMap = [[AMapNearbySearchRequest alloc] init];
//    //    AMap.center = laString;
//    [_search AMapNearbySearch:AMap];
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
    [self setNavBarTitle:@"更多地址" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:_mapView];
    [self.view addSubview:self.selectionList];
    [self.view addSubview:self.moreTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.selectionList autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.selectionList autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.selectionList autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SCREEN_HEIGHT /2 - 94];
    [self.selectionList autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.moreTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.selectionList withOffset:5];
    [self.moreTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.moreTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.moreTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
}


//- (void)initMapView{
//    
//    if (laString.length == 0 || [laString isEqualToString:@""]) {
//        //配置用户Key
//        [MAMapServices sharedServices].apiKey = APIKey;
//        
//        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT /2 - 30)];
//        _mapView.delegate = self;
//        
//        //选择地图模式
//        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
//        [_mapView setZoomLevel:16.1 animated:YES];
//        
//        self.locationManager = [[AMapLocationManager alloc] init];
//        self.locationManager.delegate = self;
//        [self.locationManager startUpdatingLocation];
//    }else{
//        
//    }
//    
//    
//}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    if (location != nil) {
        
        laString = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        longSting = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        [self initSearch:nil];
    }else{
        return;
    }
    [self.locationManager stopUpdatingLocation];
}





- (void)initSearch:(NSString *)keyword{
    [AMapSearchServices sharedServices].apiKey = APIKey;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
//    request.location = [AMapGeoPoint locationWithLatitude:[laString floatValue] longitude:[longSting floatValue]];
        request.location = [AMapGeoPoint locationWithLatitude:centerLocation.latitude longitude:centerLocation.longitude];
    
        request.keywords = keyword;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    //    request.types = @"生活服务";
    request.sortrule = 0;
    request.offset = 15;
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
        self.dataArray = [NSMutableArray arrayWithArray:response.pois];
        [self.moreTableView reloadData];
        
    }
//    [self.locationManager stopUpdatingLocation];
    
}


/**
 *  移动地图定位
 *
 *  @param mapView
 *  @param wasUserAction
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    centerLocation = mapView.centerCoordinate;

    self.pointAnnotation.coordinate = centerLocation;
    
    [_mapView addAnnotation:self.pointAnnotation];
    [self initSearch:nil];
}

/**
 *  设置大头针
 *
 *  @param mapView
 *  @param annotation
 *
 *  @return
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    
    return nil;
}


/**
 *  单次定位
 */
- (void)singleLocation{
    
    //配置用户Key
    [MAMapServices sharedServices].apiKey = APIKey;
    
    // 带逆地理（返回坐标和地址信息）
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        laString = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        longSting = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            [self initSearch:nil];
        }
    }];
}





#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods
/**
 *  菜单栏数据源方法:控制分栏个数
 *
 *  @param selectionList 菜单栏对象
 *
 *  @return 分栏个数
 */
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList{
    
    
    return self.carMakes.count;
}

/**
 *  菜单栏数据源方法:控制分栏内容
 *
 *  @param selectionList 菜单栏对象
 *  @param index         第几个菜单按钮（0，1，2...）
 *
 *  @return 按钮显示文字
 */
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.carMakes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods
/**
 *  当菜单栏（textSelectionList）被点击时调用
 */
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    
    switch (index) {
        case 0:
            NSLog(@"1");
            [self initSearch:@"全部"];
            break;
        case 1:
            NSLog(@"2");
          [self initSearch:@"写字楼"];
            break;
            
        case 2:
            NSLog(@"3");
         [self initSearch:@"小区"];
            break;
            case 3:
            [self initSearch:@"学校"];
            break;
            
        default:
            break;
    }
}


#pragma mark 首页tableview代理方法和数据源方法

/*
 设置tableview的组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/*
 设置tableview每组的cell数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    AMapPOI *poi = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"address_firstadrs"];
        cell.textLabel.text = @"当前位置";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",poi.district, poi.address];
        
    }else{
        cell.imageView.image = [UIImage imageNamed:@"address_mark"];
        cell.textLabel.text = poi.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", poi.district, poi.address];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [UZCommonMethod settingTableViewAllCellWire:self.moreTableView andTableViewCell:cell];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *VCArray = self.navigationController.viewControllers;
    AMapPOI *poi = self.dataArray[indexPath.row];
    for (MallO2OBaseViewController *addreViewController in VCArray) {
        if ([addreViewController isKindOfClass:[HomeViewController class]]) {
            
            HomeViewController *addVC = (HomeViewController *)addreViewController;
            //            addVC.name = str;
            addVC.laString = [NSString stringWithFormat:@"%f", poi.location.latitude];
            addVC.longString = [NSString stringWithFormat:@"%f", poi.location.longitude];
            addVC.nameAddress = poi.name;
            [self.navigationController popToViewController:addVC animated:YES];
        }
    }
}




/**
 *  菜单View
 *
 *  @return _textSelectionList
 */
- (HTHorizontalSelectionList *) selectionList
{
    if (!_selectionList) {
//        _selectionList  = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT /2 - 94, self.view.frame.size.width, 40)];
        _selectionList = [[HTHorizontalSelectionList alloc] initForAutoLayout];
        _selectionList.delegate = self;
        _selectionList.dataSource = self;
        
        _selectionList.bottomTrimHidden    =   YES;
        _selectionList.selectionIndicatorStyle  =   HTHorizontalSelectionIndicatorStyleBottomBar;
        _selectionList.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeLightBounce;
        _selectionList.showsEdgeFadeEffect = YES;
        _selectionList.centerAlignButtons   = YES;//列表中的按钮的数量水平不填补空间。
        
        _selectionList.selectionIndicatorColor = [UIColor redColor];
        [_selectionList setTitleColor:UIColorFromRGB(0x858585) forState:UIControlStateHighlighted];
        [_selectionList setTitleFont:[UIFont systemFontOfSize:12] forState:UIControlStateNormal];
        [_selectionList setTitleFont:[UIFont boldSystemFontOfSize:12] forState:UIControlStateSelected];
        [_selectionList setTitleFont:[UIFont boldSystemFontOfSize:12] forState:UIControlStateHighlighted];
        
        _selectionList.snapToCenter = YES;
        
    }
    return _selectionList;
}


- (UITableView *)moreTableView{
    if (!_moreTableView) {
        _moreTableView = [[UITableView alloc] initForAutoLayout];
        _moreTableView.delegate = self;
        _moreTableView.dataSource = self;
    }
    return _moreTableView;
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
