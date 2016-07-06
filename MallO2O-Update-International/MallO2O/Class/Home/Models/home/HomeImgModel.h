//
//  HomeImgModel.h
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeImgModel : NSObject

@property (copy ,nonatomic) NSString *imgID;

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *imgName;

+ (instancetype)homeImgWithDic:(NSDictionary *)dic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
