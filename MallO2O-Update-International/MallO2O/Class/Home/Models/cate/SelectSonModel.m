//
//  SelectSonModel.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SelectSonModel.h"

@implementation SelectSonModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _gcateSpecId = dic[@"gcate_spec_id"];
        _gcateSpecName = dic[@"gcate_spec_name"];
    }
    return self;
}

@end
