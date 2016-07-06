//
//  PointShopModel.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointShopModel.h"

@implementation PointShopModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _imgUrl     = dic[@"integral_pic"];
        _nameText   = dic[@"integral_name"];
        _detailText = dic[@"integral_spec"];
        _pointText  = dic[@"integral_price"];
        _statusText = dic[@"result"];
        _goodsId    = dic[@"integral_id"];
        _messageUrl = dic[@"message_url"];
    }
    return self;
}

@end
