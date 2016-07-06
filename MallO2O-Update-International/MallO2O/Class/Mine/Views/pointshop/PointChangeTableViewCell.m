//
//  PointChangeTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointChangeTableViewCell.h"

@interface PointChangeTableViewCell ()

@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *pointNumLabel;

@end

@implementation PointChangeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"pointCell";
    PointChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PointChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    _nameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_nameLabel];
    
    _pointNumLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_pointNumLabel];
    [self settingAutoLayout];
}

- (void)settingAutoLayout{
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:25];
    [_nameLabel autoSetDimension:ALDimensionWidth toSize:200];
    
    [_pointNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_pointNumLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_pointNumLabel autoSetDimension:ALDimensionHeight toSize:25];
    [_pointNumLabel autoSetDimension:ALDimensionWidth toSize:150];
    _pointNumLabel.textAlignment = NSTextAlignmentRight;
    _pointNumLabel.textColor = UIColorFromRGB(0x0bafd4);
}

- (void)setGoodsName:(NSString *)goodsName{
    _nameLabel.text = goodsName;
}

- (void)setGoodsMuch:(NSString *)goodsMuch{
    _pointNumLabel.text = goodsMuch;
}

@end
