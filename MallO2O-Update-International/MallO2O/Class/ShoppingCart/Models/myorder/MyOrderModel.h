//
//  MyOrderModel.h
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject

@property (copy ,nonatomic) NSString *goodsImg;

@property (copy ,nonatomic) NSString *goodsName;

@property (copy ,nonatomic) NSString *goodsNum;

@property (copy ,nonatomic) NSString *goodsMoney;

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *orderId;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
