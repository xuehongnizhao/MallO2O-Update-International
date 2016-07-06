//
//  SwpSystemPinView.m
//  MKMapDemo
//
//  Created by songweiping on 15/8/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SwpSystemPinView.h"


@interface SwpSystemPinView ()


@end

@implementation SwpSystemPinView

/*!
 *  快速创建一个 自定义系统大头针
 *
 *  @param  mapView    显示大头针的mapView;
 *  @param  annotation 大头针的数据的模型
 *
 *  @return SwpSystemPinView
 */
+ (instancetype) swpSystemPinViewWithMapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    static NSString  *annotID    = @"swpSystemPinViewID";
    // 注意: 默认情况下 MKAnnotationView 是无法显示的 如果想自定义 大头针 可以使用 MKAnnotationView 的子类
    // MKPinAnnotationView - 自定义大头针 默认是不会显示标题, 修改手动显示
    SwpSystemPinView *annotView  = (SwpSystemPinView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotID];
    if (annotView == nil) {
        annotView = [[SwpSystemPinView alloc] initWithAnnotation:nil reuseIdentifier:annotID];
    }
    annotView.annotation        = annotation;
    
    return annotView;
}

/*!
 *  重写初始化方法 (设置系统大头针的一些样式)
 *
 *  @param  annotation
 *  @param  reuseIdentifier
 *
 *  @return
 */
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
    
        [self settingSwpSystemPinProperty];
    }
    return self;
}


/*!
 *  设置 自定义系统大头针一些 属性
 */
- (void) settingSwpSystemPinProperty {
    
    // 设置大头针 颜色
//    self.pinColor       = MKPinAnnotationColorGreen;
    self.pinTintColor     = [UIColor blackColor];
    // 设置大头针 从天而降动画
    self.animatesDrop   = YES;
    // 设置大头针 是否显示信息
    self.canShowCallout = YES;
    // 设置大头针 标题显示的偏移量
    self.calloutOffset  = CGPointMake(0, 0);
    // 设置大头针 左侧的辅助视图(左侧添加一个控件)
    self.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    // 设置大头针 右侧的辅助视图(右侧添加一个控件)
    self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
