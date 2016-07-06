//
//  PointHisModel.m
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointHisModel.h"

@implementation PointHisModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _goodsImgUrl = dic[@"integral_pic"];
        _goodsName   = dic[@"integral_name"];
        _goodsCode   = dic[@"order_code"];
        _messageUrl  = dic[@"message_url"];
        if ([dic[@"order_state"] integerValue] == 0) {
            _goodsStatus = @"未完成";
        }else{
            _goodsStatus = @"已完成";
        }
        
        _goodsNumber = dic[@"num"];
    }
    return self;
}

@end
