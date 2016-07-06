//
//  RecommendTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

@interface RecommendTableViewCell : UITableViewCell

@property (strong ,nonatomic) UIImageView *recImgView;

@property (strong ,nonatomic) UILabel *recTitleLabel;

@property (strong ,nonatomic) UILabel *recContentLabel;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;

@property (strong ,nonatomic) HomeListModel *listModel;

@property (strong ,nonatomic) UILabel *distance;

@end
