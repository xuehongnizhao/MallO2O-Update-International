//
//  SpecialCollectionViewCell.m
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SpecialCollectionViewCell.h"

@implementation SpecialCollectionViewCell

# pragma mark 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addUI];

//        self.layer.borderColor = [UIColorFromRGB(0xe5e5e5) CGColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark 自定义cell方法
+ (instancetype)cellOfCollectionView:(UICollectionView *)collection cellForRoAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"cell";
    SpecialCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:index];
    return cell;
}

- (void)addUI{
    /*
         添加专题页面的图片
     */
    _specialImgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_specialImgView];
    
    /*
     添加专题页面的原价label
     */
    _specialOldPriceLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_specialOldPriceLabel];
    
    /*
     添加专题页面的现价label
     */
    _specialPriceLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_specialPriceLabel];
    
    /*
     添加专题页面的商品名称label
     */
    _specialNameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_specialNameLabel];
    
    
}

- (void)setAutoLayout{
    /*
        设置专题页面的图片的自动布局
     */
    [_specialImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4 * Balance_Heith];
    [_specialImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:4 * Balance_Width];
    [_specialImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4 * Balance_Width];
    [_specialImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:42 * Balance_Heith];
    [_specialImgView setBackgroundColor:[UIColor lightGrayColor]];
//    _specialImgView.layer.borderWidth = 1;
//    _specialImgView.layer.borderColor = [UIColorFromRGB(0xd5d5d5) CGColor];
    
    /*
        设置专题页面的商品名称的自动布局
     */
    [_specialNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5 * Balance_Width];
    [_specialNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:23 * Balance_Heith];
    [_specialNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5 * Balance_Width];
    [_specialNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    _specialNameLabel.numberOfLines = 1;
    _specialNameLabel.font = [UIFont systemFontOfSize:15];
//    _specialNameLabel.layer.borderWidth = 0.5;
    _specialNameLabel.textColor = UIColorFromRGB(0x6f6f6f);
    
    /*
     设置专题页面的商品现价的自动布局
     */
    [_specialPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5 * Balance_Width];
    [_specialPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:4 * Balance_Heith];
//    [_specialPriceLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_specialPriceLabel sizeToFit];
//    _specialPriceLabel.layer.borderWidth = 0.5;
    _specialPriceLabel.textColor = UIColorFromRGB(0xf47274);
    _specialPriceLabel.font = [UIFont systemFontOfSize:14];
    
    /*
     设置专题页面的商品原价的自动布局
     */
    [_specialOldPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3 * Balance_Heith];
    [_specialOldPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_specialPriceLabel withOffset:4 * Balance_Width];
//    [_specialOldPriceLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_specialOldPriceLabel  sizeToFit];
//    _specialOldPriceLabel.layer.borderWidth = 0.5;
    _specialOldPriceLabel.font = [UIFont systemFontOfSize:13];
    _specialOldPriceLabel.textColor = UIColorFromRGB(0xaeaeae);
    
    UIView *view = [[UIView alloc] initForAutoLayout];
    [_specialOldPriceLabel addSubview:view];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [view autoSetDimension:ALDimensionHeight toSize:0.7];
    view.backgroundColor = UIColorFromRGB(0xaeaeae);
}

#pragma mark 重写model的set方法
- (void)setSpecialModel:(SpecialModel *)specialModel{
    _specialModel = specialModel;
    [self setData];
    [self setAutoLayout];
}

#pragma mark 为cell添加数据
- (void)setData{
//    NSLog(@"%@",_specialModel.specialImg);
    [_specialImgView sd_setImageWithURL:[NSURL URLWithString:_specialModel.specialImg] placeholderImage:[UZCommonMethod setImageFromColor:[UIColor lightGrayColor] viewWidth:_specialImgView.frame.size.width viewHeight:_specialImgView.frame.size.height]];
    _specialNameLabel.text =  _specialModel.specialName;
    
    _specialPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingString:_specialModel.specialPrice];
    _specialOldPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingString:_specialModel.specialOldPrice];
}


@end
