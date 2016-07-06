//
//  SwpMapView.h
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


#import <UIKit/UIKit.h>


/*! ---------------------- Tool       ---------------------- !*/
#import <MapKit/MapKit.h>
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpLocationModel.h"
/*! ---------------------- Model      ---------------------- !*/
@class SwpMapView;

/*! SwpMapView Protocol */
@protocol SwpMapViewDelegate <NSObject>

@optional




/*!
 *  @author swp_song, 2015-12-08 13:48:56
 *
 *  @brief  swpMapView Delegate (swpMapView 代理方法 用户位置更新 时 调用)
 *
 *  @param  swpMapView      swpMapview
 *
 *  @param  mapView         mapView
 *
 *  @param  userLocation    userLocationMessage
 *
 *  @param  swpLocation     swpLocationMessage
 *
 *  @since  1.0.7
 */
- (void) swpMapView:(SwpMapView *)swpMapView showMapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation locationMessage:(SwpLocationModel *)swpLocation;

/*!
 *  @author swp_song, 2015-12-08 13:54:17
 *
 *  @brief  swpMapView Delegate ( swpMapView 代理方法 每次添加大头针就会调用, 地图上有几个大头针就会调用几次)
 *
 *  @param  swpMapView      swpMapview
 *
 *  @param  mapView         mapView
 *
 *  @param  annotation      annotationModel
 *
 *  @return MKAnnotationView
 *
 *  @since  1.0.7
 */
- (MKAnnotationView *) swpMapView:(SwpMapView *)swpMapView showPinMapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;

/*!
 *  @author swp_song, 2015-12-08 13:57:13
 *
 *  @brief  swpMapView Delegate ( swpMapView 代理方法 选中大头针 时 调用)
 *
 *  @param  swpMapView      swpMapview
 *
 *  @param  mapView         mapView
 *
 *  @param  view            MKAnnotationView
 *
 *  @since  1.0.7
 */
- (void) swpMapView:(SwpMapView *)swpMapView showPinMapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view;

/*!
 *  @author swp_song, 2015-12-08 14:00:59
 *
 *  @brief  swpMapView Delegate ( swpMapView 代理方法 取消选中 或者 选中其他的大头针 时 调用)
 *
 *  @param  swpMapView      swpMapview
 *
 *  @param  mapView         mapView
 *
 *  @param  view            MKAnnotationView
 *
 *  @since  1.0.7
 */
- (void) swpMapView:(SwpMapView *)swpMapView showPinMapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view;


/*!
 *  @author swp_song, 2015-12-08 14:09:03
 *
 *  @brief  swpMapView Delegate ( swpMapView 代理方法 点击 swpMapView 调用)
 *
 *  @param  swpMapView      swpMapview
 *
 *  @param  mapView         mapView
 *
 *  @param  location        didLocation
 *
 *  @since  1.0.7
 */
- (void) swpMapView:(SwpMapView *)swpMapView didMapView:(MKMapView *)mapView didGetLocation:(CLLocation *)location;


@end

@interface SwpMapView : UIView

/*!  swpMapView Delegate                          */
@property (nonatomic, weak  ) id<SwpMapViewDelegate> delegate;
/*! 设置 swpMapView 显示的样式                    */
@property (nonatomic, assign) MKMapType             swpMapViewType;
/*! 设置 swpMapView 用户定位的大头针 是否跟随自己 */
@property (nonatomic, assign) MKUserTrackingMode    swpUserTrackingMode;
/*!
 *  设置 swpMapView 用户定位之后 经纬度跨度
 *  跨度越小 地图缩放越大
 */
@property (nonatomic, assign) MKCoordinateSpan      swpSpan;

/*!
 *  @author swp_song, 2015-12-08 11:53:54
 *
 *  @brief  setSwpMapViewType (设置 swpMapViewType )
 *
 *  @param  swpMapViewType
 *
 *  @since  1.0.7
 */
