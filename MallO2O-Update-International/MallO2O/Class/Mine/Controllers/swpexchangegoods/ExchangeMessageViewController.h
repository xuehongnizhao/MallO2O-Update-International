//
//  ExchangeMessageViewController.h
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  游瓶 -----> 积分商品兑换控制器

#import "MallO2OBaseViewController.h"

@class PointShopModel;

@interface ExchangeMessageViewController : MallO2OBaseViewController

/** 积分商城数据模型 */
@property (strong, nonatomic) PointShopModel *pointShop;


@end
