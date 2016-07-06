//
//  PushPayTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushPayTableViewCell.h"

@interface PushPayTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;

- (void)setIsSelectImg:(BOOL)select andNameTypeString:(NSString *)string andMarkImg:(UIImage *)image;

@property (strong ,nonatomic) NSString *payString;

@end
