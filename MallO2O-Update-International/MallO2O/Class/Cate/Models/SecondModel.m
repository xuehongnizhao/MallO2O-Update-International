//
//  SecondModel.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel

+ (instancetype)initWithModel:(NSDictionary *)dic{
    return [[self alloc]arrayWithDic:dic];
}

- (instancetype)arrayWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _secondImgUrlText = dic[@"goods_img"];
        _secondGoodsId = dic[@"goods_id"];
        _secondNowPriceText = dic[@"price"];
        _secondOldPriceText = dic[@"cost_price"];
        _secondPersonNum = dic[@"sale"];
        _secondTimeText = dic[@"end_time"];
        _secondTitleText = dic[@"goods_name"];
        _goods_detail = dic[@"goods_little_desc"];
        _secondShopName = dic[@"shop_name"];
        _secondGrading = dic[@"message"];
        _webUrl = dic[@"message_url"];
        _collect_id = dic[@"collect_id"];
        _saleNum = dic[@"sale"];
    }
    
    return self;
}

@end
