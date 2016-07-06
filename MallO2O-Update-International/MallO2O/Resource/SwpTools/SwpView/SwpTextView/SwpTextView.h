//
//  SwpTextView.h
//  Swp_song
//
//  Created by songweiping on 16/1/31.
//  Copyright © 2016年 songweiping. All rights reserved.
//
//  @author             --->    swp_song    ( SwpTextView 自带 Placeholder )
//
//  @modification Time  --->    2016-02-01 13:44:16
//
//  @since              --->    1.0.1
//
//  @warning            --->    !!! <  > !!!


#import <UIKit/UIKit.h>

@class SwpTextView;

NS_ASSUME_NONNULL_BEGIN


typedef double SwpTimeInterval;

/*! SwpTextViewTextChangeHeadle Block !*/
typedef void(^SwpTextViewTextChangeHeadle)(SwpTextView *swpTextView, NSString *changeText);

@protocol SwpTextViewDelegate <NSObject>

@optional
/*!
 *  @author swp_song, 2016-02-02 10:49:53
 *
 *  @brief  swpTextView:changeText:     ( swpTextView 代理方法 用户输入文字变化调用 )
 *
 *  @param  swpTextView
 *
 *  @param  changeText
 *
 *  @since  1.0.1
 */
- (void)swpTextView:(SwpTextView *)swpTextView changeText:(NSString *)changeText;

@end

@interface SwpTextView : UITextView

/*! 设置 swpTextView  显示的数据, 取出显示的数据 !*/
@property (nonatomic, copy, readonly) NSString *swpTextViewText;
/*! 设置 swpTextView  placeholder  显示文字      !*/
@property (nonatomic, copy  ) NSString *swpTextViewPlaceholder;
/*! 设置 swpTextView 文字大小                    !*/
@property (nonatomic, assign) CGFloat  swpTextViewTextFontSize;
/*! 设置 swpTextView placeholder 文字的大小      !*/
@property (nonatomic, assign) CGFloat  swpTextViewPlaceholderFontSize;
/*! 设置 swpTextView 文字颜色                    !*/
@property (nonatomic, strong) UIColor  *swpTextViewTextFontColor;
/*! 设置 swpTextView placeholder 文字颜色        !*/
@property (nonatomic, strong) UIColor  *swpTextViewPlaceholderFontColor;
/*! 设置 swpTextView Delegate                    !*/
@property (nonatomic, weak) id<SwpTextViewDelegate>swpTextViewDelegate;

/*!
 *  @author swp_song, 2016-02-01 11:36:57
 *
 *  @brief  swpTextViewSetText  ( 设置 swpTextView 显示文字 )
 *
 *  @param  swpTextViewText
 *
 *  @since  1.0.1
 */
- (void)swpTextViewSetText:(NSString *)swpTextViewText;

/*!
 *  @author swp_song, 2016-02-01 11:19:02
 *
 *  @brief  swpPlaceholderViewDisplay   ( 是否显示 swpPlaceholderView )
 *
 *  @param  isDisplay
 *
 *  @param  duration
 *
 *  @since  1.0.1
 */
- (void)swpPlaceholderViewDisplay:(BOOL)isDisplay animateDuration:(SwpTimeInterval)duration;

/*!
 *  @author swp_song, 2016-02-01 11:39:07
 *
 *  @brief  setSwpTextViewPlaceholder   ( 设置 swpTextView 显示 placeholder )
 *
 *  @param  swpTextViewPlaceholder
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholder:(NSString *)swpTextViewPlaceholder;

/*!
 *  @author swp_song, 2016-02-01 11:44:50
 *
 *  @brief  setSwpTextViewTextFontSzie  ( 设置 swpTextView 字体大小 )
 *
 *  @param  swpTextViewTextFontSize
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewTextFontSize:(CGFloat)swpTextViewTextFontSize;

/*!
 *  @author swp_song, 2016-02-01 11:47:53
 *
 *  @brief  setSwpTextViewPlaceholderFontSize   ( 设置 swpTextView placeholder 字体大小 )
 *
 *  @param  swpTextViewPlaceholderFontSize
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholderFontSize:(CGFloat)swpTextViewPlaceholderFontSize;

/*!
 *  @author swp_song, 2016-02-01 11:54:45
 *
 *  @brief  swpTextViewTextFontSize:swpTextViewPlaceholderFontSize: ( 设置 swpTextView 文字 and placeholder 字体大小 )
 *
 *  @param  textFontSize
 *
 *  @param  placeholderFontSize
 *
 *  @since  1.0.1
 */
- (void)swpTextViewTextFontSize:(CGFloat)textFontSize swpTextViewPlaceholderFontSize:(CGFloat)placeholderFontSize;

/*!
 *  @author swp_song, 2016-02-01 12:00:26
 *
 *  @brief  setSwpTextViewTextFontColor ( 设置 swpTextView 字体颜色 )
 *
 *  @param  swpTextViewTextFontColor
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewTextFontColor:(UIColor *)swpTextViewTextFontColor;

/*!
 *  @author swp_song, 2016-02-01 13:36:33
 *
 *  @brief  setSwpTextViewPlaceholderFontColor  ( 设置 swpTextView placeholder 字体颜色 )
 *
 *  @param  swpTextViewPlaceholderFontColor
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholderFontColor:(UIColor *)swpTextViewPlaceholderFontColor;

/*!
 *  @author swp_song, 2016-02-01 13:40:54
 *
 *  @brief  swpTextViewTextFontColor:swpTextViewPlaceholderFontColor: ( 设置 swpTextView 文字 and placeholder 字体颜色 )
 *
 *  @param  textFontColor
 *
 *  @param  placeholderFontColor
 *
 *  @since  1.0.1
 */
- (void)swpTextViewTextFontColor:(UIColor *)textFontColor swpTextViewPlaceholderFontColor:(UIColor *)placeholderFontColor;

/*!
 *  @author swp_song, 2016-02-02 10:48:36
 *
 *  @brief  swpTextViewChangeText           ( 用户输入数据回调 )
 *
 *  @param  swpTextViewTextChangeHeadle
 *
 *  @since  1.0.1
 */
- (void)swpTextViewChangeText:(SwpTextViewTextChangeHeadle)swpTextViewTextChangeHeadle;

@end

NS_ASSUME_NONNULL_END
