//
//  HomeListModel.m
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel

+ (instancetype)homeListWithDic:(NSDictionary *)dic{
    return [[self alloc] modelWithDic:dic];
}

- (instancetype)modelWithDic:(NSDictionary *)dict{
    if (self == [super init]) {
        _shopImg = dict[@"shop_img"];
        _shopAddress = dict[@"shop_address"];
        _shopName = dict[@"shop_name"];
        _shopId = dict[@"shop_id"];
        _distance = dict[@"long_me"];
        _latitude = dict[@"shop_lat"];
        _longtitude = dict[@"shop_lng"];
    }
    return self;
}

@end
