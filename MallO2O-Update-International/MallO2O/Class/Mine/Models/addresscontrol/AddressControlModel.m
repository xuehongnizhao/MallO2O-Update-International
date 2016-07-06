//
//  AddressControlModel.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AddressControlModel.h"

@implementation AddressControlModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _typeString      = dic[@"type"];
        _addressString   = dic[@"address"];
        _consigneeString = dic[@"consignee"];
        _telString       = dic[@"phone_tel"];
        _addressId       = dic[@"address_id"];
        _latitude        = dic[@"lat"];
        _longtitude      = dic[@"lng"];
        _addressInfo     = dic[@"address_info"];
    }
    return self;
}

@end
