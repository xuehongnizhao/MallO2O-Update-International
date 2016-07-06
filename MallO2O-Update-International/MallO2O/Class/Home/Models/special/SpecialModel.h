//
//  SpecialModel.h
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialModel : NSObject

@property (copy ,nonatomic) NSString *specialImg;

@property (copy ,nonatomic) NSString *specialPrice;

@property (copy ,nonatomic) NSString *specialOldPrice;

@property (copy ,nonatomic) NSString *specialName;

@property (copy ,nonatomic) NSString *webUrl;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
