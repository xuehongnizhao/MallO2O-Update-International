//
//  MessageTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *contentLabel;

@property (strong ,nonatomic) UILabel *timeLabel;

@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 cell的初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

/**
 cell的复用
 */
+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"messageCell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
}

/**
 自动布局
 */
- (void)settingAutoLayout{
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_nameLabel autoSetDimension:ALDimensionWidth toSize:100];
    [UZCommonMethod settingLabel:_nameLabel labelColor:UIColorFromRGB(0x444444) labelFont:14 lbelXian:NO];
//    _nameLabel.layer.borderWidth = 1;
    
    [_timeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_timeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameLabel withOffset:20];
    [_timeLabel autoSetDimension:ALDimensionHeight toSize:20];
    [UZCommonMethod settingLabel:_timeLabel labelColor:UIColorFromRGB(0x9b9a9a) labelFont:13 lbelXian:NO];
    _timeLabel.textAlignment = NSTextAlignmentRight;
//    _timeLabel.layer.borderWidth = 1;
    
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_contentLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [UZCommonMethod settingLabel:_contentLabel labelColor:UIColorFromRGB(0x444444) labelFont:13 lbelXian:NO];
//    _contentLabel.layer.borderWidth = 1;
}

/**
 模型的set方法  赋值
 */
- (void)setModel:(MessageModel *)model{
    _contentLabel.text = model.message_content;
    _timeLabel.text = model.message_addtime;
    _nameLabel.text = model.message_name;
}

/**
 控件懒加载
 */
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _timeLabel;
}

@end
