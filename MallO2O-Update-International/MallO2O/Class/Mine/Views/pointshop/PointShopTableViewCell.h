//
//  PointShopTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointShopTableViewCell.h"
#import "PointShopModel.h"

@interface PointShopTableViewCell : UITableViewCell

@property (strong ,nonatomic) PointShopModel *model;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;

@end
