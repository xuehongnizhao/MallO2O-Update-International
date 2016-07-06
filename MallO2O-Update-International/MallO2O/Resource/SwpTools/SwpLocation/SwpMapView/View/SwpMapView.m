//
//  SwpMapView.m
//  Swp_song
//
//  Created by songweiping on 15/8/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song
//
//  @modification Time  --->    2015-12-08 15:46:01
//
//  @since              --->    1.0.7

#import "SwpMapView.h"

/*! ---------------------- Tool       ---------------------- !*/
#import "CSqlite.h"                     // sqlite 坐标转换
/*! ---------------------- Tool       ---------------------- !*/



@interface SwpMapView () <MKMapViewDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 定位信息管理者            */
@property (nonatomic, strong) CLLocationManager     *swpLocationManager;
/*! 显示的 mapView            */
@property (nonatomic, strong) MKMapView             *mapView;
/*! sqlite 坐标转换           */
@property (nonatomic, strong) CSqlite               *sqlite;
/*! 地理编码对象              */
@property (nonatomic, strong) CLGeocoder            *swpGeocoder;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 苹果定位原始坐标 纬度     */
@property (nonatomic, assign) double latitude;
/*! 苹果定位原始坐标 经度度   */
@property (nonatomic, assign) double longitude;
/*! 火星坐标 纬度             */
@property (nonatomic, assign) double marsLatitude;
/*! 火星坐标 经度             */
@property (nonatomic, assign) double marsLongitude;
/*! 百度坐标 纬度             */
@property (nonatomic, assign) double baiduLatitude;
/*! 百度坐标 经度             */
@property (nonatomic, assign) double baiduLongitude;
/*!
 *  设置 swpMapView 用户定位之后 默认 经纬度跨度
 *  跨度越小 地图缩放越大 
 */
@property (nonatomic, assign) MKCoordinateSpan  span;
/*! 是否 更新用户地图显示的位置 */
@property (nonatomic, assign, getter=isLocationUpdate) BOOL locationUpdate;
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpMapView


/*!
 *  @author swp_song, 2015-12-08 11:43:01
 *
 *  @brief  Override InitWithFrame
 *
 *  @param  frame
 *
 *  @return SwpMapView
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initData];
        
        [self addUI];
    }
    return self;
}


/*!
 *  @author swp_song, 2015-12-08 11:45:19
 *
 *  @brief  Override layoutSubviews (设置 控件 的位置 )
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.mapView.frame = self.bounds;
}

/*!
 *  @author swp_song, 2015-12-08 11:45:48
 *
 *  @brief AddUI (添加 UI 控件)
 */
- (void) addUI {
    [self addSubview:self.mapView];
}


/*!
 *  @author swp_song, 2015-12-08 11:50:42
 *
 *  @brief  InitData (初始化数据)
 */
- (void) initData {
    self.span           = MKCoordinateSpanMake(5, 5);
    self.locationUpdate = YES;
    [self swpMapViewOpenLocation];
}

/*!
 *  @author swp_song, 2015-12-08 11:51:53
 *
 *  @brief  swpMapViewOpenLocation (打开定位)
 */
- (void) swpMapViewOpenLocation {
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 请求 前台 定位权限
        [self.swpLocationManager requestAlwaysAuthorization];
        // 请求 后台 定位权限
        [self.swpLocationManager requestWhenInUseAuthorization];
    }
    
    [self.swpLocationManager startUpdatingLocation];
}

/*!
 *  @author swp_song, 2015-12-08 11:53:03
 *
 *  @brief  swpMapViewStopLocation (关闭定位)
 */
- (void) swpMapViewStopLocation {
    
}



#pragma mark - swpMapView Set Property Methods

/*!
 *  @author swp_song, 2015-12-08 11:53:54
 *
 *  @brief  setSwpMapViewType (设置 swpMapViewType )
 *
 *  @param  swpMapViewType
 *
 *  @since  1.0.7
 */
- (void)setSwpMapViewType:(MKMapType)swpMapViewType {
    
    _swpMapViewType      = swpMapViewType;
    self.mapView.mapType = _swpMapViewType;
}

