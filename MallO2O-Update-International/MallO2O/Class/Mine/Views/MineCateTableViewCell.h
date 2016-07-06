//
//  MineCateTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineCateTabCellBlock)(NSInteger index);

@interface MineCateTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (copy ,nonatomic) NSDictionary *dic;

@property (copy ,nonatomic) MineCateTabCellBlock block;

- (void)getIndex:(MineCateTabCellBlock )block;

@end
