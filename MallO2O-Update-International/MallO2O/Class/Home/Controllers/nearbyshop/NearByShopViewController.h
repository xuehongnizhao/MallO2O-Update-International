//
//  NearByShopViewController.h
//  MallO2O
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface NearByShopViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *naviTitle;


@property (nonatomic, assign) BOOL near;
@property (nonatomic, assign) BOOL newPage;

/** id */
@property (nonatomic, strong) NSString *typeID;

/** 定位纬度 */
@property (copy, nonatomic)   NSString          *baidu_lat;
/** 定位经度 */
@property (copy, nonatomic)   NSString          *baidu_lng;


@end
