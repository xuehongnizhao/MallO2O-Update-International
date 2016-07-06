//
//  MyOrderTimeModel.h
//  MallO2O
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderTimeModel : NSObject

@property (copy ,nonatomic) NSString *dateString;

@property (copy ,nonatomic) NSString *statusString;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
