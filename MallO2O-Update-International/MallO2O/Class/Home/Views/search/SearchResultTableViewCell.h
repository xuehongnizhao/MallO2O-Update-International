//
//  SearchResultTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"
#import "SearchResultTableViewCell.h"

@interface SearchResultTableViewCell : UITableViewCell

@property (strong ,nonatomic) SecondModel  *secondModel;

+ (instancetype)secondeCellWithTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
