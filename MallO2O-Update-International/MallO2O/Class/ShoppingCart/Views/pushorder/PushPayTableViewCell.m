//
//  PushPayTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushPayTableViewCell.h"

@interface PushPayTableViewCell ()

@property (strong ,nonatomic) UILabel *payNameLabel;

@property (strong ,nonatomic) UIImageView *paySelectImgView;

@property (strong ,nonatomic) UIImageView *payMarkImgView;

@end

@implementation PushPayTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setIsSelectImg:(BOOL)select andNameTypeString:(NSString *)string andMarkImg:(UIImage *)image{
    _payNameLabel.text = string;
    self.payMarkImgView.image = image;
    if (select) {
        _paySelectImgView.image = [UIImage imageNamed:@"address_sel"];
    }
    if (!select) {
        _paySelectImgView.image = [UIImage imageNamed:@"address_no"];
    }
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index{
    static NSString *identifier = @"pushPayCell";
    PushPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PushPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.payNameLabel];
    [self.contentView addSubview:self.paySelectImgView];
    [self.contentView addSubview:self.payMarkImgView];
}

- (void)settingAutoLayout{
    [_payMarkImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_payMarkImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_payMarkImgView autoSetDimension:ALDimensionHeight toSize:20];
    [_payMarkImgView autoSetDimension:ALDimensionWidth toSize:20];
    
    [_payNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [_payNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_payNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_payNameLabel autoSetDimension:ALDimensionWidth toSize:200];
    _payNameLabel.font = [UIFont systemFontOfSize:15];
    _payNameLabel.textColor = UIColorFromRGB(0x838383);
    
    [_paySelectImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_paySelectImgView autoSetDimension:ALDimensionHeight toSize:20];
    [_paySelectImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_paySelectImgView autoSetDimension:ALDimensionWidth toSize:20];
}

- (void)setPayString:(NSString *)payString{
    
}

#pragma mark 初始化控件
- (UILabel *)payNameLabel{
    if (!_payNameLabel) {
        _payNameLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _payNameLabel;
}

- (UIImageView *)paySelectImgView{
    if (!_paySelectImgView) {
        _paySelectImgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _paySelectImgView;
}

- (UIImageView *)payMarkImgView{
    if (!_payMarkImgView) {
        _payMarkImgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _payMarkImgView;
}

@end
