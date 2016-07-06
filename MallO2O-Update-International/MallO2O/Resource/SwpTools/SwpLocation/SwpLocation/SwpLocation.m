//
//  SwpLocation.m
//  Swp_song
//
//  Created by songweiping on 15/8/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song
//
//  @modification Time  --->    2015-12-08 22:52:53
//
//  @since              --->    1.0.7
//
//  @warning            --->    !!! < 需要导入框架 CoreLocation(定位框架), 和 libsqlite3.0 (sqlite) > !!!

#import "SwpLocation.h"

#import <UIKit/UIKit.h>
/*! ---------------------- Tool       ---------------------- !*/
#import "CSqlite.h"                     // 定位
/*! ---------------------- Tool       ---------------------- !*/

@interface SwpLocation ()<CLLocationManagerDelegate>

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 定位信息管理者            !*/
@property (nonatomic, strong) CLLocationManager    *swpLocationManager;
/*! sqlite 坐标转换           !*/
@property (nonatomic, strong) CSqlite              *sqlite;
/*! 地理编码对象              !*/
@property (nonatomic, strong) CLGeocoder           *swpGeocoder;

/*! 获取定位成功的 Block      !*/
@property (nonatomic, copy  ) SwpLocationSuccessHeadle swpLocationSuccessHeadle;
/*! 获取定位失败的 Block      !*/
@property (nonatomic, copy  ) SwpLocationErrorHeadle   swpLocationErrorHeadle;
/*! 包装定位信息的数据模型    !*/
@property (nonatomic, strong) SwpLocationModel         *swpLocationModel;
/*! 苹果定位原始坐标 纬度     !*/
@property (nonatomic, assign) double                   latitude;
/*! 苹果定位原始坐标 经度度   !*/
@property (nonatomic, assign) double                   longitude;
/*! 火星坐标 纬度             !*/
@property (nonatomic, assign) double                   marsLatitude;
/*! 火星坐标 经度             !*/
@property (nonatomic, assign) double                   marsLongitude;
/*! 百度坐标 纬度             !*/
@property (nonatomic, assign) double                   baiduLatitude;
/*! 百度坐标 经度             !*/
@property (nonatomic, assign) double                   baiduLongitude;
#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpLocation

/*!
 *  @author swp_song, 2015-12-08 15:55:47
 *
 *  @brief  打开定位
 *
 *  @since  1.0.7
 */
- (void) swpOpenLocation {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [self.swpLocationManager requestWhenInUseAuthorization];
        [self.swpLocationManager requestAlwaysAuthorization];
    }
    
    // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.swpLocationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    [self.swpLocationManager startUpdatingLocation];
    
}

/*!
 *  @author swp_song, 15-12-08 15:12:14
 *
 *  @brief  开始定位
 *
 *  @since  1.0.7
 */
- (void) swpStartLocation {
    [self.swpLocationManager startUpdatingLocation];
}

/*!
 *  @author swp_song, 2015-12-08 16:06:17
 *
 *  @brief  停止定位
 *
 *  @since  1.0.7
 */
- (void) swpStopLocation {
    [self.swpLocationManager stopUpdatingLocation];
}



#pragma mark - locationManager Delegate & SwpLocation Delegate - Methods

/*!
 *  @author swp_song, 2015-12-08 18:06:19
 *
 *  @brief  locationManager Delegate ( 获取到定位信息就回调用 )
 *
 *  @param  manager
 *
 *  @param  status
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    /**
     
     用户从未选择过权限
     kCLAuthorizationStatusNotDetermined
     无法使用定位服务，该状态用户无法改变
     kCLAuthorizationStatusRestricted
     用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
     kCLAuthorizationStatusDenied
     已经授权（废弃）
     kCLAuthorizationStatusAuthorized
     用户允许该程序无论何时都可以使用地理信息
     kCLAuthorizationStatusAuthorizedAlways
     用户同意程序在可见时使用地理位置
     kCLAuthorizationStatusAuthorizedWhenInUse
     */
    
    if (status == kCLDistanceFilterNone) {
        NSLog(@"等待用户授权");
    } else if (
               status == kCLAuthorizationStatusAuthorizedAlways ||
               status ==  kCLAuthorizationStatusAuthorizedWhenInUse
               ) {
        
        NSLog(@"授权成功");
        [self swpStartLocation];
        
    } else {
        NSLog(@"授权失败");
    }
    
}

