//
//  SelectTypeTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectTypeTableViewCell.h"
#import "SelectTypeModel.h"

@interface SelectTypeTableViewCell : UITableViewCell

+(instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) SelectTypeModel *model;

@property (strong ,nonatomic) UILabel *typeLabel;

@property (strong ,nonatomic) UILabel *selectLabel;

@end
