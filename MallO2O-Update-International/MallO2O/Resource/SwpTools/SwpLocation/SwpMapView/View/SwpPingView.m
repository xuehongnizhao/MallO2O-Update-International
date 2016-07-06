//
//  SwpPingView.m
//  MKMapDemo
//
//  Created by songweiping on 15/8/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SwpPingView.h"

#import "SwpAnnotation.h"

@implementation SwpPingView

+ (instancetype) swpPingViewWithMapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString  *annotID    = @"swpSystemPinViewID";
    // 注意: 默认情况下 MKAnnotationView 是无法显示的 如果想自定义 大头针 可以使用 MKAnnotationView 的子类
    // MKPinAnnotationView - 自定义大头针 默认是不会显示标题, 修改手动显示
    SwpPingView *annotView  = (SwpPingView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotID];
    if (annotView == nil) {
        annotView = [[SwpPingView alloc] initWithAnnotation:nil reuseIdentifier:annotID];
    }

//    SwpAnnotation *annon  = (SwpAnnotation *)annotation;
    // 设置自定义图片
//    annotView.image       = [UIImage imageNamed:annon.icon];
    annotView.annotation  = annotation;

    return annotView;
}

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        [self settingSwpSystemPinProperty];
    }
    return self;
}

/**
 *  设置 自定义系统大头针一些 属性
 */
- (void) settingSwpSystemPinProperty {
    
    /**
     *  继承的是 MKAnnotationView 类 是 MKPinAnnotationView 的父类
     *  pinColor 和 animatesDrop 这两个属性 没有，该属性属于 MKPinAnnotationView
     */
    // 设置大头针 颜色
    //self.pinColor       = MKPinAnnotationColorGreen;
    // 设置大头针 从天而降动画
    //self.animatesDrop   = YES;
    
    // 设置大头针 是否显示信息
    self.canShowCallout = YES;
    // 设置大头针 标题显示的偏移量
    self.calloutOffset  = CGPointMake(0, 0);
    // 设置大头针 左侧的辅助视图(左侧添加一个控件)
    self.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // 设置大头针 右侧的辅助视图(右侧添加一个控件)
    self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
}

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    
    SwpAnnotation *annot = (SwpAnnotation *)annotation;
    self.image           = [UIImage imageNamed:annot.icon];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
