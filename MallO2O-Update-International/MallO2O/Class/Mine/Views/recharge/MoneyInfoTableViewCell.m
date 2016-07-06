//
//  MoneyInfoTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "MoneyInfoTableViewCell.h"

@interface MoneyInfoTableViewCell ()

@property (strong ,nonatomic) UILabel *nowBalance;

@property (strong ,nonatomic) UILabel *nowBalanceMoney;

@property (strong ,nonatomic) UILabel *rechargeHistory;

@end

@implementation MoneyInfoTableViewCell

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
        [self settingAutoLayout];
        self.layer.borderColor = UIColorFromRGB(0xe3e3e3).CGColor;
        self.layer.borderWidth = 0.7;
    }
    return self;
}

+ (instancetype)moneyInfoTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)identifier{
    MoneyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MoneyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod hiddleExtendCellFromTableview:tableView];
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.nowBalance];
    [self.contentView addSubview:self.nowBalanceMoney];
    [self.contentView addSubview:self.rechargeHistory];
}

- (void)settingAutoLayout{
    [_nowBalance autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_nowBalance autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nowBalance autoSetDimension:ALDimensionHeight toSize:30];
    [_nowBalance sizeToFit];
    
    [_nowBalanceMoney autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nowBalance withOffset:0];
    [_nowBalanceMoney autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nowBalanceMoney autoSetDimension:ALDimensionHeight toSize:30];
    [_nowBalanceMoney autoSetDimension:ALDimensionWidth toSize:150];
    
    [_rechargeHistory autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_rechargeHistory autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_rechargeHistory autoSetDimension:ALDimensionHeight toSize:30];
    [_rechargeHistory autoSetDimension:ALDimensionWidth toSize:100];
}

- (UILabel *)nowBalance{
    if (!_nowBalance) {
        _nowBalance = [[UILabel alloc] initForAutoLayout];
        _nowBalance.text = @"当前余额：";
        _nowBalance.textColor = UIColorFromRGB(0x5f6366);
    }
    return _nowBalance;
}

- (UILabel *)nowBalanceMoney{
    if (!_nowBalanceMoney) {
        _nowBalanceMoney = [[UILabel alloc] initForAutoLayout];
        _nowBalanceMoney.textColor = UIColorFromRGB(0x636568);
    }
    return _nowBalanceMoney;
}

- (UILabel *)rechargeHistory{
    if (!_rechargeHistory) {
        _rechargeHistory = [[UILabel alloc] initForAutoLayout];
        _rechargeHistory.text = @"充值记录";
        _rechargeHistory.textColor = UIColorFromRGB(0xff4304);
    }
    return _rechargeHistory;
}

@end
