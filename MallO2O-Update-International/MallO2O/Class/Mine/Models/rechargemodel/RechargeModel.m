//
//  RechargeModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "RechargeModel.h"

@implementation RechargeModel

+ (instancetype)initWithGetMoney:(NSString *)getMoney andPushMoney:(NSString *)pushMoney{
    RechargeModel *model = [[RechargeModel alloc] init];
    model.getMoney = getMoney;
    model.pushMoney = pushMoney;
    return model;
}

@end
