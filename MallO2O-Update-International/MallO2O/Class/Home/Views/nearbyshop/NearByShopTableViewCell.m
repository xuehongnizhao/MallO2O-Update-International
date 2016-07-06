//
//  NearByShopTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "NearByShopTableViewCell.h"

@interface NearByShopTableViewCell ()

@property (strong ,nonatomic) UIImageView *shopImgView;

@property (strong ,nonatomic) UILabel *shopNameLabel;

@property (strong ,nonatomic) UILabel *shopDetailLabel;

@property (strong ,nonatomic) UILabel *distance;

@end

@implementation NearByShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"nearByShop";
    NearByShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NearByShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

#pragma mark 添加cell内的控件
- (void)addUI{
    _shopImgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_shopImgView];
    _shopDetailLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_shopDetailLabel];
    _shopNameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_shopNameLabel];
    _distance = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_distance];
    [self settingAutoLayout];
}

/**
 *  设置控件的自动布局
 */
- (void)settingAutoLayout{
    [_shopImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12.0f * Balance_Width];
    [_shopImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12 * Balance_Heith];
    [_shopImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12 * Balance_Heith];
    [_shopImgView autoSetDimension:ALDimensionWidth toSize:90 * Balance_Heith];
    
    /*+++++
     商品名字的自动布局
     ++++++*/
    [_shopNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10 * Balance_Heith];
    [_shopNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shopImgView withOffset:5 * Balance_Width];
    [_shopNameLabel autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    [_shopNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 * Balance_Width];
    
    /*+++++
     商品现价的自动布局
     ++++++*/
    [_shopDetailLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_shopDetailLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shopNameLabel withOffset:5 * Balance_Width];
    [_shopDetailLabel autoSetDimension:ALDimensionHeight toSize:50.0f * Balance_Heith];
    [_shopDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
    _shopDetailLabel.numberOfLines = 0;
    _shopDetailLabel.textColor = UIColorFromRGB(0xaeaeae);
    
    [_distance autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5 * Balance_Heith];
    [_distance autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_distance autoSetDimension:ALDimensionHeight toSize:20];
    [_distance autoSetDimension:ALDimensionWidth toSize:100];
    _distance.textAlignment = NSTextAlignmentRight;
}

@end
