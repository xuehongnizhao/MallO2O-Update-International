//
//  SelectTypeModel.h
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectTypeModel : NSObject

@property (copy ,nonatomic) NSString *gcateSpecName;

@property (copy ,nonatomic) NSString *gcateSpecId;

@property (copy ,nonatomic) NSString *allText;

@property (copy ,nonatomic) NSMutableArray *sonArray;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
