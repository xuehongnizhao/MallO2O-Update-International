//
//  MyOrderTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
#import "MyOrderTimeModel.h"

@interface MyOrderTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;

@property (strong ,nonatomic) MyOrderModel *modela;

@property (strong ,nonatomic) MyOrderTimeModel *modelb;

@end
