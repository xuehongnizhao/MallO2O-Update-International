//
//  PersonInfoModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/19.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject
/**
 *  我的余额
 */
@property (copy ,nonatomic) NSString *myMoney;
/**
 *  我的积分
 */
@property (copy ,nonatomic) NSString *myJifen;
/**
 *  User ID
 */
@property (copy ,nonatomic) NSString *uID;
/**
 *  用户名
 */
@property (copy ,nonatomic) NSString *nickName;
/**
 *  账号
 */
@property (copy ,nonatomic) NSString *userName;
/**
 *  性别
 */
@property (copy ,nonatomic) NSString *sex;
/**
 *  用户头像
 */
@property (copy ,nonatomic) NSString *userPhoto;
/**
 *  未知东西
 */
@property (copy ,nonatomic) NSString *backGroud;
/**
 *  地址ID
 */
@property (copy ,nonatomic) NSString *addressId;
/**
 *  是否是VIP
 */
@property (copy ,nonatomic) NSString *isVip;
/**
 *  快速初始化一个单利模型
 *
 *  @return 返回的是单利模型
 */
+ (PersonInfoModel *)shareInstance;
/**
 *  单例存储数据
 *
 *  @param dic 存储数据来源 一般在登录接口
 *
 *  @return
 */
+ (instancetype)savePersonInfo:(NSDictionary *)dic;
/**
 *  清除数据  一般是在退出登录接口
 *
 *  @return 
 */
+ (instancetype)clearPersonInfo;

@end
