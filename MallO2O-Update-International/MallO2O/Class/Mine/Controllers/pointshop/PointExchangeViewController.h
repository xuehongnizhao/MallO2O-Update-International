//
//  PointExchangeViewController.h
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"
#import "PointShopModel.h"

@interface PointExchangeViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *pointText;

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *pointNumber;

@property (copy ,nonatomic) NSString *goodsName;

@property (weak ,nonatomic) PointShopModel *model;

@end
