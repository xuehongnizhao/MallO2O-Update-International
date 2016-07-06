//
//  SearchResultViewController.h
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface SearchResultViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *searchText;

@property (copy ,nonatomic) NSString *codeText;

@property (strong ,nonatomic) UITableView *searchResultTableView;

@end
