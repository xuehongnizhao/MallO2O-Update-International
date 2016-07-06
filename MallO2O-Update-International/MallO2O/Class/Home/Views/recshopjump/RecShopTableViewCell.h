//
//  RecShopTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecShopTableViewCell.h"
#import "RecShopModel.h"

@interface RecShopTableViewCell : UITableViewCell

@property (strong ,nonatomic) RecShopModel *model;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
