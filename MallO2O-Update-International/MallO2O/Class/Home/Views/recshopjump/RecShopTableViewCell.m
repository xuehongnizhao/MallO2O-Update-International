//
//  RecShopTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "RecShopTableViewCell.h"


@interface RecShopTableViewCell ()

@property (strong ,nonatomic) UIImageView *secondImgView;

@property (strong ,nonatomic) UILabel *secondNameLabel;

@property (strong ,nonatomic) UILabel *secondNowPriceLabel;

/** 距离 */
@property (nonatomic, strong) UILabel *distance;


@property (strong ,nonatomic) UIImageView *shopCarImage;

@property (strong ,nonatomic) UIImageView *carImgView;

@end

@implementation RecShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 cell重用
 */
+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"recCell";
    RecShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RecShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

/**
 初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

/**
 添加控件
 */
- (void)addUI{
    _secondImgView = [[UIImageView alloc] initForAutoLayout];
    _secondNameLabel = [[UILabel alloc] initForAutoLayout];
    _secondNowPriceLabel = [[UILabel alloc] initForAutoLayout];
//    _distance = [[UILabel alloc] initForAutoLayout];
    _carImgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_secondNameLabel];
    [self.contentView addSubview:_secondImgView];
    [self.contentView addSubview:_secondNowPriceLabel];
    [self.contentView addSubview:_carImgView];
//    [self.contentView addSubview:self.distance];
    [self settingAutoLayout];
}

/**
 自动布局
 */
- (void)settingAutoLayout{
    /*+++++商品图片的自动布局++++++*/
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11 * Balance_Heith];
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:11 * Balance_Width];
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:12 * Balance_Heith];
    [_secondImgView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_secondImgView];
    _secondImgView.layer.borderWidth = 0.7;
    _secondImgView.layer.borderColor = [UIColorFromRGB(0xd5d5d5) CGColor];
    
    /*+++++
     商品名字的自动布局
     ++++++*/
    [_secondNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:14 * Balance_Heith];
    [_secondNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondNameLabel autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    [_secondNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondNameLabel.font = [UIFont systemFontOfSize:14.0f];
    _secondNameLabel.textColor = UIColorFromRGB(0x444444);
    
    /*+++++
     商品现价的自动布局
     ++++++*/
    [_secondNowPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f * Balance_Heith];
    [_secondNowPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondNowPriceLabel autoSetDimension:ALDimensionHeight toSize:20.0f * Balance_Heith];
    [_secondNowPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40.0f];
    _secondNowPriceLabel.font = [UIFont systemFontOfSize:14];
    _secondNowPriceLabel.textColor = UIColorFromRGB(0xf47274);

    [_carImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_carImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:54.0f];
    [_carImgView autoSetDimension:ALDimensionHeight toSize:15 * Balance_Width];
    [_carImgView autoSetDimension:ALDimensionWidth toSize:18 * Balance_Width];
//    _carImgView.image = [UIImage imageNamed:@""];
    
//    [_distance autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
//    [_distance autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:54];
//    [_distance autoSetDimension:ALDimensionWidth toSize:18 * Balance_Width];
//    [_distance autoSetDimension:ALDimensionHeight toSize:15 * Balance_Width];
//    _distance.font = [UIFont systemFontOfSize:14];
//    _distance.textColor = UIColorFromRGB(0xf47274);
//    _distance.layer.borderWidth = 1;
    
    
}

/**
 模型的set方法
 */
- (void)setModel:(RecShopModel *)model{
    _model = model;
    [self setData];
}

/**
 cell的控件设置数据
 */
- (void)setData{
    [_secondImgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _distance.text = _model.distance;
    
    _secondNameLabel.text = _model.goods_name;
    _secondNowPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingString:_model.goods_price];
    NSLog(@"%@-%@-%@",_model.goods_name,_model.goods_price,_model.imgUrl);
}

@end
