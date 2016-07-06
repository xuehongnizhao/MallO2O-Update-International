//
//  HomeImgModel.m
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeImgModel.h"

@implementation HomeImgModel

+ (instancetype)homeImgWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _imgID = dic[@"special_id"];
        _imgUrl = dic[@"special_img"];
        _imgName = dic[@"special_name"];
    }
    return self;
}

@end
