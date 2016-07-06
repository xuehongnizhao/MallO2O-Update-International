//
//  SwpLocationModel.h
//  Swp_song
//
//  Created by songweiping on 15/8/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLPlacemark;

@interface SwpLocationModel : NSObject

/*! 苹果定位原始坐标 纬度     */
@property (nonatomic, assign) double      latitude;
/*! 苹果定位原始坐标 经度度   */
@property (nonatomic, assign) double      longitude;

/*! 火星坐标 纬度             */
@property (nonatomic, assign) double      marsLatitude;
/*! 火星坐标 经度             */
@property (nonatomic, assign) double      marsLongitude;
/*! 百度坐标 纬度             */
@property (nonatomic, assign) double      baiduLatitude;
/*! 百度坐标 经度             */
@property (nonatomic, assign) double      baiduLongitude;

/*! 定位名称                  */
@property (nonatomic,   copy) NSString    *name;
/*! 定位国家                  */
@property (nonatomic,   copy) NSString    *country;
/*! 定位省市                  */
@property (nonatomic,   copy) NSString    *administrativeArea;
/*! 定位城市                  */
@property (nonatomic,   copy) NSString    *locality;
/*! 定位城市中地区            */
@property (nonatomic,   copy) NSString    *subLocality;
/*! 定位街道                  */
@property (nonatomic,   copy) NSString    *thoroughfare;
/*! 定位门牌号                */
@property (nonatomic,   copy) NSString    *subThoroughfare;
/*! 定位信息数组              */
@property (nonatomic,   copy) NSArray     *placemarks;
/*! 获取定位具体城市对象      */
@property (nonatomic, strong) CLPlacemark *placemark;
/*! 定位失败错误信息          */
@property (nonatomic, strong) NSError     *error;


@end
