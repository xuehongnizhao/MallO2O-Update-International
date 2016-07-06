//
//  PushOrderBTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushOrderBTableViewCell.h"

@interface PushOrderBTableViewCell ()



@end

@implementation PushOrderBTableViewCell{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index forCellReuseIdentifier:(NSString *)cellID {

    PushOrderBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PushOrderBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    if (index.section == 3) {
        NSArray *array = @[@"查看商品清单",@"运 费",@"",@"优 惠"];
        cell.typeNameArray = array[index.row];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initData];
        [self addUI];
        [self settingAutoLayout];
        [self sizeToFit];
    }
    return self;
}

- (void)initData{

}

- (void)addUI{
    [self.contentView addSubview:self.typeNameLabel];
    [self.contentView addSubview:self.typeDetailLabel];
}

- (void)setTypeNameArray:(NSString *)typeNameArray{
    if (typeNameArray) {
        _typeNameLabel.text = typeNameArray;
    }
}

- (void)settingAutoLayout{
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_typeNameLabel autoSetDimension:ALDimensionWidth toSize:200];
    _typeNameLabel.font = [UIFont systemFontOfSize:15];
    _typeNameLabel.textColor = UIColorFromRGB(0x838383);
    
//    [_typeDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_typeDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_typeDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_typeDetailLabel autoSetDimension:ALDimensionWidth toSize:100];
    _typeDetailLabel.font = [UIFont systemFontOfSize:15];
    _typeDetailLabel.textAlignment = NSTextAlignmentRight;
}

- (void)setDic:(NSMutableDictionary *)dic{
    _typeNameLabel.text = dic[@"typeName"];
    NSLog(@"%@",dic[@"typeName"]);
    if (dic[@"typeDetail"] != nil && ![dic[@"typeDetail"] isEqualToString:@""]) {
        if ([_typeNameLabel.text isEqualToString:@"查看商品清单"]) {
            [_typeDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
        }else{
            [_typeDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        }
        _typeDetailLabel.text = dic[@"typeDetail"];
    }
}

- (void)setModel:(OrderMarkModel *)model{
    [_typeNameLabel removeFromSuperview];
    _typeNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_typeNameLabel];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_typeNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    _typeNameLabel.font = [UIFont systemFontOfSize:15];
    _typeNameLabel.numberOfLines = 0;
    _typeNameLabel.textColor = UIColorFromRGB(0x838383);
    if (model.markTextString != nil && ![model.markTextString isEqualToString:@""]) {
        _typeNameLabel.text = model.markTextString;
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _typeNameLabel.text = NSLocalizedString(@"pushOrderCellPlaceholderNoteInformation", nil);
    }
}

#pragma mark 初始化控件
- (UILabel *)typeNameLabel{
    if (!_typeNameLabel) {
        _typeNameLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _typeNameLabel;
}

- (UILabel *)typeDetailLabel{
    if (!_typeDetailLabel) {
        _typeDetailLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _typeDetailLabel;
}

@end
