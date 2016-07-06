//
//  MyOrderTimeModel.m
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MyOrderTimeModel.h"

@implementation MyOrderTimeModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _dateString = dic[@"add_time"];
        _statusString = dic[@"order_status"];
    }
    return self;
}

@end
