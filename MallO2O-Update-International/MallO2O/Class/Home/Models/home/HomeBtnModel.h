//
//  HomeBtnModel.h
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBtnModel : NSObject

@property (copy ,nonatomic) NSString *cateID;

@property (copy ,nonatomic) NSString *cateImgUrl;

@property (copy ,nonatomic) NSString *cateName;

+ (instancetype) homeWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
