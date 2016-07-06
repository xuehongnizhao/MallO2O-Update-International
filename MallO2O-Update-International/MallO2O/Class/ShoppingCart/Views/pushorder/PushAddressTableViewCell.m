//
//  PushAddressTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushAddressTableViewCell.h"

@interface PushAddressTableViewCell ()

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *addressLabel;

@property (strong ,nonatomic) UILabel *personInfoLabel;

@end

@implementation PushAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTabelView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"pushAddCell";
    PushAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PushAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.personInfoLabel];
}

- (void)settingAutoLayout{
    
    [_imgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(18, 10, 21, 0) excludingEdge:ALEdgeRight];
    [_imgView autoSetDimension:ALDimensionWidth toSize:15];
    _imgView.image = [UIImage imageNamed:@"address_mapview"];
    
    [_addressLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_addressLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [_addressLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_addressLabel autoSetDimension:ALDimensionHeight toSize:15];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    
    [_personInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_addressLabel withOffset:5];
    [_personInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [_personInfoLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_personInfoLabel autoSetDimension:ALDimensionHeight toSize:20];
    _personInfoLabel.font = [UIFont systemFontOfSize:15];
    _personInfoLabel.textColor = UIColorFromRGB(0x838383);
}

- (void)setDict:(NSDictionary *)dict{
    if (dict != nil) {
        _addressLabel.text = dict[@"address"];
        _personInfoLabel.text = [dict[@"consignee"] stringByAppendingFormat:@",%@",dict[@"phone_tel"]];
        self.textLabel.text = @"";
    }else{
//        _addressLabel.text = @"请输入收货地址";
//        _personInfoLabel.text = @"";
        _addressLabel.text = @"";
        _personInfoLabel.text = @"";
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = UIColorFromRGB(0x333333);
        self.textLabel.text = @"    请输入收货地址";
    }
    
}

#pragma mark 初始化控件
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _imgView;
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _addressLabel;
}

- (UILabel *)personInfoLabel{
    if (!_personInfoLabel) {
        _personInfoLabel = [[UILabel alloc] initForAutoLayout];
    }
    return  _personInfoLabel;
}

@end
