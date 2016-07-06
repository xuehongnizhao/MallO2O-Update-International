//
//  PointShopModel.h
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointShopModel : NSObject

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *messageUrl;

@property (copy ,nonatomic) NSString *nameText;

@property (copy ,nonatomic) NSString *detailText;

@property (copy ,nonatomic) NSString *pointText;

@property (copy ,nonatomic) NSString *statusText;

@property (copy ,nonatomic) NSString *goodsId;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
