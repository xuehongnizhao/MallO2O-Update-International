//
//  MyOrderModel.m
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _goodsImg = dic[@"goods_pic"];
        _goodsMoney = dic[@"all_price"];
        _goodsName = dic[@"goods_name"];
        _goodsNum = dic[@"goods_num"];
        _webUrl   = dic[@"message_url"];
        _orderId = dic[@"order_id"];
    }
    return self;
}

@end
