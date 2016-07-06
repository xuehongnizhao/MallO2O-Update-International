//
//  PersonInfoTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PersonInfoBlock)(NSInteger index);

@interface PersonInfoTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (copy ,nonatomic) NSArray *array;

@property (copy ,nonatomic) PersonInfoBlock block;

- (void)getIndex:(PersonInfoBlock)block;

@end