/*!
 *  @author swp_song, 2015-12-08 18:08:01
 *
 *  @brief  locationManager Delegate ( locationManager 代理方法 定位成功 获取到定位信息就回调用 )
 *
 *  @param  manager
 *
 *  @param  locations
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    

    // 停止定位
    [self swpStopLocation];
    
    // 实现 代理方法
    if ([self.delegate respondsToSelector:@selector(swpLocationSuccess:locationMessage:)]) {
        // 定位成功调用
        [self.delegate swpLocationSuccess:self locationMessage:locations];
    }
    
    if ([self.delegate respondsToSelector:@selector(swpLocationSuccess:locationModel:)]) {
        
        // 定位成功 并且 获取 用户定位信息
        CLLocationCoordinate2D locationCoord = [self saveLocationCoord:locations];
        [self swpGeocodeCoordGetAddress:locationCoord dataDispose:^{
            [self.delegate swpLocationSuccess:self locationModel:self.swpLocationModel];
        }];
    }
    
    
    // 使用 block 带出 数据
    if (!([self.delegate respondsToSelector:@selector(swpLocationSuccess:locationMessage:)] || [self.delegate respondsToSelector:@selector(swpLocationSuccess:locationModel:)])) {
    
        // 保存 对应的坐标 返回 转换完毕 的 火星坐标
        CLLocationCoordinate2D locationCoord = [self saveLocationCoord:locations];
        // 根据 火星 坐标 获取 对应的数据
        [self swpGeocodeCoordGetAddress:locationCoord dataDispose:^{
            // 判断 SwpLocationBlock 是否 为空
            if (self.swpLocationSuccessHeadle != nil) self.swpLocationSuccessHeadle(self, self.swpLocationModel);
            
        }];
    }
    
}


/*!
 *  @author swp_song, 2015-12-08 20:59:32
 *
 *  @brief  locationManager Delegate ( locationManager 代理方法 定位失败时调用 )
 *
 *  @param  manager
 *
 *  @param  error
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if (self.swpLocationErrorHeadle) self.swpLocationErrorHeadle(self, error);
    if ([self.delegate respondsToSelector:@selector(swpLocationError:didFailWithError:)]) {
        [self.delegate respondsToSelector:@selector(swpLocationError:didFailWithError:)];
    }
}


#pragma mark - SwpLocation Success  Message Use Black Methods
/*!
 *  @author swp_song, 2015-12-08 22:29:18
 *
 *  @brief  swpLocationSuccessMessage ( 获取 定位成功信息 使用 Block )
 *
 *  @param  swpLocationMessage
 *
 *  @since  1.0.7
 */
- (void)swpLocationSuccessMessage:(SwpLocationSuccessHeadle)swpLocationSuccessHeadle {
    self.swpLocationSuccessHeadle = swpLocationSuccessHeadle;
}

/*!
 *  @author swp_song, 2016-01-18 10:23:12
 *
 *  @brief  swpLocationErrorMessage ( 获取 定位失败信息 使用 Block )
 *
 *  @param  swpLocationErrorHeadle
 *
 *  @since  1.0.7
 */
- (void)swpLocationErrorMessage:(SwpLocationErrorHeadle)swpLocationErrorHeadle {
    self.swpLocationErrorHeadle = swpLocationErrorHeadle;
}



#pragma mark - Tools Methods
/*!
 *  @author swp_song, 2015-12-08 22:31:20
 *
 *  @brief  swpGeocodeAddressGetCoord ( 根据名称 获取定位信息 <地理编码>)
 *
 *  @param  name
 *
 *  @param  dataDispose 
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
 *  @author swp_song, 2015-12-08 22:32:24
 *
 *  @brief  swpGeocodeCoordGetAddress ( 根据坐标 获取定位信息 <反地理编码> )
 *
 *  @param  locationCoord
 *
 *  @param  dataDispose
 *
 *  @since
 */
- (void) swpGeocodeCoordGetAddress:(CLLocationCoordinate2D)locationCoord dataDispose:(void (^)(void))dataDispose {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:locationCoord.latitude longitude:locationCoord.longitude];
    [self.swpGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        self.swpLocationModel = [self settingSwpLocationMessageData:placemarks locationError:error];
        dataDispose();
    }];
}




/*!
 *  @author swp_song, 2015-12-08 22:42:39
 *
 *  @brief  saveLocationCoord ( 保存转换的坐标)
 *
 *  @param  locations
 *
 *  @return CLLocationCoordinate2D
 *
 *  @since  1.0.7
 */
- (CLLocationCoordinate2D) saveLocationCoord:(NSArray *)locations {
    
    CLLocation             *location        = [locations lastObject];
    // 转换成火星坐标
    CLLocationCoordinate2D locationCoord    = [self zzTransGPS:location.coordinate];
    self.longitude       = location.coordinate.longitude;
    self.latitude        = location.coordinate.latitude;
    self.marsLatitude    = locationCoord.latitude;
    self.marsLongitude   = locationCoord.longitude;
    // 转换成百度坐标
    NSDictionary *dict   = [self coordEncrypt:locationCoord.latitude longitude:locationCoord.longitude];
    self.baiduLatitude   = [dict[@"latitude"]  doubleValue];
    self.baiduLongitude  = [dict[@"longitude"] doubleValue];
    
    return locationCoord;
}

/*!
 *  @author swp_song, 15-12-08 22:12:43
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
- (SwpLocationModel *) settingSwpLocationMessageData:(NSArray *)placemarks locationError:(NSError *)error  {
    
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
 *  @author swp_song, 2015-12-08 22:44:36
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
 *  @author swp_song, 2015-12-08 22:46:03
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
 *  @author swp_song, 2015-12-08 22:49:55
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


#pragma mark - Init Object Method
- (CLLocationManager *)swpLocationManager {
    
    if (!_swpLocationManager) {
        
        _swpLocationManager          = [[CLLocationManager alloc] init];
        _swpLocationManager.delegate = self;
    }
    return _swpLocationManager;
}

- (CSqlite *)sqlite {
    if (!_sqlite) {
        _sqlite = [[CSqlite alloc] init];
        [_sqlite openSqlite];
    }
    return _sqlite;
}

- (CLGeocoder *)swpGeocoder{
    if (!_swpGeocoder) {
        _swpGeocoder = [[CLGeocoder alloc] init];
        
    }
    return _swpGeocoder;
}

#pragma mark - Init DataModel Method
- (SwpLocationModel *)swpLocationModel {
    
    if (!_swpLocationModel) {
        _swpLocationModel = [[SwpLocationModel alloc] init];
    }
    return _swpLocationModel;
}

@end
