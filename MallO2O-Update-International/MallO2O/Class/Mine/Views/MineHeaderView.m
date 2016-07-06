//
//  MineHeaderView.m
//  MallO2O
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

- (void)clickView:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(selectView:)]) {
        [self.delegate selectView:gesture.view.tag];
    }
}

- (void)addUI{
    [self addSubview:self.imgView];
    [self addSubview:self.typeLabel];
}

- (void)settingAutoLayout{
    [_imgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_imgView autoSetDimension:ALDimensionWidth toSize:34];
    [_imgView autoSetDimension:ALDimensionHeight toSize:34];
//    _imgView.layer.borderWidth = 1;
    
    [_typeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_typeLabel autoSetDimension:ALDimensionHeight toSize:25];
//    _typeLabel.layer.borderWidth = 1;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _imgView;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initForAutoLayout];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = UIColorFromRGB(0x7e7e7e);
    }
    return _typeLabel;
}

@end
