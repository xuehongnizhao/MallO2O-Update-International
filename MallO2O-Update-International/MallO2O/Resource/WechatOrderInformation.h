//
//  WechatOrderInformation.h
//  MallO2O
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatOrderInformation : NSObject

@property (copy ,nonatomic) NSString *orderNumber;

@property (copy ,nonatomic) NSString *orderMoney;

@property (copy ,nonatomic) NSString *orderId;

+ (instancetype)dicWithDic:(NSDictionary *)dic;

+ (instancetype) orderNumber;

+ (void)saveInfor:(WechatOrderInformation *)model;

@end
