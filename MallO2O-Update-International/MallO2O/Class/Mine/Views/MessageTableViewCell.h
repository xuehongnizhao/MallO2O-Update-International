//
//  MessageTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell

@property (strong ,nonatomic) MessageModel *model;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
