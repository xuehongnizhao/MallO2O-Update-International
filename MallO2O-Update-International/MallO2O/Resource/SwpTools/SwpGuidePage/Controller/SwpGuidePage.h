//
//  SwpGuidePage.h
//  Swp_song
//
//  Created by songweiping on 15/8/13.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song    ( 引导页 控制器 )
//
//  @modification Time  --->    2015-12-21 17:11:18
//
//  @since              --->    1.0.7
//
//  @warning            --->    !!! < SwpGuidePage 内部实现使用的是 collectionView > !!!

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/*! 自定义 block 带出需要修改的按钮      !*/
typedef void (^SwpIntoAppButton)(UIButton *swpIntoAppButton);
/*! SwpGuidePageCloseBlock 关闭之后block !*/
typedef void (^SwpGuidePageCloseBlock)();

@interface SwpGuidePage : UIViewController

/*!
 *  @author swp_song, 2015-12-21 15:04:55
 *
 *  @brief  swpGuidePage ( 快速 初始化 )
 *
 *  @return SwpGuidePage
 *
 *  @since  1.0.7
 */
+ (instancetype) swpGuidePage;

/*! 图片的数据源                                         !*/
@property (nonatomic,   copy) NSArray *swpGuidePageImageArray;
/*! 默认宽高比 计算按钮 在屏幕上 Y 值的 比例             !*/
@property (nonatomic, assign, readonly) CGFloat swpGuideScreenHeightscale;
/*! 设置 swpGuidePage 横向 或 纵向 滚动                  !*/
@property (nonatomic, assign) UICollectionViewScrollDirection swpGuidePageScrollDirection;
/*! 设置 swpGuidePage 是否隐藏分页控件 default NO        !*/
@property (nonatomic, assign, getter = isSwpGuidePageControlHidden)  BOOL swpGuidePageControlHidden;
/*! 设置 swpGuidePage 滑动手势         default NO        !*/
@property (nonatomic, assign, getter = isSwpGuidePageOpenSlidingGesture) BOOL swpGuidePageOpenSlidingGesture;
/*! 设置 swpGuidePage 分页控件 总页数的颜色              !*/
@property (nonatomic, strong) UIColor *swpGuidePageNumberOfPagesColor;
/*! 设置 swpGuidePage 分页控件 当前页数的颜色            !*/
@property (nonatomic, strong) UIColor *swpGuidePageCurrentPageColor;
/**
 *  是否隐藏按钮  默认NO
 */
@property (nonatomic, assign) BOOL hiddenButton;

/*!
 *  @author swp_song, 2015-12-21 15:29:03
 *
 *  @brief  swpSettingIntoAppButton ( 设置 按钮 样式 )
 *
 *  @param  swpIntoAppButton
 *
 *  @since  1.0.7
 */
- (void) swpGuidePageSettingIntoAppButton:(SwpIntoAppButton)swpIntoAppButton;

/*!
 *  @author swp_song, 2015-12-21 15:29:21
 *
 *  @brief  screenHeightscale ( 默认宽高比 计算按钮 在屏幕上 Y 值的 比例   )
 *
 *  @return CGFloat
 *
 *  @since  1.0.7
 */
- (CGFloat)swpGuideScreenHeightscale;

/*!
 *  @author swp_song, 2015-12-21 15:38:53
 *
 *  @brief  setSwpGuidePageScrollDirection ( 设置 swpGuidePage 横向 或 纵向 滚动 )
 *
 *  @param  swpGuidePageScrollDirection
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageScrollDirection:(UICollectionViewScrollDirection)swpGuidePageScrollDirection;

/*!
 *  @author swp_song, 15-12-21 15:12:26
 *
 *  @brief  setSwpGuidePageControlHidden    ( 设置 swpGuidePage 是否隐藏分页控件 default NO )
 *
 *  @param  swpGuidePageControlHidden       ( YES 是隐藏 NO 不隐藏 )
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageControlHidden:(BOOL)swpGuidePageControlHidden;

/*!
 *  @author swp_song, 2015-12-21 15:50:30
 *
 *  @brief  setSwpGuidePageOpenSlidingGesture ( 设置 swpGuidePage 滑动手势 默认是 NO 不开启  )
 *
 *  @param  swpGuidePageOpenSlidingGesture    ( NO 不开启 YES 是开启 )
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageOpenSlidingGesture:(BOOL)swpGuidePageOpenSlidingGesture;

/*!
 *  @author swp_song, 2015-12-21 15:53:20
 *
 *  @brief  setSwpGuidePageNumberOfPagesColor  ( 设置 swpGuidePage 分页控件 总页数的颜色 )
 *
 *  @param  swpGuidePageNumberOfPagesColor
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageNumberOfPagesColor:(UIColor *)swpGuidePageNumberOfPagesColor;

/*!
 *  @author swp_song, 2015-12-21 15:57:14
 *
 *  @brief  setSwpGuidePageCurrentPageColor ( 设置 swpGuidePage 分页控件 当前页数的颜色 )
 *
 *  @param  swpGuidePageCurrentPageColor
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageCurrentPageColor:(UIColor *)swpGuidePageCurrentPageColor;

/*!
 *  @author swp_song, 2015-12-21 16:03:26
 *
 *  @brief  swpGuidePageCheckAppVersionIntoApp ( 判断 app 版本 是否 是最新版本 )
 *
 *  @param  intoApp
 *
 *  @param  intoSwpGuidePage
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageCheckAppVersionIntoApp:(void(^)(void))intoApp intoSwpGuidePage:(void(^)(void))intoSwpGuidePage;

/*!
 *  @author swp_song, 2015-12-21 16:05:43
 *
 *  @brief  swpGuidePageGetCenter   ( 计算出 按钮 在屏幕的 中心位置 )
 *
 *  @param  screenHeightscale       Y 值 屏幕 高度比例
 *
 *  @param  offset                  上下偏移量
 *
 *  @return CGPoint
 *
 *  @since  1.0.7
 */
- (CGPoint)swpGuidePageGetCenter:(CGFloat)screenHeightscale offset:(CGFloat)offset;

/*!
 *  @author swp_song, 2015-12-21 16:09:40
 *
 *  @brief  swpGuidePageSettingButton  ( 快速 设置按钮的 公用属性 )
 *
 *  @param  button          需要设置的按钮
 *
 *  @param  backgroundColor 按钮的背景
 *
 *  @param  title           按钮的文字
 *
 *  @param  titleColor      文字的颜色
 *
 *  @param  fontSize        文字的大小
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageSettingButton:(UIButton *)button setBackgroundColor:(UIColor *)backgroundColor setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize;


/*!
 *  @author swp_song, 2015-12-21 16:12:06
 *
 *  @brief  swpGuidePageShow    ( 显示  swpGuidePage 控制器, 没有判断版本号 )
 *
 *  @param  navigation
 *
 *  @param  animated
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageShow:(UINavigationController *)navigation animated:(BOOL)animated completion:(void(^ __nullable )(void))completion;

/*!
 *  @author swp_song, 2015-12-21 16:16:23
 *
 *  @brief  swpGuidePageClose   ( swpGuidePage 关闭之后回调 )
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageClose:(SwpGuidePageCloseBlock)completion;

/*!
 *  @author swp_song, 2015-12-21 17:09:06
 *
 *  @brief  swpGuidePageCheckAppVersionShow  ( 显示  swpGuidePage 控制器, 判断版本号 )
 *
 *  @param  navigation
 *
 *  @param  animated
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageCheckAppVersionShow:(UINavigationController *)navigation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;


@end
NS_ASSUME_NONNULL_END
