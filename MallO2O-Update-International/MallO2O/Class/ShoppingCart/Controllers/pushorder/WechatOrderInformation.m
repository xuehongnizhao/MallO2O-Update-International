//
//  WechatOrderInformation.m
//  MallO2O
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "WechatOrderInformation.h"

@implementation WechatOrderInformation

+ (instancetype)dicWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.orderNumber = dic[@"prepayid"];
        self.orderId = dic[@"order_id"];
        self.orderMoney = dic[@"total_money"];
    }
    return self;
}

+ (instancetype) orderNumber{
    static WechatOrderInformation *model = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        model = [[self alloc] init];
    });
    return model;
}

+ (void)saveInfor:(WechatOrderInformation *)model{
    [WechatOrderInformation orderNumber].orderNumber = model.orderNumber;
    [WechatOrderInformation orderNumber].orderMoney = model.orderMoney;
    [WechatOrderInformation orderNumber].orderId = model.orderId;
}

@end
