//
//  PushAddressTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushAddressTableViewCell.h"

@interface PushAddressTableViewCell : UITableViewCell

+ (instancetype)cellOfTabelView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) NSDictionary *dict;

@end
