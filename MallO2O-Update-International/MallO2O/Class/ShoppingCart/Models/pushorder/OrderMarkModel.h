//
//  OrderMarkModel.h
//  MallO2O
//
//  Created by mac on 15/6/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMarkModel : NSObject

@property (copy ,nonatomic) NSString *markTextString;

@property (copy ,nonatomic) NSString *typeDetail;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
