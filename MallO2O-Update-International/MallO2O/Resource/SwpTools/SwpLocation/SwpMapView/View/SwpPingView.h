//
//  SwpPingView.h
//  MKMapDemo
//
//  Created by songweiping on 15/8/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface SwpPingView : MKAnnotationView

+ (instancetype) swpPingViewWithMapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;

@end
