//
//  OrderGradingModel.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OrderGradingModel.h"

@implementation OrderGradingModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _goodsName = dic[@"goods_name"];
        _goodsId   = dic[@"goods_id"];
        _og_id     = dic[@"og_id"];
    }
    return self;
}

@end
