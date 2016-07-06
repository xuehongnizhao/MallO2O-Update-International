//
//  TeamBuyCollectionViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/20.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "TeamBuyCollectionViewCell.h"
#import "SecondModel.h"

@interface TeamBuyCollectionViewCell ()

@property (strong ,nonatomic) UIImageView *goodsImage;

@property (strong ,nonatomic) UILabel *goodsNameLabel;

@property (strong ,nonatomic) UILabel *oldPriceLabel;

@property (strong ,nonatomic) UILabel *nowPriceLabel;

@property (strong ,nonatomic) UILabel *sellNumLabel;

@property (strong ,nonatomic) UIButton *getButton;

@end

@implementation TeamBuyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.borderWidth = 0.7;
//        self.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    }
    return self;
}

+ (instancetype)secondGoodsCollection:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellID{
    TeamBuyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)layoutSubviews{
    [self settingAutoLayout];
}

- (void)addUI{
    [self.contentView addSubview:self.goodsImage];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.oldPriceLabel];
    [self.contentView addSubview:self.nowPriceLabel];
    [self.contentView addSubview:self.sellNumLabel];
//    [self.contentView addSubview:self.getButton];
}

- (void)settingAutoLayout{
    [_goodsImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_goodsImage autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:_goodsImage];
    
    [_goodsNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsImage withOffset:0];
    [_goodsNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_goodsNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:3];
    [_goodsNameLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    
    [_nowPriceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsNameLabel withOffset:3];
    [_nowPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_nowPriceLabel autoSetDimension:ALDimensionHeight toSize:17 * Balance_Heith];
    [_nowPriceLabel sizeToFit];
    
    [_oldPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nowPriceLabel withOffset:2];
    [_oldPriceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsNameLabel withOffset:5 * Balance_Heith];
    [_oldPriceLabel autoSetDimension:ALDimensionHeight toSize:17 * Balance_Heith];
    [_oldPriceLabel sizeToFit];
    UIView *xian = [[UIView alloc] initForAutoLayout];
    [_oldPriceLabel addSubview:xian];
    [xian autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [xian autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [xian autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6.5 * Balance_Heith];
    [xian autoSetDimension:ALDimensionHeight toSize:1];
    xian.backgroundColor = _oldPriceLabel.textColor;
    
    [_sellNumLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_oldPriceLabel withOffset:1];
    [_sellNumLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_sellNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_sellNumLabel autoSetDimension:ALDimensionHeight toSize:17 * Balance_Heith];
    
    [_getButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];
    [_getButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [_getButton autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_getButton autoSetDimension:ALDimensionWidth toSize:50 * Balance_Width];
}

- (void)setModel:(SecondModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:_model.secondImgUrlText] placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = _model.secondTitleText;
    _nowPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingFormat:@"%@",_model.secondNowPriceText];
    _oldPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingFormat:@"%@",_model.secondOldPriceText];
    _sellNumLabel.text = [NSLocalizedString(@"cateJumpSoldTitle", nil) stringByAppendingString:_model.saleNum];
//    _sellNumLabel.text = @"已售559";
}


- (UIImageView *)goodsImage{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] initForAutoLayout];
//        _goodsImage.layer.borderWidth = 0.7;
//        _goodsImage.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    }
    return _goodsImage;
}

- (UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initForAutoLayout];
        _goodsNameLabel.textColor = UIColorFromRGB(0x5d5d5d);
        _goodsNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _goodsNameLabel;
}

- (UILabel *)oldPriceLabel{
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] initForAutoLayout];
        _oldPriceLabel.textColor = UIColorFromRGB(0xaeaeae);
        _oldPriceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _oldPriceLabel;
}

- (UILabel *)nowPriceLabel{
    if (!_nowPriceLabel) {
        _nowPriceLabel = [[UILabel alloc] initForAutoLayout];
        _nowPriceLabel.textColor = UIColorFromRGB(0xff444b);
        _nowPriceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nowPriceLabel;
}



- (UILabel *)sellNumLabel{
    if (!_sellNumLabel) {
        _sellNumLabel = [[UILabel alloc] initForAutoLayout];
        _sellNumLabel.textColor = UIColorFromRGB(0x474747);
        _sellNumLabel.font = [UIFont systemFontOfSize:13];
//        _sellNumLabel.layer.borderWidth = 1;
    }
    return _sellNumLabel;
}

- (UIButton *)getButton{
    if (!_getButton) {
        _getButton = [[UIButton alloc] initForAutoLayout];
        [_getButton setBackgroundColor:UIColorFromRGB(0xff4550)];
        _getButton.layer.cornerRadius = 4;
        _getButton.layer.masksToBounds = YES;
        [_getButton setTitle:@"马上抢" forState:UIControlStateNormal];
        [_getButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _getButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _getButton;
}

@end
