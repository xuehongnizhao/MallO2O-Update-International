//
//  MapShopTurnView.m
//  MallO2O
//
//  Created by mac on 9/21/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "MapShopTurnView.h"

@interface MapShopTurnView ()

@property (strong ,nonatomic) UIImageView *shopImageView;

@property (strong ,nonatomic) UILabel *shopNameLabel;

@property (strong ,nonatomic) UILabel *shopAddressLabel;

@end

@implementation MapShopTurnView

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
    if ([self.delegate respondsToSelector:@selector(clickMapShopToTurnView:)]) {
        [self.delegate clickMapShopToTurnView:gesture.view.tag];
    }
}

- (void)addUI{
    [self addSubview:self.shopAddressLabel];
    [self addSubview:self.shopImageView];
    [self addSubview:self.shopNameLabel];
}

- (void)settingAutoLayout{
    [_shopImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) excludingEdge:ALEdgeRight];
    [_shopImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_shopImageView];
    
    [_shopNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_shopNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shopImageView withOffset:5];
    [_shopNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_shopNameLabel autoSetDimension:ALDimensionWidth toSize:250];
    
    [_shopAddressLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_shopAddressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shopImageView withOffset:5];
    [_shopAddressLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_shopAddressLabel autoSetDimension:ALDimensionWidth toSize:250];
}

- (void)setModel:(HomeListModel *)model{
    [_shopImageView sd_setImageWithURL:[NSURL URLWithString:model.shopImg]];
    _shopAddressLabel.text = model.shopAddress;
    _shopNameLabel.text = model.shopName;
}

- (UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc] initForAutoLayout];
        _shopNameLabel.textColor = [UIColor blackColor];
    }
    return _shopNameLabel;
}

- (UIImageView *)shopImageView{
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] initForAutoLayout];
    }
    return _shopImageView;
}

- (UILabel *)shopAddressLabel{
    if (!_shopAddressLabel) {
        _shopAddressLabel = [[UILabel alloc] initForAutoLayout];
        _shopAddressLabel.textColor = [UIColor blackColor];
    }
    return _shopAddressLabel;
}

@end
