//
//  PushOrderBTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushOrderBTableViewCell.h"
#import "OrderMarkModel.h"

@interface PushOrderBTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index forCellReuseIdentifier:(NSString *)cellID;

@property (strong ,nonatomic) NSMutableDictionary *dic;

@property (strong ,nonatomic) NSString *typeNameArray;

@property (strong ,nonatomic) UILabel *typeNameLabel;

@property (strong ,nonatomic) UILabel *typeDetailLabel;

@property (strong ,nonatomic) OrderMarkModel *model;

@end
