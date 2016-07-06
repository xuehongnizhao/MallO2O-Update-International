//
//  OrderGradingModel.h
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGradingModel : NSObject

@property (copy ,nonatomic) NSString *goodsName;

@property (copy ,nonatomic) NSString *goodsId;

@property (copy ,nonatomic) NSString *og_id;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
