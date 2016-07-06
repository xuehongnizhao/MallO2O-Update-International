//
//  GoodsWebViewController.h
//  MallO2O
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface GoodsWebViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *webViewUrl;

@property (copy ,nonatomic) NSString *webTitle;

@property (strong ,nonatomic) UIButton *rightButton;

@property (strong ,nonatomic) NSString *identifier;

@property (copy ,nonatomic) NSString *goodsId;

@property (copy ,nonatomic) NSString *shopName;

@property (copy ,nonatomic) NSString *imageUrl;

- (void)reloadWebView:(NSString *)urla;

@end
