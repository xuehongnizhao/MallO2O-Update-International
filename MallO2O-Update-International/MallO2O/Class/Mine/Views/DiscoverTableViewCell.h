//
//  DiscoverTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *nameLabel;


@end