/*!
 *  @author swp_song, 2015-12-8 11:12:27
 *
 *  @brief  setSwpUserTrackingMode (设置 swpMapView 用户定位的大头针 是否跟随自己)
 *
 *  @param  swpUserTrackingMode
 *
 *  @since  1.0.7
 */
- (void)setSwpUserTrackingMode:(MKUserTrackingMode)swpUserTrackingMode {

    _swpUserTrackingMode          = swpUserTrackingMode;
    self.mapView.userTrackingMode = _swpUserTrackingMode;
}


/*!
 *  @author swp_song, 2015-12-08 11:58:05
 *
 *  @brief  setSwpSpan (设置 swpMapView 用户定位之后 经纬度跨度, 跨度越小 地图缩放越大)
 *
 *  @param  swpSpan
 *
 *  @since  1.0.7
 */
- (void)setSwpSpan:(MKCoordinateSpan)swpSpan {
    _swpSpan   = swpSpan;
    self.span  = _swpSpan;
}

/*!
 *  @author swp_song, 2015-12-08 12:00:59
 *
 *  @brief  swpMapViewAddSubview (subview 需要添加的控件)
 *
 *  @param  subview
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddSubview:(UIView *)subview {
    [self.mapView addSubview:subview];
}

/*!
 *  @author swp_song, 2015-12-08 13:19:04
 *
 *  @brief  swpMapViewAddAnnotation (swpMapView 上添一个加大头针)
 *
 *  @param  annotation
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddAnnotation:(id <MKAnnotation>)annotation {
    [self.mapView addAnnotation:annotation];
}

/*!
 *  @author swp_song, 2015-12-08 13:20:32
 *
 *  @brief  swpMapViewAddAnnotations (swpMapView 添加多个大头针 大头针个数 取决于 数组的长度)
 *
 *  @param  annotations
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddAnnotations:(NSArray *)annotations {
    [self.mapView addAnnotations:annotations];
}

/*!
 *  @author swp_song, 2015-12-08 13:24:20
 *
 *  @brief  swpMapViewRemoveAnnotation  ( 删除 swpMapView 上的 单个大头针 )
 *
 *  @param  annotation
 *
 *  @since  1.0.7
 */
- (void) swpMapViewRemoveAnnotation:(id <MKAnnotation>)annotation {
    [self.mapView removeAnnotation:annotation];
}

/*!
 *  @author swp_song, 2015-12-08 13:36:59
 *
 *  @brief  swpMapViewRemoveAnnotations (删除 swpMapView  上的多个大头针, 删除个数 取决于 数组的长度)
 *
 *  @param  annotations
 *
 *  @since  1.0.7
 */
- (void) swpMapViewRemoveAnnotations:(NSArray *)annotations {
    [self.mapView removeAnnotations:annotations];
}


/*!
 *  @author swp_song, 2015-12-08 13:38:42
 *
 *  @brief  swpMapViewStartLocationUpdate( 开启 实时更新 定位信息 )
 *
 *  @since  1.0.7
 */
- (void) swpMapViewStartLocationUpdate {
    self.locationUpdate = YES;
}

/*!
 *  @author swp_song, 2015-12-08 13:39:38
 *
 *  @brief  swpMapViewStopLocationUpdate ( 关闭 实时更新 定位信息 )
 *
 *  @since  1.0.7
 */
- (void) swpMapViewStopLocationUpdate {
    self.locationUpdate = NO;
}

/*!
 *  @author swp_song, 2015-12-8 13:12:53
 *
 *  @brief  swpMapViewGetLocationStatus (获取 定位 是否 开启的状态)
 *
 *  @return BOOL ( YES 开启 NO 关闭 )
 *
 *  @since  1.0.7
 */
- (BOOL) swpMapViewGetLocationStatus {
    return self.locationUpdate;
}



