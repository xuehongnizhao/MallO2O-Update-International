//
//  MyOrderTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "MyOrderTimeModel.h"

@interface MyOrderTableViewCell ()

/**
 商品图片
 */
@property (strong ,nonatomic) UIImageView *goodsImgView;

/**
 商品名称
 */
@property (strong ,nonatomic) UILabel *goodsNameLabel;

/**
 商品数量
 */
@property (strong ,nonatomic) UILabel *goodsNumLabel;

/**
 商品总价
 */
@property (strong ,nonatomic) UILabel *totalMoneyLabel;

@property (strong ,nonatomic) UILabel *dateLabel;

@property (strong ,nonatomic) UILabel *statusLabel;

@end

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index{
    static NSString *identifier = @"myOrderCell";
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.goodsImgView];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.goodsNumLabel];
    [self.contentView addSubview:self.totalMoneyLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.statusLabel];
    UIView *xian = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:xian];
    xian.backgroundColor = UIColorFromRGB(0xaaaaaa);
    [xian autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [xian autoSetDimension:ALDimensionHeight toSize:0.6];
}

- (void)settingAutoLayout{
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_dateLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_dateLabel autoSetDimension:ALDimensionWidth toSize:250];
    _dateLabel.font = [UIFont systemFontOfSize:15];
    _dateLabel.textColor = UIColorFromRGB(0x606363);
    
    
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_statusLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_statusLabel autoSetDimension:ALDimensionWidth toSize:100];
    _statusLabel.font = [UIFont systemFontOfSize:15];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.textColor = UIColorFromRGB(0xe34a51);
    
    [_goodsImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_goodsImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:35];
    [_goodsImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_goodsImgView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_goodsImgView];
    _goodsImgView.layer.borderWidth = 0.7;
    _goodsImgView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    [_goodsNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsImgView withOffset:6];
    [_goodsNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    [_goodsNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_goodsNameLabel autoSetDimension:ALDimensionWidth toSize:200];
    _goodsNameLabel.font = [UIFont systemFontOfSize:15];
    _goodsNameLabel.textColor = UIColorFromRGB(0x444444);
    
    [_goodsNumLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsImgView withOffset:6];
    [_goodsNumLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_goodsNumLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_goodsNumLabel sizeToFit];
    _goodsNumLabel.font = [UIFont systemFontOfSize:15];
    _goodsNumLabel.textColor = UIColorFromRGB(0x606363);
    
    [_totalMoneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goodsNumLabel withOffset:3];
    [_totalMoneyLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_totalMoneyLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_totalMoneyLabel autoSetDimension:ALDimensionWidth toSize:150];
    _totalMoneyLabel.font = [UIFont systemFontOfSize:15];
    _totalMoneyLabel.textColor = UIColorFromRGB(0xe34a51);
}

#pragma mark 初始化控件
- (UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _goodsImgView;
}

- (UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsNumLabel{
    if (!_goodsNumLabel) {
        _goodsNumLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _goodsNumLabel;
}

- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalMoneyLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _dateLabel;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _statusLabel;
}

- (void)setModela:(MyOrderModel *)modela{
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:modela.goodsImg] placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = modela.goodsName;
//    [NSString stringWithFormat:@"%@%@%@  %@", modela.goodsNum, NSLocalizedString(@"TheNumberOf", nil), NSLocalizedString(@"Commodity", nil), NSLocalizedString(@"Total", nil)];
    _goodsNumLabel.text =  [NSString stringWithFormat:@"%@%@%@  %@", modela.goodsNum, NSLocalizedString(@"TheNumberOf", nil), NSLocalizedString(@"Commodity", nil), NSLocalizedString(@"Total", nil)];
//    _totalMoneyLabel.text = [NSString stringWithFormat:@"%@%@",modela.goodsMoney, NSLocalizedString(@"Money", nil)];//[@"￥" stringByAppendingString:modela.goodsMoney];
    _totalMoneyLabel.text = [NSString stringWithFormat:@"¥%@元", modela.goodsMoney];
}

- (void)setModelb:(MyOrderTimeModel *)modelb{
    NSLog(@"%@",modelb.dateString);
    _dateLabel.text = modelb.dateString;
    _statusLabel.text = modelb.statusString;
}

@end
