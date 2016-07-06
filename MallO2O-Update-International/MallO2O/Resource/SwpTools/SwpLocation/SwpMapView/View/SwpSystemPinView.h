//
//  SwpSystemPinView.h
//  MKMapDemo
//
//  Created by songweiping on 15/8/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface SwpSystemPinView : MKPinAnnotationView

/*!
 *  快速创建一个 自定义系统大头针
 *
 *  @param  mapView    显示大头针的mapView;
 *  @param  annotation 大头针的数据的模型
 *
 *  @return SwpSystemPinView
 */
+ (instancetype) swpSystemPinViewWithMapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation ;

@end