- (void)setSwpMapViewType:(MKMapType)swpMapViewType;

/*!
 *  @author swp_song, 2015-12-8 11:12:27
 *
 *  @brief  setSwpUserTrackingMode (设置 swpMapView 用户定位的大头针 是否跟随自己)
 *
 *  @param  swpUserTrackingMode
 *
 *  @since  1.0.7
 */
- (void)setSwpUserTrackingMode:(MKUserTrackingMode)swpUserTrackingMode;

/*!
 *  @author swp_song, 2015-12-08 11:58:05
 *
 *  @brief  setSwpSpan (设置 swpMapView 用户定位之后 经纬度跨度, 跨度越小 地图缩放越大)
 *
 *  @param  swpSpan
 *
 *  @since  1.0.7
 */
- (void)setSwpSpan:(MKCoordinateSpan)swpSpan;

/*!
 *  @author swp_song, 2015-12-08 12:00:59
 *
 *  @brief  swpMapViewAddSubview (subview 需要添加的控件)
 *
 *  @param  subview
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddSubview:(UIView *)subview;

/*!
 *  @author swp_song, 2015-12-08 13:19:04
 *
 *  @brief  swpMapViewAddAnnotation (swpMapView 上添一个加大头针)
 *
 *  @param  annotation
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddAnnotation:(id <MKAnnotation>)annotation;

/*!
 *  @author swp_song, 2015-12-08 13:20:32
 *
 *  @brief  swpMapView 添加多个大头针(大头针个数 取决于 数组的长度)
 *
 *  @param  annotations
 *
 *  @since  1.0.7
 */
- (void) swpMapViewAddAnnotations:(NSArray *)annotations;

/*!
 *  @author swp_song, 2015-12-08 13:24:20
 *
 *  @brief  swpMapViewRemoveAnnotation  ( 删除 swpMapView 上的 单个大头针 )
 *
 *  @param  annotation
 *
 *  @since  1.0.7
 */
- (void) swpMapViewRemoveAnnotation:(id <MKAnnotation>)annotation;

/*!
 *  @author swp_song, 2015-12-08 13:36:59
 *
 *  @brief  swpMapViewRemoveAnnotations (删除 swpMapView  上的多个大头针, 删除个数 取决于 数组的长度)
 *
 *  @param  annotations
 *
 *  @since  1.0.7
 */
- (void) swpMapViewRemoveAnnotations:(NSArray *)annotations;

/*!
 *  @author swp_song, 2015-12-08 13:38:42
 *
 *  @brief  swpMapViewStartLocationUpdate(开启 实时更新 定位信息)
 *
 *  @since  1.0.7
 */
- (void) swpMapViewStartLocationUpdate;

/*!
 *  @author swp_song, 2015-12-08 13:39:38
 *
 *  @brief  swpMapViewStopLocationUpdate ( 关闭 实时更新 定位信息 )
 *
 *  @since  1.0.7
 */
- (void) swpMapViewStopLocationUpdate;

/*!
 *  @author swp_song, 2015-12-8 13:12:53
 *
 *  @brief  swpMapViewGetLocationStatus (获取 定位 是否 开启的状态)
 *
 *  @return BOOL ( YES 开启 NO 关闭 )
 *
 *  @since  1.0.7
 */
- (BOOL) swpMapViewGetLocationStatus;


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
- (void) swpSwpMapViewGetLocationMessage:(CLLocation *)location locationMessage:(void(^)(NSArray *placemarks, NSError *error, SwpLocationModel *swpMessage))locationMessage;

#pragma mark - Tools 

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
- (NSDictionary *) coordEncrypt:(double)latitude longitude:(double)longitude;

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
- (NSDictionary *) coordDecrypt:(double)latitude longitude:(double)longitude;

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
- (CGPoint) swpCoordinateConvertPoint:(CLLocationCoordinate2D)coordinate;




@end
