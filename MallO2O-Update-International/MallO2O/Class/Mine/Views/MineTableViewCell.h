//
//  MineTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/9.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineTableViewCell.h"

@interface MineTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *yueLabel;

@property (strong ,nonatomic) UILabel *moneyLabel;

@end
