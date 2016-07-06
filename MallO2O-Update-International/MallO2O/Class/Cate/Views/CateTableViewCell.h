//
//  CateTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateTableViewCell.h"
#import "TabCateModel.h"

@interface CateTableViewCell : UITableViewCell

@property (strong ,nonatomic) TabCateModel *model;

@property (nonatomic) NSInteger selectIndex;

- (void)selectIndex:(NSInteger)index;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
