//
//  MiaoTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MiaoTableViewCell.h"


@interface MiaoTableViewCell ()



@property (strong ,nonatomic) UILabel *secondNameLabel;

@property (strong ,nonatomic) UILabel *secondOldPriceLabel;

@property (strong ,nonatomic) UILabel *secondNowPriceLabel;

@property (strong ,nonatomic) UILabel *secondTimeLabel;

@property (strong ,nonatomic) UILabel *secondPersonNumLabel;

@property (strong ,nonatomic) UILabel *secondShopLabel;

@property (strong ,nonatomic) UILabel *secondGradingLabel;


@end

@implementation MiaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self removeFromSuperview];
        [self initUI];
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

#pragma mark 初始化控件
- (void)initUI{
    _secondImgView = [[UIImageView alloc] initForAutoLayout];
    _secondNameLabel = [[UILabel alloc] initForAutoLayout];
    _secondNowPriceLabel = [[UILabel alloc] initForAutoLayout];
    _secondOldPriceLabel = [[UILabel alloc] initForAutoLayout];
    _secondTimeLabel = [[UILabel alloc] initForAutoLayout];
    _secondPersonNumLabel = [[UILabel alloc] initForAutoLayout];
    _secondShopLabel = [[UILabel alloc] initForAutoLayout];
    _secondGradingLabel = [[UILabel alloc] initForAutoLayout];
}

#pragma mark 添加控件
- (void)addUI{
    [self.contentView addSubview:_secondTimeLabel];
    [self.contentView addSubview:_secondOldPriceLabel];
    [self.contentView addSubview:_secondNowPriceLabel];
    [self.contentView addSubview:_secondNameLabel];
    [self.contentView addSubview:_secondImgView];
    [self.contentView addSubview:_secondPersonNumLabel];
    [self.contentView addSubview:_secondShopLabel];
    [self.contentView addSubview:_secondGradingLabel];
}

#pragma mark  设置自动布局
- (void)settingAutoLayout{
    /*+++++商品图片的自动布局++++++*/
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11];
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:11];
    [_secondImgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:12 * Balance_Heith];
    [_secondImgView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_secondImgView];
    _secondImgView.layer.borderWidth = 0.7;
    _secondImgView.layer.borderColor = [UIColorFromRGB(0xd5d5d5) CGColor];
    
    /*+++++
     商品名字的自动布局
     ++++++*/
    [_secondNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_secondNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondNameLabel autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    [_secondNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondNameLabel.font = [UIFont systemFontOfSize:15];
    _secondNameLabel.textColor = UIColorFromRGB(0x444444);
    
    /*+++++
     商品现价的自动布局
     ++++++*/
    [_secondNowPriceLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_secondNowPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondNowPriceLabel autoSetDimension:ALDimensionHeight toSize:20.0f * Balance_Heith];
    [_secondNowPriceLabel sizeToFit];
    _secondNowPriceLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _secondNowPriceLabel.textColor = UIColorFromRGB(0xf47274);
    _secondNowPriceLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     商品原价的自动布局
     ++++++*/
    [_secondOldPriceLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_secondOldPriceLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_secondOldPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondNowPriceLabel withOffset:5 * Balance_Width];
    [_secondOldPriceLabel sizeToFit];
    _secondOldPriceLabel.textColor = UIColorFromRGB(0xaeaeae);
    _secondOldPriceLabel.font = [UIFont systemFontOfSize:13];
    
    UIView *view = [[UIView alloc] initForAutoLayout];
    [_secondOldPriceLabel addSubview:view];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 * Balance_Heith];
    [view autoSetDimension:ALDimensionHeight toSize:0.7];
    view.backgroundColor = UIColorFromRGB(0xaeaeae);
    
    /*+++++
     团购人数的自动布局  没有的用不到
     ++++++*/
    [_secondPersonNumLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondPersonNumLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
    [_secondPersonNumLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_secondPersonNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondPersonNumLabel.textColor = UIColorFromRGB(0xaeaeae);
    _secondPersonNumLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     商品商家的自动布局
     ++++++*/
    [_secondShopLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondShopLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
    [_secondShopLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_secondShopLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondShopLabel.textColor = UIColorFromRGB(0xaeaeae);
    _secondShopLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     商品商家的自动布局
     ++++++*/
    [_secondTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:15 * Balance_Width];
    [_secondTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
    [_secondTimeLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_secondTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondTimeLabel.textColor = UIColorFromRGB(0x969595);
    _secondTimeLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     商品商家的自动布局
     ++++++*/
    [_secondGradingLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_secondImgView withOffset:5 * Balance_Width];
    [_secondGradingLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
    [_secondGradingLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_secondGradingLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _secondGradingLabel.textColor = UIColorFromRGB(0xaeaeae);
    _secondGradingLabel.font = [UIFont systemFontOfSize:14];
}

#pragma mark 自定义cell的初始化方法
+ (instancetype)secondeCellWithTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"secondCell";
    MiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    if (!cell) {
        cell = [[MiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

/**
 模型的set方法
 */
- (void)setSecondModel:(SecondModel *)secondModel{
    _secondModel = secondModel;
    [self setData];
}

/**
 设置数据
 */
- (void)setData{
    [_secondImgView sd_setImageWithURL:[NSURL URLWithString:_secondModel.secondImgUrlText] placeholderImage:[UIImage imageNamed:@""]];
    _secondNameLabel.text = _secondModel.secondTitleText;
    _secondNowPriceLabel.text = [NSLocalizedString(@"Money", nil) stringByAppendingFormat:@"%@",_secondModel.secondNowPriceText];
    _secondOldPriceLabel.text = [_secondModel.secondOldPriceText stringByAppendingFormat:@"元"];
    _secondPersonNumLabel.text = [_secondModel.secondPersonNum stringByAppendingFormat:@"%@",@"人团购"];
    _secondShopLabel.text = _secondModel.goods_detail;
    if (_secondModel.goods_detail == nil || [_secondModel.goods_detail isEqualToString:@""]) {
        _secondShopLabel.text = _secondModel.secondShopName;
    }
    _secondTimeLabel.text = _secondModel.secondTimeText;
    if (_secondTimeLabel.text != nil && ![_secondTimeLabel.text isEqualToString:@""]) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SK"]];
        imgView.frame = CGRectMake(-10, 5 * Balance_Heith, 10, 10);
        [_secondTimeLabel addSubview:imgView];
    }
    _secondGradingLabel.text = _secondModel.secondGrading;
}


@end
