//
//  MallO2OBaseViewController+SwpPublicTools.m
//  MallO2O
//
//  Created by songweiping on 16/2/29.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController+SwpPublicTools.h"

#import "SwpRequest.h"
#import "UIColor+SwpColor.h"
#import "SwpNetworkModel.h"

@implementation MallO2OBaseViewController (SwpPublicTools)



/*!
 *  @author swp_song
 *
 *  @brief  swpPublicTooGetDataToServer ( 从服务器 获取 网络 数据 )
 *
 *  @param  URLString                   url
 *
 *  @param  parameter                   参数
 *
 *  @param  encrypt                     是否加密
 *
 *  @param  swpResultSuccess            返回成功    200
 *
 *  @param  swpResultError              返回失败    400
 */
- (void)swpPublicTooGetDataToServer:(NSString *)URLString parameters:(NSDictionary *)parameter isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccess)swpResultSuccess swpResultError:(SwpResultError)swpResultError {
    
    [SwpRequest swpPOST:URLString parameters:parameter isEncrypt:encrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        if (resultObject == nil) {
            [SVProgressHUD showErrorWithStatus:self.swpNetwork.swpNetworkDataNULL];
            return;
        }
        if (self.swpNetwork.swpNetworkCodeSuccess == [resultObject[self.swpNetwork.swpNetworkCode] intValue]) {
            swpResultSuccess(resultObject);
        } else {
            swpResultError(resultObject, resultObject[self.swpNetwork.swpNetworkMessage]);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:[self.swpNetwork swpChekNetworkError:errorMessage]];
    }];
}



/*!
 *  @author swp_song
 *
 *  @brief settingTableViewRefreshing   ( 设置tableView 刷新组件 )
 *
 *  @param  tableView                   需要设置的tableView
 *
 *  @param  target                      监听
 *
 *  @param  headerAction                头部刷新方法
 *
 *  @param  footerAction                尾部刷新方法
 */
- (void)swpPublicToolSettingTableViewRefreshing:(UITableView *)tableView target:(nullable id)target headerAction:(nullable SEL)headerAction footerAction:(nullable SEL)footerAction {
    
    // 设置 头部刷新控件
    if (headerAction != nil) tableView.mj_header = [self swpPublicToolSettingRefreshHeader:target footerAction:headerAction];
    
    // 设置 尾部刷新控件
    if (footerAction != nil) tableView.mj_footer = [self swpPublicTooSettingRefreshFooter:target footerAction:footerAction footerTitle:nil];
}


/*!
 *  @author swp_song
 *
 *  @brief settingCollectionViewRefreshing   ( 设置tableView 刷新组件 )
 *
 *  @param  tableView                        需要设置的tableView
 *
 *  @param  target                           监听
 *
 *  @param  headerAction                     头部刷新方法
 *
 *  @param  footerAction                     尾部刷新方法
 */
- (void)swpPublicToolSettingCollectionViewRefreshing:(UICollectionView *)collectionView target:(nullable id)target headerAction:(nullable SEL)headerAction footerAction:(nullable SEL)footerAction {
    
    // 设置 头部刷新控件
    if (headerAction != nil) collectionView.mj_header = [self swpPublicToolSettingRefreshHeader:target footerAction:headerAction];
    
    // 设置 尾部刷新控件
    if (footerAction != nil) collectionView.mj_footer = [self swpPublicTooSettingRefreshFooter:target footerAction:footerAction footerTitle:nil];
}

/*!
 *  @author swp_song
 *
 *  @brief  swpPublicToolSettingRefreshHeader        ( 设置 控件头部刷新 )
 *
 *  @param  target                                    监听
 *
 *  @param  footerAction                              监听方法
 *
 *  @return MJRefreshNormalHeader
 */
- (MJRefreshNormalHeader *)swpPublicToolSettingRefreshHeader:(id)target footerAction:(SEL)headerAction {
    
    MJRefreshNormalHeader *header    = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
    
    header.stateLabel.font           = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.textColor      = [UIColor swpColorFromHEX:0x333333];
    header.lastUpdatedTimeLabel.textColor = [UIColor swpColorFromHEX:0x333333];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:NSLocalizedString(@"headerMJRefreshStateIdle", nil) forState:MJRefreshStateIdle];
    [header setTitle:NSLocalizedString(@"headerMJRefreshStatePulling", nil) forState:MJRefreshStatePulling];
    [header setTitle:self.swpNetwork.swpNetworkRefreshDataTitle forState:MJRefreshStateRefreshing];
    return header;
}


/*!
 *  @author swp_song
 *
 *  @brief  swpPublicToolSettingRefreshHeader        (设置 控件尾部刷新)
 *
 *  @param  target                                    监听
 *
 *  @param  footerAction                              监听方法
 *
 *  @param  footerTitle                               刷新显示 文字
 *
 *  @return MJRefreshAutoNormalFooter
 */
- (MJRefreshAutoNormalFooter *)swpPublicTooSettingRefreshFooter:(id)target footerAction:(SEL)footerAction footerTitle:(NSString *)footerTitle {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    footer.automaticallyRefresh       = NO;
    footer.automaticallyHidden        = NO;
    // 设置字体
    footer.stateLabel.font            = [UIFont systemFontOfSize:12];
    // 设置颜色
    footer.stateLabel.textColor       = [UIColor swpColorFromHEX:0x333333];
    
    [footer setTitle:NSLocalizedString(@"footerMJRefreshStateIdle", nil) forState:MJRefreshStateIdle];
    [footer setTitle:footerTitle == nil ? self.swpNetwork.swpNetworkToLoadDataTitle : footerTitle  forState:MJRefreshStateRefreshing];
    [footer setTitle:footerTitle == nil ? self.swpNetwork.swpNetworkNotData : @"" forState:MJRefreshStateNoMoreData];
    
    return footer;
}



@end
