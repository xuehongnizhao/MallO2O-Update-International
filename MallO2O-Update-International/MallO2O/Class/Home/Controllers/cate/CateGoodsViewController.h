//
//  CateGoodsViewController.h
//  MallO2O
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface CateGoodsViewController : MallO2OBaseViewController

@property (copy ,nonatomic)NSString *cate_id;
@property (copy, nonatomic) NSString *cate_name;

/**
    筛选界面上传的参数值  用于区分默认数据和筛选数据
 */
@property (copy ,nonatomic) NSString *identifier;

/**
    模糊搜索字段
 */
@property (copy ,nonatomic) NSString *likeString;

/**
    选择后的字段
 */
@property (copy ,nonatomic) NSString *like_speString;

/**
    低价格
 */
@property (copy ,nonatomic) NSString *d_price;

/**
    高价格
 */
@property (copy ,nonatomic) NSString *h_price;

@end