#pragma mark - MKMapView Delegate & SwpMapView Delegate - Methods
/*!
 *  @author swp_song, 2015-12-08 13:46:02
 *
 *  @brief  mapView Deleage ( mapView 代理方法 每次更新用户的位置就会调用, 调用不频繁，只有位置发生变化才会调用)
 *
 *  @param  mapView
 *
 *  @param  userLocation
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    // 反地理编码 获取 定位信息
    [self swpGeocodeCoordGetAddress:userLocation.location dataDispose:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark              = [placemarks firstObject];
        self.mapView.userLocation.subtitle  = placemark.name;
        self.mapView.userLocation.title     = placemark.locality;
        
        if (self.isLocationUpdate) {
            // 获取用户的位置
            CLLocationCoordinate2D userCenter = userLocation.coordinate;
            // 将用户当前位置 作为 显示区域的中心点 self.span 是 指定经纬度 的跨度
            MKCoordinateRegion     region     = MKCoordinateRegionMake(userCenter, self.span);
            // 设置显示区域
            [mapView setRegion:region animated:YES];
        }
        
        // swpMapView 代理方法(用户位置更新 时 调用)
        if ([self.delegate respondsToSelector:@selector(swpMapView:showMapView:didUpdateUserLocation:locationMessage:)]) {
            SwpLocationModel *swpLocation = [self settingUserLocationMessageData:userLocation placemarks:placemarks locationError:error];
            [self.delegate swpMapView:self showMapView:mapView didUpdateUserLocation:userLocation locationMessage:swpLocation];
        }
    }];
    
}

/*!
 *  @author swp_song, 2015-12-08 13:52:39
 *
 *  @brief  mapView Delegate ( mapView 代理方法 每次添加大头针就会调用, 地图上有几个大头针就会调用几次)
 *
 *  @param  mapView
 *
 *  @param  annotation
 *
 *  @return MKAnnotationView
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([self.delegate respondsToSelector:@selector(swpMapView:showPinMapView:viewForAnnotation:)]) {
        return [self.delegate swpMapView:self showPinMapView:mapView viewForAnnotation:annotation];
    } else {
        return nil;
    }

}

/*!
 *  @author swp_song, 2015-12-08 13:56:11
 *
 *  @brief  mapView Delegate ( mapView 代理方法 选中大头针 时 调用)
 *
 *  @param  mapView
 *
 *  @param  view
 */
- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([self.delegate respondsToSelector:@selector(swpMapView:showPinMapView:didSelectAnnotationView:)]) {
        [self.delegate swpMapView:self showPinMapView:mapView didSelectAnnotationView:view];
    }
}

/*!
 *  @author swp_song, 2015-12-08 13:59:43
 *
 *  @brief  mapView Delegate ( mapView 代理方法 取消选中 或者 选中其他的大头针 时 调用)
 *
 *  @param  mapView
 *
 *  @param  view
 */
- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([self.delegate respondsToSelector:@selector(swpMapView:showPinMapView:didDeselectAnnotationView:)]) {
        [self.delegate swpMapView:self showPinMapView:mapView didDeselectAnnotationView:view];
    }
}


/*!
 *  @author swp_song, 2015-12-08 14:03:44
 *
 *  @brief  didMapView (swpMapView 点击事件 )
 *
 *  @param  tap
 */
- (void) didMapView:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(swpMapView:didMapView:didGetLocation:)]) {
        CLLocation *location = [self didViewGetGetCoordinate:tap];
        [self.delegate swpMapView:self didMapView:self.mapView didGetLocation:location];
    }
}


#pragma mark - Get Location Message Methods

/*!
 *  @author swp_song, 2015-12-08 14:13:02
 *
 *  @brief  swpGeocodeAddressGetCoord (根据 名称 获取坐标 地理编码)
 *
 *  @param  name
 *
 *  @param dataDispose
 *
 *
 *  @since  1.0.7
 */
- (void) swpGeocodeAddressGetCoord:(NSString *)name dataDispose:(void (^)(void))dataDispose {
    
    [self.swpGeocoder geocodeAddressString:name completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemarlk = [placemarks firstObject];
        NSLog(@"%@, %@, %f, %f", placemarlk.name, placemarlk.addressDictionary, placemarlk.location.coordinate.longitude, placemarlk.location.coordinate.latitude);
    }];
}


