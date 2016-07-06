//
//  TabCateModel.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "TabCateModel.h"

@implementation TabCateModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _cate_id = dic[@"cat_id"];
        _cate_name = dic[@"cat_name"];
    }
    return self;
}

@end
