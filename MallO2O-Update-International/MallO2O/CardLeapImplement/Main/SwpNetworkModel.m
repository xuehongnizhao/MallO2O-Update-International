//
//  SWPNetworkModel.m
//  swp_song
//
//  Created by songweiping on 15/11/3.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import "SWPNetworkModel.h"

@implementation SwpNetworkModel

/*!
 *  @author swp_song
 *
 *  @brief  shareInstance ( 单利 快速初始化一个 SWPNetworkModel 模型数据 )
 *
 *  @return SwpNetworkModel
 */
+ (instancetype)shareInstance {
    static SwpNetworkModel *swpNetworkInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        swpNetworkInstance = [[self alloc] init];
    });
    return swpNetworkInstance;
}

/*!
 *  @author swp_song
 *
 *  @brief  Override init
 *
 *  @return SwpNetworkModel
 */
- (instancetype)init {
    
    if (self = [super init]) {
        
        _swpNetworkEncrypt          = YES;
        _swpNetworkCodeSuccess      = 200;
        _swpNetworkCodeError        = 400;
        _swpNetworkCode             = @"code";
        _swpNetworkMessage          = @"message";
        _swpNetworkObject           = @"obj";
        _swpNetworkError            = NSLocalizedString(@"swpNetworkError", nil);
        _swpNetworkCommitDataing    = NSLocalizedString(@"swpNetworkCommitDataing", nil);
        _swpNetworkDeleteDataing    = NSLocalizedString(@"swpNetworkDeleteDataing", nil);
        _swpNetworkUpdateDataing    = NSLocalizedString(@"swpNetworkUpdateDataing", nil);
        _swpNetworkLogin            = NSLocalizedString(@"swpNetworkLogin", nil);
        _swpNetworkGetDagaingTitle  = NSLocalizedString(@"swpNetworkGetDagaingTitle", nil);
        _swpNetworkRefreshDataTitle = NSLocalizedString(@"swpNetworkRefreshDataTitle", nil);
        _swpNetworkToLoadDataTitle  = NSLocalizedString(@"swpNetworkToLoadDataTitle", nil);
        _swpNetworkNotData          = NSLocalizedString(@"swpNetworkNotData", nil);
        _swpNetworkDataNULL         = NSLocalizedString(@"swpNetworkDataNULL", nil);
        
    }
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  swpChekNetworkError ( 检查是否 是否 是返回网络异常的提示信息 )
 *
 *  @param  errorMessage
 *
 *  @return NSString
 */
- (NSString *)swpChekNetworkError:(nullable NSString *)errorMessage {
    return errorMessage == nil ? self.swpNetworkError : errorMessage;
}

@end
