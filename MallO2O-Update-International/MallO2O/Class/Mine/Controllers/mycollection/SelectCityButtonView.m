//
//  SelectCityButtonView.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/7.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SelectCityButtonView.h"

@interface SelectCityButtonView ()

@property (strong ,nonatomic) UILabel *label;

@property (strong ,nonatomic) UIImageView *imageView;

@end

@implementation SelectCityButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.label];
    [self addSubview:self.imageView];
}

- (void)settingAutoLayout{
    [_label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [_label sizeToFit];
    
    [_imageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_label withOffset:0];
    [_imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [_imageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_imageView];
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initForAutoLayout];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:17];
    }
    return _label;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
    }
    return _imageView;
}

- (void)setCityName:(NSString *)cityName{
    _label.text = cityName;
    
}

@end
