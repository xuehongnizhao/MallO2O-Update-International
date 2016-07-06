//
//  PersonInfoModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/19.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "PersonInfoModel.h"

@implementation PersonInfoModel

static PersonInfoModel *model = nil;

+ (PersonInfoModel *)shareInstance{
    @synchronized(self) {
        if (model == nil) {
            model = [[PersonInfoModel alloc] init];
        }
        if (model.myJifen == nil) {
            model.myJifen = @"0";
        }
        if (model.myMoney == nil) {
            model.myMoney = @"0.00";
        }
        if (model.uID == nil) {
            model.uID = @"0";
        }
        return model;
    }
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        model = [super allocWithZone:zone];
    }
    return model;
}

+ (instancetype)savePersonInfo:(NSDictionary *)dic{
    PersonInfoModel *model = [PersonInfoModel shareInstance];
    model.sex              = dic[@"sex"];
    model.userName         = dic[@"user_name"];
    model.nickName         = dic[@"user_nickname"];
    model.userPhoto        = dic[@"user_pic"];
    model.myJifen          = dic[@"integral"];
    model.myMoney          = dic[@"my_money"];
    model.backGroud        = dic[@"background"];
    model.uID              = dic[@"u_id"];
    model.addressId        = dic[@"address_id"];
    model.isVip            = dic[@"vip"];
    return model;
}

+ (instancetype)clearPersonInfo{
    PersonInfoModel *model = [PersonInfoModel shareInstance];
    model.sex              = @"";
    model.userName         = @"";
    model.nickName         = @"";
    model.userPhoto        = @"";
    model.myJifen          = @"0.00";
    model.myMoney          = @"0.00";
    model.backGroud        = @"8";
    model.uID              = @"0";
    model.addressId        = @"0";
    model.isVip            = @"0";
    return model;
}

@end