/*!
 *  @author swp_song, 2015-12-08 14:14:49
 *
 *  @brief  swpGeocodeCoordGetAddress (根据 名称 获取坐标 反地理编码)
 *
 *  @param  location        location
 *
 *  @param  dataDispose     dataDispose
 *
 *  @since  1.0.7
 */
- (void) swpGeocodeCoordGetAddress:(CLLocation *)location dataDispose:(void(^)(NSArray *placemarks, NSError *error))dataDispose  {
    
    __weak typeof(self) selfVC = self;
    [selfVC.swpGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        dataDispose(placemarks, error);
    }];
}


/*!
 *  @author swp_song, 2015-12-08 14:22:05
 *
 *  @brief  swpSwpMapViewGetLocationMessage ( 根据坐标 获取 对应的 定位信息 )
 *
 *  @param  location            location
 *
 *  @param  locationMessage     getLocationMessage
 *
 *  @since  1.0.7
 */
- (void) swpSwpMapViewGetLocationMessage:(CLLocation *)location locationMessage:(void(^)(NSArray *placemarks, NSError *error, SwpLocationModel *swpMessage))locationMessage {

    __weak typeof(self) selfVC = self;
    // 获取 数据 定位 数据
    [selfVC swpGeocodeCoordGetAddress:location dataDispose:^(NSArray *placemarks, NSError *error) {
        // 点击 坐标
        selfVC.marsLatitude   = location.coordinate.latitude;
        selfVC.marsLongitude  = location.coordinate.longitude;
        // 转换成 百度坐标
        NSDictionary *dict    = [selfVC coordEncrypt:selfVC.marsLatitude longitude:selfVC.marsLongitude];
        selfVC.baiduLatitude  = [dict[@"latitude"]    doubleValue];
        selfVC.baiduLongitude = [dict[@"longitude"]   doubleValue];
        
        SwpLocationModel *swpLocation = [selfVC settingSwpLocationMessageData:placemarks locationError:error];
        locationMessage(placemarks, error, swpLocation);
        
    }];

    
}


#pragma mark - Common Methods

/*!
 *  @author swp_song, 2015-12-08 15:05:46
 *
 *  @brief  settingTapGestureRecognizer ( view 绑定一个点击事件 )
 *
 *  @param  view        settingView
 *
 *  @param  count       didCount
 *
 *  @param  target      target
 *
 *  @param  action      action
 *
 *  @param  cancels     cancels
 *
 *  @return UITapGestureRecognizer
 *
 *  @since  1.0.7
 */
- (UITapGestureRecognizer *) settingTapGestureRecognizer:(UIView *)view clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired    = count;
    tap.cancelsTouchesInView    = cancels;
    [tap addTarget:target action:action];
    [view addGestureRecognizer:tap];
    return tap;
}


/*!
 *  @author swp_song, 2015-12-08 15:09:14
 *
 *  @brief  didViewGetGetCoordinate (点击 地图上某个位置 转换成 坐标)
 *
 *  @param  tap
 *
 *  @return CLLocation
 *
 *  @since  1.0.7
 */
- (CLLocation *) didViewGetGetCoordinate:(UITapGestureRecognizer *)tap {
    
    CGPoint                didPoint  = [tap locationInView:self.mapView];
    CLLocationCoordinate2D didCoord  = [self.mapView convertPoint:didPoint toCoordinateFromView:self.mapView];
    CLLocation             *location = [[CLLocation alloc] initWithLatitude:didCoord.latitude longitude:didCoord.longitude];
    return location;
}

/*!
 *  @author swp_song, 2015-12-08 15:12:46
 *
 *  @brief  settingUserLocationMessageData (用户 定位信息 数据 封装)
 *
 *  @param  userLocation
 *
 *  @param  placemarks
 *
 *  @param  error
 *
 *  @return SwpLocationModel
 *
 *  @since  1.0.7
 */
