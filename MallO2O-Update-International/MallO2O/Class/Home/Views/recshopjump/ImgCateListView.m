//
//  ImgCateListView.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ImgCateListView.h"

@interface ImgCateListView ()

@property (strong ,nonatomic) UIImageView *imageView;

@property (strong ,nonatomic) UILabel *shopNameLabel;

@property (strong ,nonatomic) UILabel *shopAddressLabel;

@property (nonatomic, strong) UILabel *distance1;



@end

@implementation ImgCateListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

#pragma mark 重写set方法
//图片
- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@""]];
}
//label 商家名称
- (void)setShopNameText:(NSString *)shopNameText{
    _shopNameText = shopNameText;
    _shopNameLabel.text = _shopNameText;
}
//label 商家位置
- (void)setShopAddressText:(NSString *)shopAddressText{
    _shopAddressLabel.text = shopAddressText;
}

//商家距离
-(void)setDistance:(NSString *)distance{
    _distance1.text = distance;
}

/**
 添加控件
 */
- (void)addUI{
    _imageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:_imageView];
    _shopNameLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:_shopNameLabel];
    _shopAddressLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:_shopAddressLabel];
    _distance1 = [[UILabel alloc] initForAutoLayout];
    _distance1.textAlignment = NSTextAlignmentRight;
    [self addSubview:_distance1];
    [self settingAutoLayout];
//    [self setData];
}

/**
 自动布局
 */
- (void)settingAutoLayout{
    [_imageView autoSetDimension:ALDimensionHeight toSize:61 * Balance_Heith];
    [_imageView autoSetDimension:ALDimensionWidth toSize:61 * Balance_Width];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11 * Balance_Heith];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:11 * Balance_Width];
    _imageView.layer.borderWidth = 0.7;
    _imageView.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
    
    [_shopNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imageView withOffset:5];
    [_shopNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:14 * Balance_Heith];
    [_shopNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_shopNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    _shopNameLabel.textColor = UIColorFromRGB(0x444444);
    
    [_shopAddressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imageView withOffset:5];
    [_shopAddressLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shopNameLabel withOffset:5];
    [_shopAddressLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [_shopAddressLabel autoSetDimension:ALDimensionHeight toSize:50];
    [_shopAddressLabel setNumberOfLines:2];
    _shopAddressLabel.textColor = UIColorFromRGB(0x969595);
    _shopAddressLabel.font = [UIFont systemFontOfSize:13];
    
    [_distance1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:11];
    [_distance1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [_distance1 autoSetDimension:ALDimensionHeight toSize:15];
    [_distance1 autoSetDimension:ALDimensionWidth toSize:100];
    _distance1.textColor = UIColorFromRGB(0x444444);

    
}


@end
