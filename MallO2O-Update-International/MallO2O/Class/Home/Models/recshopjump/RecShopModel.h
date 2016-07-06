//
//  RecShopModel.h
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecShopModel : NSObject

@property (copy ,nonatomic) NSString *goods_name;

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *goods_price;

@property (copy ,nonatomic) NSString *urlStr;

@property (copy ,nonatomic) NSString *distance;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