- (SwpLocationModel *)settingUserLocationMessageData:(MKUserLocation *)userLocation  placemarks:(NSArray *)placemarks locationError:(NSError *)error {
    
    CLPlacemark *placemark              = [placemarks firstObject];
    SwpLocationModel *swpLocation       = [[SwpLocationModel alloc] init];
    swpLocation.marsLatitude            = userLocation.coordinate.latitude;
    swpLocation.marsLongitude           = userLocation.coordinate.longitude;
    
    // 转换成 百度坐标
    NSDictionary *dict         = [self coordEncrypt:swpLocation.marsLatitude longitude:swpLocation.marsLongitude];
    swpLocation.baiduLatitude  = [dict[@"latitude"]    doubleValue];
    swpLocation.baiduLongitude = [dict[@"longitude"]   doubleValue];
    
    swpLocation.placemarks            = placemarks;
    swpLocation.placemark             = placemark;
    swpLocation.error                 = error;
    swpLocation.name                  = placemark.name;
    swpLocation.country               = placemark.country;
    swpLocation.administrativeArea    = placemark.administrativeArea;
    swpLocation.locality              = placemark.locality;
    swpLocation.subLocality           = placemark.subLocality;
    swpLocation.thoroughfare          = placemark.thoroughfare;
    swpLocation.subThoroughfare       = placemark.subThoroughfare;
    
    return swpLocation;
}


/*!
 *  @author swp_song, 2015-12-8 15:12:53
 *
 *  @brief  settingSwpLocationMessageData (设置 自定义定位的数据模型)
 *
 *  @param  placemarks
 *
 *  @param  error
 *
 *  @return SwpLocationModel
 *
 *  @since  1.0.7
 */
- (SwpLocationModel *)settingSwpLocationMessageData:(NSArray *)placemarks locationError:(NSError *)error  {
    
    SwpLocationModel *swpLocation     = [[SwpLocationModel alloc] init];
    CLPlacemark      *placemark       = [placemarks firstObject];
    
    swpLocation.longitude             = self.longitude;
    swpLocation.latitude              = self.latitude;
    swpLocation.marsLatitude          = self.marsLatitude;
    swpLocation.marsLongitude         = self.marsLongitude;
    swpLocation.baiduLatitude         = self.baiduLatitude;
    swpLocation.baiduLongitude        = self.baiduLongitude;
    
    swpLocation.placemarks            = placemarks;
    swpLocation.placemark             = placemark;
    swpLocation.error                 = error;
    swpLocation.name                  = placemark.name;
    swpLocation.country               = placemark.country;
    swpLocation.administrativeArea    = placemark.administrativeArea;
    swpLocation.locality              = placemark.locality;
    swpLocation.subLocality           = placemark.subLocality;
    swpLocation.thoroughfare          = placemark.thoroughfare;
    swpLocation.subThoroughfare       = placemark.subThoroughfare;
    
    return swpLocation;
}

#pragma mark - Public Tools Methods
/*!
 *  @author swp_song, 2015-12-08 15:16:46
 *
 *  @brief  coordEncrypt    ( 高德 定位 坐标 转换成 百度 坐标 )
 *
 *  @param  latitude
 *
 *  @param  longitude
 *
 *  @return NSDictionary    ( 经度 key 是 longitude, 纬度 key 是 latitude )
 *
 *  @since  1.0.7
 */
- (NSDictionary *) coordEncrypt:(double)latitude longitude:(double)longitude {
    
    static double const xPI     = (3.14159265358979324 * 3000.0 / 180.0);
    NSString *latitudeString    = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString   = [NSString stringWithFormat:@"%f", longitude];
    NSLog(@" 获取定位信息 转换之前 --> %@, %@", latitudeString, longitudeString);
    CGFloat latit               = [latitudeString    floatValue];
    CGFloat longt               = [longitudeString   floatValue];
    double x                    = longt;
    double y                    = latit;
    double z                    = sqrt(x * x + y * y) + 0.00002 * sin(y * xPI);
    double theta                = atan2(y, x) + 0.000003 * cos(x * xPI);
    longt                       = z * cos(theta) + 0.0065;
    latit                       = z * sin(theta) + 0.006;
    latitudeString              = [NSString stringWithFormat:@"%f", latit];
    longitudeString             = [NSString stringWithFormat:@"%f", longt];
    NSDictionary *dict          = @{
                                    @"latitude"  : latitudeString,
                                    @"longitude" : longitudeString,
                                    };
    NSLog(@" 获取定位信息 转换之后 --> %@, %@", latitudeString, longitudeString);
    return dict;
}



