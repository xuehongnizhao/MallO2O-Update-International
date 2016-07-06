//
//  MoreTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MoreTableViewCell.h"

@interface MoreTableViewCell ()

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel     *nameLabel;

@end

@implementation MoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"moreCell";
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorInset = UIEdgeInsetsMake(0, 45 * Balance_Width, 0, 0);
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
    
    [self settingAutoLayout];
}

- (void)settingAutoLayout{
    [_imgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15 * Balance_Width];
    [_imgView autoSetDimension:ALDimensionHeight toSize:18 * Balance_Heith];
    [_imgView autoSetDimension:ALDimensionWidth toSize:18 * Balance_Width];
    [_imgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgView withOffset:15];
    [_nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nameLabel autoSetDimension:ALDimensionWidth toSize:250];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:30];
    _nameLabel.font = [UIFont systemFontOfSize:14 * Balance_Width];
    _nameLabel.textColor = UIColorFromRGB(0x4e4e4e);
}

- (void)setNameText:(NSString *)nameText{
    _nameText = nameText;
    _nameLabel.text = _nameText;
}

- (void)setImgText:(NSString *)imgText{
    _imgText = imgText;
    _imgView.image = [UIImage imageNamed:_imgText];
}

@end
