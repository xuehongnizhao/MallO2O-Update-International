//
//  CateTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateTableViewCell.h"

@interface CateTableViewCell ()

@property (strong ,nonatomic) UILabel *cateNameLabel;

@property (strong ,nonatomic) UIView *redLineView;

@end

@implementation CateTableViewCell{
    UIView *xian;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)selectIndex:(NSInteger)index{
    if (index == _selectIndex) {
        self.backgroundColor = UIColorFromRGB(0xf3f4f6);
        _cateNameLabel.textColor = UIColorFromRGB(0xe34a51);
        xian.hidden = YES;
        _redLineView.hidden = NO;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        _cateNameLabel.textColor = [UIColor blackColor];
        xian.hidden = NO;
        _redLineView.hidden = YES;
    }
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"cateCell";
    CateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    _cateNameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_cateNameLabel];
    
    /*--------设置控件的自动布局--------*/
    [_cateNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [_cateNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_cateNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_cateNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    _cateNameLabel.textAlignment = NSTextAlignmentCenter;
    _cateNameLabel.font = [UIFont systemFontOfSize:14];
    _cateNameLabel.numberOfLines = 0;
    
    xian = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:xian];
    [xian autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeft];
    [xian autoSetDimension:ALDimensionWidth toSize:0.6];
    xian.backgroundColor = UIColorFromRGB(0xd4d4d4);
    
    _redLineView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:self.redLineView];
    _redLineView.backgroundColor = UIColorFromRGB(0xeb4c62);
    [_redLineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [_redLineView autoSetDimension:ALDimensionWidth toSize:3];
}

- (void)setModel:(TabCateModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    _cateNameLabel.text = _model.cate_name;
}

@end
