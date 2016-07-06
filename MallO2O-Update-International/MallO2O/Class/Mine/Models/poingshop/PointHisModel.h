//
//  PointHisModel.h
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointHisModel : NSObject

@property (copy ,nonatomic) NSString *goodsName;

@property (copy ,nonatomic) NSString *goodsImgUrl;

@property (copy ,nonatomic) NSString *goodsNumber;

@property (copy ,nonatomic) NSString *goodsCode;

@property (copy ,nonatomic) NSString *goodsStatus;

@property (copy ,nonatomic) NSString *messageUrl;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
