//
//  HomeListModel.h
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeListModel : NSObject

@property (copy ,nonatomic) NSString *shopImg;

@property (copy ,nonatomic) NSString *shopName;

@property (copy ,nonatomic) NSString *shopAddress;

@property (copy ,nonatomic) NSString *shopId;

@property (copy ,nonatomic) NSString *distance;

@property (copy ,nonatomic) NSString *latitude;

@property (copy ,nonatomic) NSString *longtitude;

- (instancetype)modelWithDic:(NSDictionary *)dict;

+ (instancetype)homeListWithDic:(NSDictionary *)dic;

@end
