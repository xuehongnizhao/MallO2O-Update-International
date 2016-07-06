//
//  PointShopTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointShopTableViewCell.h"

@interface PointShopTableViewCell ()

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *detailLabel;

@property (strong ,nonatomic) UILabel *pointLabel;

@property (strong ,nonatomic) UILabel *statusLabel;

@end

@implementation PointShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index{
    static NSString *identifier = @"pointCell";
    PointShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PointShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    _imgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_imgView];
    
    _nameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_detailLabel];
    
    _pointLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_pointLabel];
    
    _statusLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_statusLabel];
    
    [self settingAutoLayout];
}

- (void)settingAutoLayout{
    /*+++++商品图片的自动布局++++++*/
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11 * Balance_Heith];
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:11 * Balance_Width];
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:12 * Balance_Heith];
    [_imgView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_imgView];
    _imgView.layer.borderWidth = 0.7;
    _imgView.layer.borderColor = [UIColorFromRGB(0xd5d5d5) CGColor];
    
    /*+++++
     商品名字的自动布局
     ++++++*/
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7 * Balance_Heith];
    [_nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    
    /*+++++
     商品现价的自动布局
     ++++++*/
    [_detailLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_detailLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_detailLabel autoSetDimension:ALDimensionHeight toSize:20.0f * Balance_Heith];
    [_detailLabel sizeToFit];
    _detailLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _detailLabel.textColor = UIColorFromRGB(0xaeaeae);
    _detailLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     积分的自动布局
     ++++++*/
    [_pointLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 * Balance_Heith];
    [_pointLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _pointLabel.textColor = UIColorFromRGB(0xf47274);
    _pointLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     兑换状态
     ++++++*/
    [_statusLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 * Balance_Heith];
    [_statusLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _statusLabel.textColor = UIColorFromRGB(0xaeaeae);
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setModel:(PointShopModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = _model.nameText;
    _detailLabel.text = _model.detailText;
    _pointLabel.text = [_model.pointText stringByAppendingString:@"积分"];
    _statusLabel.text = _model.statusText;
    if ([_statusLabel.text isEqualToString:@"可兑换"]) {
        _statusLabel.textColor = UIColorFromRGB(0x00b0c2);
    }
}

@end
