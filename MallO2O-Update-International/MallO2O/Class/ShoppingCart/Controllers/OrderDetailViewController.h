//
//  OrderDetailViewController.h
//  MallO2O
//
//  Created by mac on 15/6/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface OrderDetailViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *webTitle;

@property (copy ,nonatomic) NSString *identifier;

@property (assign ,nonatomic) BOOL      canGoRoot;

- (void)reloadWebView:(NSString *)urla;

@end
