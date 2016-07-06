//
//  SwpLocation.h
//  Swp_song
//
//  Created by songweiping on 15/8/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//
//  @author             --->    swp_song
//
//  @modification Time  --->    2015-12-08 22:52:53
//
//  @since              --->    1.0.7
//
//  @warning            --->    !!! < 需要导入框架 CoreLocation(定位框架), 和 libsqlite3.0 (sqlite) > !!!

#import <Foundation/Foundation.h>

/*! ---------------------- Tool       ---------------------- !*/
#import <CoreLocation/CoreLocation.h>      // 系统定位框架
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpLocationModel.h"               // 封住自定义定位模型
/*! ---------------------- Model      ---------------------- !*/

@class SwpLocation;

/*! SwpLocation Success Block    !*/
typedef void (^SwpLocationSuccessHeadle)(SwpLocation *swpLocation, SwpLocationModel *swpLocationMessage);
/*! SwpLocation Error   Block    !*/
typedef void(^SwpLocationErrorHeadle)(SwpLocation *swpLocation, NSError *error);

/*! SwpLocationDelegate Protocol !*/
@protocol SwpLocationDelegate <NSObject>

@optional


/*!
 *  @author swp_song, 2015-12-08 21:00:43
 *
 *  @brief  swpLocation Delegate (swpLocation 代理方法 定位成功之后调用, 获取 定位信息之前调用)
 *
 *  @param  swpLocation
 *
 *  @param  locations
 *
 *  @since  1.0.7
 */
- (void)swpLocationSuccess:(SwpLocation *)swpLocation locationMessage:(NSArray *)locations;

/*!
 *  @author swp_song, 2015-12-08 22:16:47
 *
 *  @brief  swpLocation Delegate (swpLocation 代理方法 定位成功之后调用, 获取定位信息成功调用)
 *
 *  @param  swpLocation
 *
 *  @param  swpLocationModel
 *
 *  @since  1.0.7
 */
- (void)swpLocationSuccess:(SwpLocation *)swpLocation locationModel:(SwpLocationModel *)swpLocationModel;

/*!
 *  @author swp_song, 2015-12-08 22:19:21
 *
 *  @brief  swpLocation Delegate (swpLocation 代理方法 定位失败调用)
 *
 *  @param  swpLocation
 *
 *  @param  error
 *
 *  @since  1.0.7
 */
- (void)swpLocationError:(SwpLocation *)swpLocation didFailWithError:(NSError *)error;


@end

@interface SwpLocation : NSObject

/*! swpLocation Delegate    */
@property (nonatomic, weak) id<SwpLocationDelegate> delegate;

/*!
 *  @author swp_song, 2015-12-08 15:55:47
 *
 *  @brief  打开定位
 *
 *  @since  1.0.7
 */
- (void) swpOpenLocation;

/*!
 *  @author swp_song, 15-12-08 15:12:14
 *
 *  @brief  开始定位
 *
 *  @since  1.0.7
 */
- (void) swpStartLocation;

/*!
 *  @author swp_song, 2015-12-08 16:06:17
 *
 *  @brief  停止定位
 *
 *  @since  1.0.7
 */
- (void) swpStopLocation;

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
- (void)swpLocationSuccessMessage:(SwpLocationSuccessHeadle)swpLocationSuccessHeadle;

/*!
 *  @author swp_song, 2016-01-18 10:23:12
 *
 *  @brief  swpLocationErrorMessage ( 获取 定位失败信息 使用 Block )
 *
 *  @param  swpLocationErrorHeadle
 *
 *  @since  1.0.7
 */
- (void)swpLocationErrorMessage:(SwpLocationErrorHeadle)swpLocationErrorHeadle;

#pragma mark - Tools Methods

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
- (NSDictionary *) coordEncrypt:(double)latitude longitude:(double)longitude;

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
- (NSDictionary *) coordDecrypt:(double)latitude longitude:(double)longitude;

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
- (CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps;

@end
