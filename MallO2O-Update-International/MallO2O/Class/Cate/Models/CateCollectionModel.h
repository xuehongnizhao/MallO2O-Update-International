//
//  CateCollectionModel.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CateCollectionModel : NSObject

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *goodsName;

@property (copy ,nonatomic) NSString *goodsId;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
