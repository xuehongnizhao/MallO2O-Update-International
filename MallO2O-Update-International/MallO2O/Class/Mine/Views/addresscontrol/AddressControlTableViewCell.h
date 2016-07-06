//
//  AddressControlTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressControlTableViewCell.h"
#import "AddressControlModel.h"

@interface AddressControlTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;
- (void)cellOfSelect:(BOOL)isSelect;

@property (strong ,nonatomic) AddressControlModel *model;

@property (strong ,nonatomic) NSString *imgName;

@property (strong ,nonatomic) UIImageView *selectImgView;

@end
