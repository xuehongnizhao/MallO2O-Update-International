//
//  OrderMarkModel.m
//  MallO2O
//
//  Created by mac on 15/6/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OrderMarkModel.h"

@implementation OrderMarkModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _markTextString = dic[@"typeName"];
        _typeDetail = dic[@"typeDetail"];
    }
    return self;
}

@end
