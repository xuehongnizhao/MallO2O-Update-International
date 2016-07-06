//
//  AddressControlTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AddressControlTableViewCell.h"

@interface AddressControlTableViewCell ()

@property (strong ,nonatomic) UILabel *addressLabel;

@property (strong ,nonatomic) UILabel *userNameLabel;

@property (strong ,nonatomic) UILabel *userTelLabel;

@property (strong ,nonatomic) UILabel *addressDetail;

@property (strong ,nonatomic) UILabel *userNameDetail;

@property (strong ,nonatomic) UILabel *userTelDetail;


@end

@implementation AddressControlTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellOfSelect:(BOOL)isSelect{
    if (isSelect) {
        _selectImgView.image = [UIImage imageNamed:@"address_sel"];
    }else{
        _selectImgView.image = [UIImage imageNamed:@"address_no"];
    }
}

/**
    重写cell的初始化
 */
+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"addressCell";
    AddressControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddressControlTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

/**
    初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

/**
    添加控件
 */
- (void)addUI{
    [self.contentView addSubview:self.addressDetail ];
    [self.contentView addSubview:self.addressLabel  ];
    [self.contentView addSubview:self.userNameDetail];
    [self.contentView addSubview:self.userNameLabel ];
    [self.contentView addSubview:self.userTelDetail ];
    [self.contentView addSubview:self.userTelLabel  ];
    [self.contentView addSubview:self.selectImgView ];
}

/**
    自动布局
 */
- (void)settingAutoLayout{
    [_addressLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_addressLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [_addressLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_addressLabel autoSetDimension:ALDimensionWidth toSize:69];
    _addressLabel.text = NSLocalizedString(@"adressDetailCellAddressTitle", nil);
    
    [_addressDetail autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_addressLabel withOffset:3];
    [_addressDetail autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_addressDetail autoSetDimension:ALDimensionHeight toSize:20];
    [_addressDetail autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    _addressDetail.textColor = UIColorFromRGB(0x898989);
//    _addressDetail.numberOfLines = 2;

    [_userNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [_userNameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_userNameLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_userNameLabel sizeToFit];
    _userNameLabel.text = NSLocalizedString(@"adressDetailCellConsigneeTitle", nil);

    [_userNameDetail autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_userNameLabel withOffset:3];
    [_userNameDetail autoSetDimension:ALDimensionHeight toSize:20];
    [_userNameDetail autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_userNameDetail autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    _userNameDetail.textColor = UIColorFromRGB(0x898989);

    [_userTelLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_userTelLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [_userTelLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_userTelLabel sizeToFit];
    _userTelLabel.text = @"电话号：";
    
    [_userTelDetail autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_userTelLabel withOffset:3];
    [_userTelDetail autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_userTelDetail autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_userTelDetail autoSetDimension:ALDimensionHeight toSize:20];
    _userTelDetail.textColor = UIColorFromRGB(0x898989);
    
    [_selectImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_selectImgView autoSetDimension:ALDimensionWidth toSize:20 * Balance_Width];
    [_selectImgView autoSetDimension:ALDimensionHeight toSize:20 * Balance_Width];
    [_selectImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
}

#pragma mark 添加数据
- (void)setModel:(AddressControlModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    _addressDetail.text = _model.addressString;
    _userTelDetail.text = _model.telString;
    _userNameDetail.text = _model.consigneeString;
    if ([_model.typeString integerValue] == 1) {
        _selectImgView.image = [UIImage imageNamed:@"address_sel"];
    }else{
        _selectImgView.image = [UIImage imageNamed:@"address_no"];
    }
}


#pragma mark 控件初始化
- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _addressLabel;
}

- (UILabel *)addressDetail{
    if (!_addressDetail) {
        _addressDetail  = [[UILabel alloc] initForAutoLayout];
    }
    return _addressDetail;
}

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel  = [[UILabel alloc] initForAutoLayout];
    }
    return _userNameLabel;
}

- (UILabel *)userNameDetail{
    if (_userNameDetail == nil) {
        _userNameDetail = [[UILabel alloc] initForAutoLayout];
    }
    return _userNameDetail;
}

- (UILabel *)userTelLabel{
    if (!_userTelLabel) {
        _userTelLabel   = [[UILabel alloc] initForAutoLayout];
    }
    return _userTelLabel;
}

- (UILabel *)userTelDetail{
    if (!_userTelDetail) {
        _userTelDetail  = [[UILabel alloc] initForAutoLayout];
    }
    return _userTelDetail;
}

- (UIImageView *)selectImgView{
    if (!_selectImgView) {
        _selectImgView  = [[UIImageView alloc] initForAutoLayout];
    }
    return _selectImgView;
}

@end
