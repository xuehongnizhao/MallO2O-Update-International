//
//  HomeCateCollectionViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/17.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "HomeCateCollectionViewCell.h"
#import "SecondModel.h"

@interface HomeCateCollectionViewCell ()

@property (strong ,nonatomic) UIImageView *goodsImageView;

@property (strong ,nonatomic) UILabel *goodsNameLabel;

@property (strong ,nonatomic) UILabel *goodsPriceLabel;

@property (strong ,nonatomic) UILabel *goodsShopLabel;

@end

@implementation HomeCateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

+ (instancetype)homeCateColleciontView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
//    cell.layer.borderWidth = 0.7;
//    cell.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.goodsPriceLabel];
    [self.contentView addSubview:self.goodsShopLabel];
}

- (void)settingAutoLayout{
    [_goodsImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_goodsImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:_goodsImageView];
//    _goodsImageView.layer.borderWidth = 1;
    
    [_goodsNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsImageView withOffset:3*Balance_Heith];
    [_goodsNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_goodsNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_goodsNameLabel autoSetDimension:ALDimensionHeight toSize:18 * Balance_Heith];
//    _goodsNameLabel.layer.borderWidth = 1;
    
    [_goodsPriceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsNameLabel withOffset:1*Balance_Heith];
    [_goodsPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_goodsPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_goodsPriceLabel autoSetDimension:ALDimensionHeight toSize:18 * Balance_Heith];
//    _goodsPriceLabel.layer.borderWidth = 1;
    
    [_goodsShopLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsPriceLabel withOffset:1*Balance_Heith];
    [_goodsShopLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_goodsShopLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_goodsShopLabel autoSetDimension:ALDimensionHeight toSize:18 * Balance_Heith];
}

- (void)setModel:(SecondModel *)model{
    _model = model;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.secondImgUrlText] placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = model.secondTitleText;
    _goodsPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingFormat:@"%@",model.secondNowPriceText];
    _goodsShopLabel.text = model.secondShopName;
}

- (UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] initForAutoLayout];
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initForAutoLayout];
        _goodsNameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceLabel{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] initForAutoLayout];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:14];
        _goodsPriceLabel.textColor = UIColorFromRGB(0xfe5447);
    }
    return _goodsPriceLabel;
}

- (UILabel *)goodsShopLabel{
    if (!_goodsShopLabel) {
        _goodsShopLabel = [[UILabel alloc] initForAutoLayout];
        _goodsShopLabel.font = [UIFont systemFontOfSize:14];
        _goodsShopLabel.textColor = UIColorFromRGB(0xaaaaaa);
    }
    return _goodsShopLabel;
}

@end
