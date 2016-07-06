//
//  OrderGradingTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGradingTableViewCell.h"
#import "OrderGradingModel.h"

@interface OrderGradingTableViewCell : UITableViewCell

@property (strong ,nonatomic) OrderGradingModel *orderModel;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
