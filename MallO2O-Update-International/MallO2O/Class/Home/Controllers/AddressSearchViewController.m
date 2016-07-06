//
//  AddressSearchViewController.m
//  MallO2O
//
//  Created by apple on 16/5/22.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "AddressSearchViewController.h"
#import "HomeViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchkit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>



@interface AddressSearchViewController ()<UISearchBarDelegate,MAMapViewDelegate,AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, AMapLocationManagerDelegate>{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
}


/**  单次定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager;

/** 定位结果 */
@property (nonatomic, strong) UITableView *addressSearchTableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation AddressSearchViewController

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
    
    self.dataArray = [NSMutableArray array];
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
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        _currentLocation = [location copy];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
//            currentPosition = [NSString stringWithFormat:@"%@%@%@",regeocode.district, regeocode.street, regeocode.number];
//            [cpArray addObject:currentPosition];
            [self initSearch:self.type];
        }
        
//        [self.scottTableView reloadData];
        
    }];

}


- (void)initSearch:(NSString *)string1{
    [AMapSearchServices sharedServices].apiKey = APIKey;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        request.keywords = string1;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    //    request.types = @"生活服务";
    request.sortrule = 0;
    request.offset = 30;
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
        [self.addressSearchTableView reloadData];
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
    [self setNavBarTitle:@"搜索结果" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    
    [self.view addSubview:self.addressSearchTableView];

}



/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.addressSearchTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.addressSearchTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.addressSearchTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.addressSearchTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
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
    
    static NSString *addCellID = @"addCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:addCellID];
    }
    AMapPOI *poi = self.dataArray[indexPath.row];
    
    cell.textLabel.text = poi.name;
    [UZCommonMethod settingTableViewAllCellWire:self.addressSearchTableView andTableViewCell:cell];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *poi = self.dataArray[indexPath.row];
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



#pragma mark - 懒加载
- (UITableView *)addressSearchTableView{
    if (!_addressSearchTableView) {
        _addressSearchTableView = [[UITableView alloc] initForAutoLayout];
        _addressSearchTableView.delegate = self;
        _addressSearchTableView.dataSource = self;
//        [hiddleExtendCellFromTableview:(UITableView *)tableview
        [UZCommonMethod hiddleExtendCellFromTableview:_addressSearchTableView];
    }
    return _addressSearchTableView;
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
