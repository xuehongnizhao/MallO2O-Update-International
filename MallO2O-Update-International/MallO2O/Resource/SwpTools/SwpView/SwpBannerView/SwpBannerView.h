//
//  SwpBannerView.h
//  Swp_song
//
//  Created by songweiping on 15/8/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song    ( 图片轮播库 )
//
//  @modification Time  --->    2015-12-10 20:14:00
//
//  @since              --->    1.0.7
//
//  @warning            --->    !!! < swpBannerView 内部实现使用的是 collectionView > !!!
//                      --->    !!! < 如需要自定义 cell 需要 注册 cell 方法已经提供 > !!!
//                      --->    !!! < swpBannerView 图片轮播远程加载图片依赖 SDWebImage 三方库 > !!!


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class SwpBannerView;

typedef void(^SwpBannerViewBlock)(SwpBannerView *swpBannerView, NSIndexPath *indexPath);

/*! swpBannerView DataSource  */
@protocol SwpBannerViewDataSource <NSObject>

/*!
 *  @author swp_song, 2015-12-09 15:47:46
 *
 *  @brief  swpBannerView   DataSource  ( 设置 swpBannerView 每个分组显示数据的个数 )
 *
 *  @param  swpBannerView
 *
 *  @param  section
 *
 *  @return NSInteger
 *
 *  @since  1.0.7
 */
- (NSInteger) swpBannerView:(SwpBannerView *)swpBannerView numberOfItemsInSection:(NSInteger)section;


/*!
 *  @author swp_song, 2015-12-09 15:57:28
 *
 *  @brief  swpBannerView   DataSource  ( 设置 swpBannerView 显示默认的cell 显示图片的名称 | 远程 URL )
 *
 *  @param  swpBannerView               ( 注意: swpCustomCell 值 为 NO 时 才会调用， swpCustomCell 默认为 NO )
 *
 *  @param  indexPath
 *
 *  @return NSString
 *
 *  @since  1.0.7
 */
- (NSString *) swpBannerView:(SwpBannerView *)swpBannerView cellImageForItemAtIndexPath:(NSIndexPath *)indexPath;


@optional
/*!
 *  @author swp_song, 2015-12-09 16:01:43
 *
 *  @brief  swpBannerView   DataSource  ( 设置 swpBannerView 分组的个数 )
 *
 *  @param  swpBannerView
 *
 *  @return NSInteger
 *
 *  @since  1.0.7
 */
- (NSInteger) swpBannerViewNmberOfSections:(SwpBannerView *)swpBannerView;


/*!
 *  @author swp_song, 2015-12-09 16:04:03
 *
 *  @brief  swpBannerView   DataSource  ( 设置 swpBannerView 自定义分组中 cell 显示的数据 | 样式 )
 *
 *  @param  swpBannerView
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 *
 *  @since  1.0.7
 */
- (UICollectionViewCell *) swpBannerView:(SwpBannerView *)swpBannerView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

/*! swpBannerView 代理协议 */
@protocol SwpBannerViewDelegate <NSObject>

@optional


/*!
 *  @author swp_song, 15-12-09 16:12:23
 *
 *  @brief  swpBannerView   Delegate    ( swpBannerView 点击每个cell调用 )
 *
 *  @param  swpBannerView
 *
 *  @param  indexPath
 *
 *  @since  1.0.7
 */
- (void) swpBannerView:(SwpBannerView *)swpBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/*!
 *  @author swp_song, 2015-12-09 16:06:51
 *
 *  @brief  swpBannerView   Delegate    ( 设置 swpBannerView 每个cell的宽高 )
 *
 *  @param  swpBannerView
 *
 *  @param  collectionView
 *
 *  @param  collectionViewLayout
 *
 *  @param  indexPath
 *
 *  @return CGSize
 *
 *  @since  1.0.7
 */
- (CGSize) swpBannerView:(SwpBannerView *)swpBannerView collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SwpBannerView : UIView

/*! 设置 swpBanner 数据源属性                               !*/
@property (nonatomic, weak) id<SwpBannerViewDataSource> dataSource;
/*! 设置 swpBanner 代理属性                                 !*/
@property (nonatomic, weak) id<SwpBannerViewDelegate> delegate;
/*! 设置 swpBanner 定时时间               default 0.5s      !*/
@property (nonatomic, assign)  CGFloat swpBannerTime;
/*! 设置 swpBanner 是否自定义cell          default NO       !*/
@property (nonatomic, assign, getter = isSwpBannerCustomCell)        BOOL swpBannerCustomCell;
/*! 设置 swpBanner 是否加载 远程url 图片   default YES      !*/
@property (nonatomic, assign, getter = isSwpBannerLoadNetworkImage)  BOOL swpBannerLoadNetworkImage;
/*! 设置 swpBanner 是否 开启 弹簧效果      default YES      !*/
@property (nonatomic, assign, getter = isSwpBannerBounces)           BOOL swpBannerBounces;
/*! 设置 swpBanner 中 PagesColor 是否 隐藏 default 是 NO    !*/
@property (nonatomic, assign, getter = isSwpBannerPageControlHidden) BOOL swpBannerPageControlHidden;
/*! 设置 swpBanner 中 PagesColor 总页数的颜色               !*/
@property (nonatomic, strong) UIColor *swpNumberOfPagesColor;
/*! 设置 swpBanner 中 PagesColor 当前页数的颜色             !*/
@property (nonatomic, strong) UIColor *swpCurrentPageColor;