/*!
 *  @author swp_song, 2015-12-8 15:12:36
 *
 *  @brief  coordDecrypt    (百度 定位 坐标 转换成 高德 坐标)
 *
 *  @param  latitude
 *
 *  @param  longitude
 *
 *  @return NSDictionary    ( 经度 key 是 longitude, 纬度 key 是 latitude )
 *
 *  @since  1.0.7
 */
- (NSDictionary *) coordDecrypt:(double)latitude longitude:(double)longitude {
    
    //转换百度坐标获取位置
    
    static double const xPI     = (3.14159265358979324 * 3000.0 / 180.0);
    NSString *latitudeString    = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString   = [NSString stringWithFormat:@"%f", longitude];
    NSLog(@" 获取定位信息 转换之前 --> %@, %@", latitudeString, longitudeString);
    NSLog(@"%@, %@", latitudeString, longitudeString);
    CGFloat latit               = [latitudeString    floatValue];
    CGFloat longt               = [longitudeString   floatValue];
    //百度坐标系转换为火星坐标系
    double x                    = longt - 0.0065;
    double y                    = latit - 0.006;
    double z                    = sqrt(x * x + y * y) - 0.00002 * sin(y * xPI);
    double theta                = atan2(y, x) - 0.000003 * cos(x * xPI);
    longt                       = z * cos(theta);
    latit                       = z * sin(theta);
    latitudeString              = [NSString stringWithFormat:@"%f", latit];
    longitudeString             = [NSString stringWithFormat:@"%f", longt];
    
    NSDictionary *dict          = @{
                                    @"latitude"  : latitudeString,
                                    @"longitude" : longitudeString,
                                    };
    NSLog(@" 获取定位信息 转换之后 --> %@, %@", latitudeString, longitudeString);
    
    return dict;
}




/*!
 *  @author swp_song, 2015-12-08 15:20:55
 *
 *  @brief  swpCoordinateConvertPoint (经纬度 转换成 CGPoint)
 *
 *  @param  coordinate
 *
 *  @return CGPoint
 *
 *  @since  1.0.7
 */
- (CGPoint) swpCoordinateConvertPoint:(CLLocationCoordinate2D)coordinate  {
    CGPoint point = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    return point;
}

/*!
 *  @author swp_song, 2015-12-08 16:30:23
 *
 *  @brief  zzTransGPS ( 火星 坐标 转换方法 )
 *
 *  @param  yGps
 *
 *  @return CLLocationCoordinate2D
 *
 *  @since  1.0.7
 */
- (CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps {
    
    int TenLat    = 0;
    int TenLog    = 0;
    TenLat        = (int)(yGps.latitude  * 10);
    TenLog        = (int)(yGps.longitude * 10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    NSLog(@"slq = %@", sql);
    sqlite3_stmt* stmtL = [self.sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step (stmtL) ==SQLITE_ROW ) {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
    }
    yGps.latitude  = yGps.latitude  + offLat * 0.0001;
    yGps.longitude = yGps.longitude + offLog * 0.0001;
    
    return yGps;
}



#pragma mark - Init UI Methods
- (MKMapView *)mapView {
    
    if (!_mapView) {
        _mapView                  = [[MKMapView alloc] init];
        _mapView.delegate         = self;
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        [self settingTapGestureRecognizer:_mapView clickCount:1 addTarget:self action:@selector(didMapView:) cancelsTouchesInView:YES];
    }
    return _mapView;
}

#pragma mark - Init Object Methods
- (CLLocationManager *)swpLocationManager {
    if (!_swpLocationManager) {
        _swpLocationManager = [[CLLocationManager alloc] init];
    }
    return _swpLocationManager;
}

- (CLGeocoder *)swpGeocoder {
    
    if (!_swpGeocoder) {
        _swpGeocoder = [[CLGeocoder alloc] init];
    }
    return _swpGeocoder;
}

- (CSqlite *)sqlite {
    if (!_sqlite) {
        _sqlite = [[CSqlite alloc] init];
        [_sqlite openSqlite];
    }
    return _sqlite;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
