//
//  HomeViewController.h
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface HomeViewController : MallO2OBaseViewController

/** 导航栏文字 */
@property (nonatomic, strong) NSString  *nameAddress;

/** 经纬度 */
@property (nonatomic, strong) NSString *laString;

/** 经纬度 */
@property (nonatomic, strong) NSString *longString;
@end
