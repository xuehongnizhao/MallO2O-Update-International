//
//  HomeBtnView.m
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeBtnView.h"

@implementation HomeBtnView

- (instancetype)initForAutoLayout{
    if (self = [super init]) {
        [self addUI];
    }
    return self;
}

/*
    添加view内的控件
 */
- (void)addUI{
    _homeBtnImgView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:_homeBtnImgView];
    
    _cateImgLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:_cateImgLabel];
    
    [ self setAutoLayout];
}

/*
    设置自动布局
 */
- (void)setAutoLayout{
    /*=====图片的自动布局=====*/
    [_homeBtnImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12.0f * Balance_Heith];
//    [_homeBtnImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0f * Balance_Width];
    [_homeBtnImgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_homeBtnImgView autoSetDimension:ALDimensionWidth toSize:37.0f * Balance_Width];
    [_homeBtnImgView autoSetDimension:ALDimensionHeight toSize:37 * Balance_Heith];
    /*===设置属性===*/
//    _homeBtnImgView.layer.borderWidth = 1;
    _homeBtnImgView.layer.masksToBounds = YES;
    _homeBtnImgView.layer.cornerRadius = 20.0f * Balance_Heith;
    
    
    /*=====label的自动布局=====*/
    [_cateImgLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3.0f * Balance_Heith];
    [_cateImgLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_cateImgLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_cateImgLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    /*===设置属性===*/
//    _cateImgLabel.layer.borderWidth = 1;
    _cateImgLabel.textColor = UIColorFromRGB(0x4e4e4e);
    _cateImgLabel.font = [UIFont systemFontOfSize:12.0f];
    _cateImgLabel.numberOfLines = 1;
    _cateImgLabel.textAlignment = NSTextAlignmentCenter;
}

/**
 set方法
 */
- (void)setImgUrl:(NSString *)imgUrl{
//    [self addUI];
    [_homeBtnImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@""]];
}



@end
