//
//  OpinionModel.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpinionModel : NSObject

@property (copy ,nonatomic) NSString *opinionText;

@property (copy ,nonatomic) NSString *opinionTime;

@property (copy ,nonatomic) NSString *opinionStatus;

@property (copy ,nonatomic) NSString *opinionWebUrl;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
