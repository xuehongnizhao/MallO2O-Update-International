//
//  DiscoverTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "DiscoverTableViewCell.h"

@implementation DiscoverTableViewCell

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
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    [self settingAutoLayout];
}

#pragma mark 自动布局
- (void)settingAutoLayout{
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15 * Balance_Width];
    [_imgView autoSetDimension:ALDimensionHeight toSize:24 * Balance_Heith];
    [_imgView autoSetDimension:ALDimensionWidth toSize:24 * Balance_Width];
    [_imgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    //    _imgView.layer.borderWidth = 1;
    
    [_nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:15];
    [_nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nameLabel autoSetDimension:ALDimensionWidth toSize:250];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:30];
    _nameLabel.textColor = UIColorFromRGB(0x606060);
    _nameLabel.font = [UIFont systemFontOfSize:17];
    //    _nameLabel.layer.borderWidth = 1;
}

@end
