//
//  TabCateModel.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabCateModel : NSObject

@property (strong ,nonatomic) NSString *cate_id;

@property (strong ,nonatomic) NSString *cate_name;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
