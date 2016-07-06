//
//  OrderGradingTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OrderGradingTableViewCell.h"

@implementation OrderGradingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"";
    OrderGradingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderGradingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}


- (void)setOrderModel:(OrderGradingModel *)orderModel{
    NSLog(@"%@",orderModel.goodsName);
    self.textLabel.text = orderModel.goodsName;
}

@end