#pragma mark - Setting SwpBannerView Propertys Methods
/*!
 *  @author swp_song, 2015-12-08 23:06:05
 *
 *  @brief  setSwpBannerTime ( 设置 swpBannerTime 定时时间 )
 *
 *  @param  swpBannerTime    ( default 0.5s )
 *
 *  @since  1.0.7
 */
- (void) setSwpBannerTime:(CGFloat)swpBannerTime;

/*!
 *  @author swp_song, 2015-12-08 23:21:14
 *
 *  @brief  setSwpBannerCustomCell  ( 设置 swpBanner 是否自定义cell )
 *
 *  @param  swpBannerCustomCell     ( default NO < YES使用自动cell , NO 使用默认cell > )
 *
 *  @since  1.0.7
 */
- (void)setSwpBannerCustomCell:(BOOL)swpBannerCustomCell;

/*!
 *  @author swp_song, 2015-12-08 23:22:48
 *
 *  @brief  setSwpBannerLoadNetworkImage   ( 设置 swpBanner 是否加载远程url )
 *
 *  @param  swpBannerLoadNetworkImage      ( default NO < YES 加载远程 url, NO 加载本地图片 >)
 *
 *  @since  1.0.7
 */
- (void)setSwpBannerLoadNetworkImage:(BOOL)swpBannerLoadNetworkImage;

/*!
 *  @author swp_song, 2015-12-08 23:27:16
 *
 *  @brief  setSwpBannerBounces     ( 设置 swpBanner  弹簧效果 )
 *
 *  @param  swpBannerBounces        ( default YES < YES 开启, NO 关闭 > )
 *
 *  @since  1.0.7
 */
- (void)setSwpBannerBounces:(BOOL)swpBannerBounces;

/*!
 *  @author swp_song, 2015-12-08 23:33:15
 *
 *  @brief  setSwpBannerPageControlHidden   (设置 swpBanner 中 PagesColor 是否隐藏 )
 *
 *  @param  swpBannerPageControlHidden      ( default NO <YES 隐藏, NO 显示> )
 *
 *  @since  1.0.7
 */
- (void)setSwpBannerPageControlHidden:(BOOL)swpBannerPageControlHidden;

/*!
 *  @author swp_song, 2015-12-08 23:34:11
 *
 *  @brief setSwpNumberOfPagesColor
 *
 *  @param swpNumberOfPagesColor (设置 swpBanner 中 PagesColor 总页数的颜色 )
 *
 *  @since  1.0.7
 */
- (void)setSwpNumberOfPagesColor:(UIColor *)swpNumberOfPagesColor;


/*!
 *  @author swp_song, 15-12-19 19:12:41
 *
 *  @brief setSwpCurrentPageColor   (设置 swpBanner 中 PagesColor 当前页数的颜色)
 *
 *  @param swpCurrentPageColor
 *
 *  @since  1.0.7
 */
- (void)setSwpCurrentPageColor:(UIColor *)swpCurrentPageColor;

/*!
 *  @author swp_song, 2015-12-08 23:39:37
 *
 *  @brief  swpBannerRegisterClass ( swpBanner 注册一个cell )
 *
 *  @param  cellClass
 *
 *  @param  identifier
 *
 *  @since  1.0.7
 */
- (void) swpBannerRegisterClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

/*!
 *  @author swp_song, 2015-12-08 23:42:57
 *
 *  @brief  swpBannerReloadData ( swpBannerView 数据刷新 )
 *
 *  @since  1.0.7
 */
- (void) swpBannerReloadData;

/*!
 *  @author swp_song, 2015-12-10 20:13:26
 *
 *  @brief  swpBannerViewDidSelectItemAtIndexPath ( 点击  点击每个cell调用 使用 block 带出属性)
 *
 *  @param  swpBannerViewBlock
 *
 *  @since  1.0.7
 */
- (void) swpBannerViewDidSelectItemAtIndexPath:(SwpBannerViewBlock)swpBannerViewBlock;

@end

NS_ASSUME_NONNULL_END
