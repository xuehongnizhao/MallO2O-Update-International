//
//  MyOrderViewController.h
//  MallO2O
//
//  Created by mac on 15/6/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface MyOrderViewController : MallO2OBaseViewController

@property (strong ,nonatomic) UITableView *myOrderTableView;

@property (copy ,nonatomic) NSString *tishiString;

@property (nonatomic) NSInteger selectIndex;

@end
