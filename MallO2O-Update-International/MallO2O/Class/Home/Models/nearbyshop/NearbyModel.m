//
//  NearbyModel.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "NearbyModel.h"

@implementation NearbyModel

- (instancetype)nearbyModelWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _nearbyImgUrl = dic[@"shop_img"];
        _nearbyNameText = dic[@"shop_name"];
        _nearbyDetailText = dic[@"shop_address"];
    }
    return self;
}

@end
