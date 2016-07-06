//
//  BannerImgModel.h
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerImgModel : NSObject

@property (copy ,nonatomic) NSString *bannerImgUrl;

@property (copy ,nonatomic) NSString *bannerImgID;

@property (copy ,nonatomic) NSString *bannerTurnUrl;

@property (copy ,nonatomic) NSString *bannerDetialUrl;

@property (nonatomic, strong) NSString *shop_id;
@property (nonatomic, strong) NSString *banner_id;
@property (nonatomic, strong) NSString *shop_img;
@property (nonatomic, strong) NSString *shop_name;
@property (nonatomic, strong) NSString *shop_address;
@property (nonatomic, strong) NSString *long_me;



+ (instancetype)modelWithDic:(NSDictionary *)dic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end