//
//  RechargeTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/20.
//  Copyright © 2015年 songweipng. All rights reserved.
//
#import "RechargeModel.h"
#import "RechargeTableViewCell.h"

@interface RechargeTableViewCell ()

@property (strong ,nonatomic) UILabel *rechargeMoney;

@property (strong ,nonatomic) UILabel *getMoney;

@property (strong ,nonatomic) UIImageView *selectedImage;

@end

@implementation RechargeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)selectImage:(BOOL)selecImage{
    if (selecImage) {
        _selectedImage.image = [UIImage imageNamed:@"address_sel"];
    }else{
        _selectedImage.image = [UIImage imageNamed:@"address_no"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
        self.layer.borderWidth = 0.7;
        self.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    }
    return self;
}

+ (instancetype)rechargeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)identifier{
    RechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[RechargeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [UZCommonMethod hiddleExtendCellFromTableview:tableView];
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.selected = YES;
    }
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.rechargeMoney];
    [self.contentView addSubview:self.getMoney];
    [self.contentView addSubview:self.selectedImage];
}

- (void)settingAutoLayout{
    [_rechargeMoney autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_rechargeMoney autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_rechargeMoney autoSetDimension:ALDimensionHeight toSize:40];
    [_rechargeMoney sizeToFit];
    
    [_getMoney autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_rechargeMoney withOffset:10];
    [_getMoney autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_getMoney autoSetDimension:ALDimensionHeight toSize:40];
    [_getMoney autoSetDimension:ALDimensionWidth toSize:150];
    
    [_selectedImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_selectedImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_selectedImage autoSetDimension:ALDimensionWidth toSize:20];
    [_selectedImage autoSetDimension:ALDimensionHeight toSize:20];
}

- (void)setModel:(RechargeModel *)model{
    _model = model;
    _getMoney.text = [@"售价：" stringByAppendingString:model.pushMoney];
    _rechargeMoney.text = model.getMoney;
}

- (UILabel *)rechargeMoney{
    if (!_rechargeMoney) {
        _rechargeMoney = [[UILabel alloc] initForAutoLayout];
        _rechargeMoney.textColor = UIColorFromRGB(0x3c3c3c);
        _rechargeMoney.font = [UIFont systemFontOfSize:15];
    }
    return _rechargeMoney;
}

- (UILabel *)getMoney{
    if (!_getMoney) {
        _getMoney = [[UILabel alloc] initForAutoLayout];
        _getMoney.textColor = UIColorFromRGB(0xea4d06);
        _getMoney.font = [UIFont systemFontOfSize:14];
    }
    return _getMoney;
}

- (UIImageView *)selectedImage{
    if (!_selectedImage) {
        _selectedImage = [[UIImageView alloc] initForAutoLayout];
    }
    return _selectedImage;
}

@end
