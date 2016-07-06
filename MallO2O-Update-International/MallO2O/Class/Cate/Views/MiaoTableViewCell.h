//
//  MiaoTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiaoTableViewCell.h"
#import "SecondModel.h"

@interface MiaoTableViewCell : UITableViewCell

@property (strong ,nonatomic) SecondModel  *secondModel;

@property (strong ,nonatomic) UIImageView *secondImgView;

+ (instancetype)secondeCellWithTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@end
