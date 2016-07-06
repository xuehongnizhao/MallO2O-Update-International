//
//  OpinionTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpinionTableViewCell.h"
#import "OpinionModel.h"

@interface OpinionTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) OpinionModel *model;

@end
