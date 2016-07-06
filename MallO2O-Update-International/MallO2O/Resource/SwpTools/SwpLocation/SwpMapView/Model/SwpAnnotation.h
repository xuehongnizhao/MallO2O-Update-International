//
//  SwpAnnotation.h
//  MKMapDemo
//
//  Created by songweiping on 15/8/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface SwpAnnotation : NSObject <MKAnnotation>

/*! 大头针的位置   */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/*! 大头针标题     */
@property (nonatomic,   copy) NSString *title;
/*! 大头针的子标题 */
@property (nonatomic,   copy) NSString *subtitle;
/*! 图标           */
@property (nonatomic,   copy) NSString *icon;

@end
