//
//  RecShopModel.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "RecShopModel.h"

@implementation RecShopModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _goods_name = dic[@"goods_name"];
        _goods_price = dic[@"price"];
        _imgUrl = dic[@"goods_img"];
        _urlStr = dic[@"message_url"];
    }
    return self;
}

@end
