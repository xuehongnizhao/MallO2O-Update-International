//
//  RecommendTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    _recImgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_recImgView];
    
    _recTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_recTitleLabel];
    
    _recContentLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_recContentLabel];
    
    _distance = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:self.distance];
    
    [self setAutoLayout];
}

- (void)setAutoLayout{
    [_recImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12 * Balance_Heith];
    [_recImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12 * Balance_Width];
    [_recImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 * Balance_Heith];
    [_recImgView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_recImgView];
    _recImgView.layer.borderWidth = 0.7;
    _recImgView.layer.borderColor = [UIColorFromRGB(0xcccccc) CGColor];
    
    [_recTitleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_recImgView withOffset:5 * Balance_Width];
    [_recTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12.0f * Balance_Heith];
    [_recTitleLabel autoSetDimension:ALDimensionWidth toSize:150 * Balance_Width];
    [_recTitleLabel autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    //======设置属性//
    _recTitleLabel.numberOfLines = 1;
//    _recTitleLabel.layer.borderWidth = 1;
    _recTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    _recTitleLabel.textColor = UIColorFromRGB(0x444444);
    //设置属性======//
    
    [_recContentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_recTitleLabel withOffset:5 * Balance_Heith];
    [_recContentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_recImgView withOffset:5 * Balance_Width];
    [_recContentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7 * Balance_Heith];
    [_recContentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60 * Balance_Width];
    
    [_distance autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7 * Balance_Heith];
    [_distance autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:15];
    [_distance autoSetDimension:ALDimensionWidth toSize:100];
    [_distance autoSetDimension:ALDimensionHeight toSize:20];
    
    //======设置属性//
    _recContentLabel.numberOfLines = 2;
//    _recContentLabel.layer.borderWidth = 1;
    _recContentLabel.font = [UIFont systemFontOfSize:13.0f];
    _recContentLabel.textColor = UIColorFromRGB(0x989898);
    
    _distance.textAlignment = NSTextAlignmentRight;
    _distance.font = [UIFont systemFontOfSize:13];
    _distance.textColor = UIColorFromRGB(0x989898);
    //设置属性======//
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index{
    static NSString *identifier = @"RecCell";
    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)setListModel:(HomeListModel *)listModel{
    _listModel = listModel;
    [self setData];
}

- (void)setData{
    [self.recImgView sd_setImageWithURL:[NSURL URLWithString:_listModel.shopImg] placeholderImage:[UIImage imageNamed:@""]];
    self.recTitleLabel.text = _listModel.shopName ;
    self.recContentLabel.text = _listModel.shopAddress;
    self.distance.text = _listModel.distance;
}

@end
