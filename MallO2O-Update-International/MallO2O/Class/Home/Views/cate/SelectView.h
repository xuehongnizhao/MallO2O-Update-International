//
//  SelectView.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectTypeModel.h"

@interface SelectView : UIView

/*--------在view里添加一个tableview-------*/
@property (strong ,nonatomic) UITableView *tableView;

@property (strong ,nonatomic) UIButton *backButton;

@property (strong ,nonatomic) NSArray *array;

@property (strong ,nonatomic) NSString *string;

@end
