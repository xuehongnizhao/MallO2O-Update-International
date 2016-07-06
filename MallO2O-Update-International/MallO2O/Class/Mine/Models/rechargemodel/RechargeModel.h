//
//  RechargeModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject

@property (copy ,nonatomic) NSString *pushMoney;

@property (copy ,nonatomic) NSString *getMoney;

+ (instancetype)initWithGetMoney:(NSString *)getMoney andPushMoney:(NSString *)pushMoney;

@end
