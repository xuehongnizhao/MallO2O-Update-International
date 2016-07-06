//
//  WebViewController.h
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface WebViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *webTitle;

@property (copy ,nonatomic) NSString *identifier;

- (void)reloadWebView:(NSString *)urla;

@end
