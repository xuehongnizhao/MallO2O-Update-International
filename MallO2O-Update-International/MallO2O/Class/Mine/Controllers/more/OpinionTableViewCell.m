//
//  OpinionTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OpinionTableViewCell.h"

@interface OpinionTableViewCell ()

@property (strong ,nonatomic) UILabel *opinionLabel;

@property (strong ,nonatomic) UILabel *timeLabel;

@property (strong ,nonatomic) UILabel *statusLabel;

@end

@implementation OpinionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"opinionCell";
    OpinionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OpinionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.opinionLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    [self settingAutoLayout];
}

- (void)settingAutoLayout{
    [_opinionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_opinionLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_opinionLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_opinionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    _opinionLabel.font = [UIFont systemFontOfSize:15];
    
    [_timeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
    [_timeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_timeLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_timeLabel autoSetDimension:ALDimensionWidth toSize:200];
    _timeLabel.font = [UIFont systemFontOfSize:15];
    _timeLabel.textColor = UIColorFromRGB(0x898989);
    
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
    [_statusLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_statusLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_statusLabel autoSetDimension:ALDimensionWidth toSize:100];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.font = [UIFont systemFontOfSize:15];
    _statusLabel.textColor = UIColorFromRGB(0x898989);
}

- (void)setModel:(OpinionModel *)model{
    _opinionLabel.text = model.opinionText;
    _timeLabel.text    = model.opinionTime;
    _statusLabel.text  = model.opinionStatus;
}

#pragma mark 初始化控件
- (UILabel *)opinionLabel{
    if (!_opinionLabel) {
        _opinionLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _opinionLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _statusLabel;
}

@end
