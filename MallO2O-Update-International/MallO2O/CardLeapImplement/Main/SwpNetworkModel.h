//
//  SWPNetworkModel.h
//  swp_song
//
//  Created by songweiping on 15/11/3.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwpNetworkModel : NSObject

/*! 获取网路 接口 是否 加密        !*/
@property (nonatomic, assign, getter = isSwpNetworkEncrypt) BOOL swpNetworkEncrypt;
/*! 获取接口数据状态返回成功        !*/
@property (nonatomic, assign) NSInteger swpNetworkCodeSuccess;
/*! 获取接口数据状态返回失败        !*/
@property (nonatomic, assign) NSInteger swpNetworkCodeError;
/*! 获取接口数据状态值             !*/
@property (nonatomic, copy  ) NSString  *swpNetworkCode;
/*! 获取接口返回状态信息           !*/
@property (nonatomic, copy  ) NSString  *swpNetworkMessage;
/*! 获取网路数据错误               !*/
@property (nonatomic, copy  ) NSString  *swpNetworkError;
/*! 获取接口返回数据               !*/
@property (nonatomic, copy  ) NSString  *swpNetworkObject;
/*! 用户提交数据时 显示的信息       !*/
@property (nonatomic, copy  ) NSString  *swpNetworkCommitDataing;
/*! 用户删除数据时 显示的信息      !*/
@property (nonatomic, copy  ) NSString  *swpNetworkDeleteDataing;
/*! 用户修改数据时 显示的信息      !*/
@property (nonatomic, copy  ) NSString  *swpNetworkUpdateDataing;
/*! 用户修改数据时 显示的信息      !*/
@property (nonatomic, copy  ) NSString  *swpNetworkLogin;
/*! 用户获取列表数据时 显示的信息  !*/
@property (nonatomic, copy  ) NSString  *swpNetworkGetDagaingTitle;
/*! 用户刷新列表时 显示的信息      !*/
@property (nonatomic, copy  ) NSString  *swpNetworkRefreshDataTitle;
/*! 用户刷新列表时 显示的信息      !*/
@property (nonatomic, copy  ) NSString  *swpNetworkToLoadDataTitle;
/*! 获取接口数据时 没有数据显示信息 !*/
@property (nonatomic, copy  ) NSString  *swpNetworkNotData;
/*! 获取接口数据时 返回数据为nil   !*/
@property (nonatomic, copy  ) NSString  *swpNetworkDataNULL;

/*!
 *  @author swp_song
 *
 *  @brief  shareInstance ( 单利 快速初始化一个 SWPNetworkModel 模型数据 )
 *
 *  @return SwpNetworkModel
 */
+ (instancetype)shareInstance;

/*!
 *  @author swp_song
 *
 *  @brief  swpChekNetworkError ( 检查是否 是否 是返回网络异常的提示信息 )
 *
 *  @param  errorMessage
 *
 *  @return NSString
 */
- (nullable NSString *)swpChekNetworkError:(nullable NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END
