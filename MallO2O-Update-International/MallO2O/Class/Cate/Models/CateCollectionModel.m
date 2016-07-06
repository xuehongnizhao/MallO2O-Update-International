//
//  CateCollectionModel.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateCollectionModel.h"

@implementation CateCollectionModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        if ([dic[@"cat_img"] isKindOfClass:[NSNull class]]) {
            _imgUrl = @"";
        }else{
            _imgUrl = dic[@"cat_img"];
        }
        _goodsId = dic[@"cat_id"];
        _goodsName = dic[@"cat_name"];
        
    }
    return self;
}

@end
