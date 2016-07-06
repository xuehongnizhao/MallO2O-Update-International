//
//  HomeBtnModel.m
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//self.bannerImgUrl = dic[@"banner_img"];
//self.bannerImgID = dic[@"banner_id"];
//self.imgNameUrl = dic[@"special_img"];
//self.imgID = dic[@"special_id"];

#import "HomeBtnModel.h"

@implementation HomeBtnModel

+ (instancetype) homeWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cateImgUrl = dic[@"cate_img"];
        self.cateID = dic[@"cate_id"];
        self.cateName = dic[@"cate_name"];
    }
    return self;
}

@end
