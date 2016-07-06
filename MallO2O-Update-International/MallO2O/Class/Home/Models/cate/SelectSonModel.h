//
//  SelectSonModel.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectSonModel : NSObject

@property (copy ,nonatomic) NSString *gcateSpecName;

@property (copy ,nonatomic) NSString *gcateSpecId;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
