//
//  UIButton+SwpButton.h
//  Swp_song
//
//  Created by songweiping on 15/9/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@interface UIButton (SwpButton)

/*!
 *  @author swp_song, 2015-12-28 11:08:03
 *
 *  @brief  swpButtonTextStyle ( 设置文字按钮基本属性 )
 *
 *  @param  button              需要设置的按钮
 *
 *  @param  title               按钮的文字
 *
 *  @param  size                字体大小
 *
 *  @param  color               字体默认颜色
 *
 *  @param  target              监听
 *
 *  @param  action              监听方法
 *
 *  @param  tag                 按钮的标识
 *
 *  @since  1.0.1
 */
+ (void)swpButtonTextStyle:(UIButton *)button setTitle:(NSString *)title fontSize:(CGFloat)size fontColor:(UIColor *)color target:(nullable id)target action:(nullable SEL)action buttonTag:(NSInteger)tag;

/*!
 *  @author swp_song, 2015-12-28 11:13:29
 *
 *  @brief  swpButtonSubmitStyle        ( 设置提交按钮的基本属性 )
 *
 *  @param  button                      需要设置的按钮
 *
 *  @param  backgroundColor             按钮的背景色
 *
 *  @param  title                       按钮的文字
 *
 *  @param  fontSize                    字体大小
 *
 *  @param  fontColor                   字体颜色
 *
 *  @param  cornerRadius                设置圆角 弧度
 *
 *  @param  tag                         按钮的标识
 *
 *  @param  target                      监听
 *
 *  @param  action                      监听方法
 *
 *  @since  1.0.1
 */
+ (void)swpButtonSubmitStyle:(UIButton *)button backgroundColor:(UIColor *)backgroundColor setTitle:(NSString *)title fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor cornerRadius:(CGFloat)cornerRadius buttonTag:(NSInteger)tag target:(nullable id)target action:(nullable SEL)action;

/*!
 *  @author swp_song, 2015-12-28 11:19:30
 *
 *  @brief  swpButtonCheckBoxStyle  ( 设置按钮为 checkBox )
 *
 *  @param  button                  设置的按钮
 *
 *  @param  title                   按钮名称
 *
 *  @param  imageName               默认图片
 *
 *  @param  selectedImagName        勾选图片
 *
 *  @param  size                    字体大小
 *
 *  @param  color                   字体颜色
 *
 *  @param  imageEdgeInsets         图片文字边距
 *
 *  @param  tag                     按钮的标识
 *
 *  @param  target                  监听
 *
 *  @param  action                  监听方法
 *
 *  @since  1.0.1
 */
+ (void)swpButtonCheckBoxStyle:(UIButton *)button setTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImagName fontSize:(CGFloat)size setTitleColor:(UIColor *)color imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets buttonTag:(NSInteger)tag target:(nullable id)target action:(nullable SEL)action;

/*!
 *  @author swp_song, 2016-01-04 18:42:47
 *
 *  @brief  swpButtonSettingNavigationButtonItemWithImage ( Setting Button is NavigationBarButton With ImageButton )
 *
 *  @param  defaultImage
 *
 *  @param  highlightedImage
 *
 *  @param  target
 *
 *  @param  action
 *
 *  @param  tag
 *
 *  @param  isLeftButton
 *
 *  @return UIButton        <Return UIButton>
 *
 *  @since  1.0.1
 */
+ (UIButton *)swpButtonSettingNavigationButtonWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(nullable id)target action:(nullable SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;

/*!
 *  @author swp_song, 2016-01-04 18:45:35
 *
 *  @brief  swpButtonSettingNavigationButtonWithTitle (Setting Button is NavigationBarButton With TitleButton )
 *
 *  @param  buttonTitle
 *
 *  @param  color
 *
 *  @param  size
 *
 *  @param  target
 *
 *  @param  action
 *
 *  @param  tag
 *
 *  @param  isLeftButton
 *
 *  @return UIButton        <Return UIButton>
 *
 *  @since  1.0.1
 */
+ (UIButton *)swpButtonSettingNavigationButtonWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(nullable id)target action:(nullable SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;

@end

NS_ASSUME_NONNULL_END
