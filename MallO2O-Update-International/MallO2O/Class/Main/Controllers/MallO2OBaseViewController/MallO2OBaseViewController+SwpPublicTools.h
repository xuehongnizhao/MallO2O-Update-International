//
//  MallO2OBaseViewController+SwpPublicTools.h
//  MallO2O
//
//  Created by songweiping on 16/2/29.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

/*! SwpResultSuccess 访问服务器返回成功 Block !*/
typedef void(^SwpResultSuccess)(id resultObject);
/*! SwpResultError   访问服务器返回失败 Block !*/
typedef void(^SwpResultError)(id resultObject, NSString *errorMessage);

@interface UIViewController (SwpPublicTools)


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
- (void)swpPublicTooGetDataToServer:(NSString *)URLString parameters:(NSDictionary *)parameter isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccess)swpResultSuccess swpResultError:(SwpResultError)swpResultError;
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
- (void)swpPublicToolSettingTableViewRefreshing:(UITableView *)tableView target:(nullable id)target headerAction:(nullable SEL)headerAction footerAction:(nullable SEL)footerAction;


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
- (MJRefreshAutoNormalFooter *)swpPublicTooSettingRefreshFooter:(nullable id)target footerAction:(nullable SEL)footerAction footerTitle:(nullable NSString *)footerTitle;

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
- (void)swpPublicToolSettingCollectionViewRefreshing:(UICollectionView *)collectionView target:(nullable id)target headerAction:(nullable SEL)headerAction footerAction:(nullable SEL)footerAction;





@end

NS_ASSUME_NONNULL_END
