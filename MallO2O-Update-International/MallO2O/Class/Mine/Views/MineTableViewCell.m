//
//  MineTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()



@end

@implementation MineTableViewCell

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
    static NSString *identifier = @"mineCell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (index.section == 0 || index.section == 1 || index.section == 2) {
        [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    }
    tableView.separatorInset = UIEdgeInsetsMake(0, 45 * Balance_Width, 0, 0);
    return cell;
}

#pragma mrak 添加控件
- (void)addUI{
    _imgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_imgView];

    _nameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_nameLabel];
    
    _yueLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_yueLabel];
    
    _moneyLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_moneyLabel];
    
    [self settingAutoLayout];
}

#pragma mark 自动布局
- (void)settingAutoLayout{
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15 * Balance_Width];
    [_imgView autoSetDimension:ALDimensionHeight toSize:18 * Balance_Heith];
    [_imgView autoSetDimension:ALDimensionWidth toSize:18 * Balance_Width];
    [_imgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    _imgView.layer.borderWidth = 1;
    
    [_nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:15];
    [_nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nameLabel autoSetDimension:ALDimensionWidth toSize:250];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:30];
    _nameLabel.textColor = UIColorFromRGB(0x606060);
    _nameLabel.font = [UIFont systemFontOfSize:16];
//    _nameLabel.layer.borderWidth = 1;
    
    [_moneyLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [_moneyLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_moneyLabel autoSetDimension:ALDimensionHeight toSize:25];
    [_moneyLabel sizeToFit];
    _moneyLabel.font = [UIFont systemFontOfSize:16];
    _moneyLabel.textColor = UIColorFromRGB(0xf95949);
    
    [_yueLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_moneyLabel withOffset:-7];
    [_yueLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_yueLabel autoSetDimension:ALDimensionHeight toSize:25];
    [_yueLabel sizeToFit];
    _yueLabel.font = [UIFont systemFontOfSize:16];
    _yueLabel.textColor = UIColorFromRGB(0x606060);
}

@end
