//
//  SpecialModel.m
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel

+ (instancetype)modelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _specialImg = dic[@"goods_img"];
        _specialName = dic[@"goods_name"];
        _specialOldPrice = dic[@"cost_price"];
        _specialPrice = dic[@"price"];
        _webUrl = dic[@"message_url"];
        if ([_specialPrice isKindOfClass:[NSNull class]]) {
            _specialPrice = @" ";
        }
    }
    return self;
}

@end
