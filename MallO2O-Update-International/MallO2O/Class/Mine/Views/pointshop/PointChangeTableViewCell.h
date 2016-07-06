//
//  PointChangeTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointChangeTableViewCell.h"

@interface PointChangeTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (copy ,nonatomic) NSString *goodsName;

@property (copy ,nonatomic) NSString *goodsMuch;

@end
