//
//  AddressControlModel.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressControlModel : NSObject

@property (copy ,nonatomic) NSString *typeString;

@property (copy ,nonatomic) NSString *addressString;

@property (copy ,nonatomic) NSString *consigneeString;

@property (copy ,nonatomic) NSString *telString;

@property (copy ,nonatomic) NSString *addressId;

@property (copy ,nonatomic) NSString *latitude;

@property (copy ,nonatomic) NSString *longtitude;

@property (copy ,nonatomic) NSString *addressInfo;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
