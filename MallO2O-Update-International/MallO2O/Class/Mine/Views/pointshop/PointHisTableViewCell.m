//
//  PointHisTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointHisTableViewCell.h"

@interface PointHisTableViewCell ()

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *detailLabel;

@property (strong ,nonatomic) UILabel *pointLabel;

@property (strong ,nonatomic) UILabel *statusLabel;

@end

@implementation PointHisTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"pointHisCell";
    PointHisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PointHisTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
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
    [_imgView autoSetDimension:ALDimensionWidth toSize:90 * Balance_Width];
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
    _detailLabel.textColor = UIColorFromRGB(0x969696);
    _detailLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     积分的自动布局
     ++++++*/
    [_pointLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 * Balance_Heith];
    [_pointLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    _pointLabel.textColor = UIColorFromRGB(0xff9900);
    _pointLabel.font = [UIFont systemFontOfSize:14];
    
    /*+++++
     兑换状态
     ++++++*/
    [_statusLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:5 * Balance_Width];
    [_statusLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_statusLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.font = [UIFont systemFontOfSize:14 ];
}

- (void)setModel:(PointHisModel *)model{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.goodsImgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.goodsName;
    _detailLabel.text = [@"数量：" stringByAppendingFormat:@"%@个",model.goodsNumber];
    _pointLabel.text = [@"兑换码：" stringByAppendingString:model.goodsCode];
    _statusLabel.text = model.goodsStatus;
    if ([model.goodsStatus isEqualToString:@"未完成"]) {
        _statusLabel.textColor = UIColorFromRGB(0x00aa00);
    }else{
        _statusLabel.textColor = UIColorFromRGB(0xe34a51);
    }
    
}

@end
