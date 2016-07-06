//
//  PushOrderViewController.h
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface PushOrderViewController : MallO2OBaseViewController

/**
    地址
 */
@property (copy ,nonatomic) NSString *addressString;

/**
 用户名
 */
@property (copy ,nonatomic) NSString *userName;

/**
 用户电话
 */
@property (copy ,nonatomic) NSString *userTel;

/**
 备注
 */
@property (copy ,nonatomic) NSString *markString;

/**
 购物车传过来的数组
 */
@property (copy ,nonatomic) NSArray *shopCarArray;

@end
