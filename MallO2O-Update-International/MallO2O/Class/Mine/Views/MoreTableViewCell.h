//
//  MoreTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) NSString *nameText;

@property (strong ,nonatomic) NSString *imgText;

@end
