//
//  SelectTypeTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SelectTypeTableViewCell.h"

@interface SelectTypeTableViewCell ()



@end

@implementation SelectTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

#pragma mark 自定义方法 cell的复用
+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"selectCell";
    SelectTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SelectTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)addUI{
    //移除上一个视图的iamgeview
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];
        //删除并进行重新分配
    }
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 38)];
    _typeLabel.textAlignment = NSTextAlignmentLeft;
//    _typeLabel.layer.borderWidth = 1;;
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_typeLabel];
    
    _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 5, 115, 38)];
    _selectLabel.textAlignment = NSTextAlignmentRight;
//    _selectLabel.layer.borderWidth = 1;
    _selectLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_selectLabel];
}

/**
 模型set方法
 */
- (void)setModel:(SelectTypeModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    _selectLabel.text = _model.allText;
    _typeLabel.text = _model.gcateSpecName;
}

@end
