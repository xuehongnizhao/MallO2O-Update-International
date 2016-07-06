//
//  ExchangeModel.h
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  游瓶 -----> 展示兑换商品 / 输入用户信息的数据模型

#import <Foundation/Foundation.h>

@interface ExchangeModel : NSObject

/** 展示兑换商品 / 输入用户信息的数据模型 简介 */
@property (copy, nonatomic) NSString *exchangeTitle;
/** 展示兑换商品 / 输入用户信息的数据模型 详情 */
@property (copy, nonatomic) NSString *exchangeDesc;
/** 输入用户信息的数据模型 Placeholder */
@property (copy, nonatomic) NSString *exchangePlaceholder;

@end
