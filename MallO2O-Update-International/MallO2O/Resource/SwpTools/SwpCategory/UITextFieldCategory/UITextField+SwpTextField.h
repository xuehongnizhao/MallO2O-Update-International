//
//  UITextField+SwpTextField.h
//  Swp_song
//
//  Created by songweiping on 15/9/7.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SwpTextField)

/*!
 *  @author swp_song, 2015-12-28 11:23:31
 *
 *  @brief  swpTextFieldStyle   ( 设置 textField 的公共属性 <没有左侧图片> )
 *
 *  @param  textField           需要设置的 textField
 *
 *  @param  placeholderName     textField 显示的 placeholder
 *
 *  @param  borderColor         textField 边框颜色
 *
 *  @param  textColor           textField 文字颜色
 *
 *  @param  fontSize            textField 文字大小
 *
 *  @param  borderWidth         textField 边框
 *
 *  @param  cornerRadius        textField 圆角弧度
 *
 *  @param  keyboardType        textField 键盘样式
 *
 *  @param  encrypt             textField 是否是密码键盘
 *
 *  @since  1.0.1
 */
+ (void)swpTextFieldStyle:(UITextField *)textField placeholderName:(NSString *)placeholderName borderColor:(UIColor *)borderColor textColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius  keyboardType:(UIKeyboardType)keyboardType isTextEncrypt:(BOOL)encrypt;


/*!
 *  @author swp_song, 2015-12-28 11:25:17
 *
 *  @brief  swpTextFieldStyleLeftImage      ( 设置 textField 的公共属性 <左侧带带图片> )
 *
 *  @param  textField                       需要设置的 textField
 *
 *  @param  imageName                       textField 左侧的 图片
 *
 *  @param  placeholderName                 textField 显示的 placeholder
 *
 *  @param  borderColor                     textField 边框颜色
 *
 *  @param  textColor                       textField 文字颜色
 *
 *  @param  fontSize                        textField 文字大小
 *
 *  @param  borderWidth                     textField 边框
 *
 *  @param  cornerRadius                    textField 圆角弧度
 *
 *  @param  keyboardType                    textField 键盘样式
 *
 *  @param  encrypt                         textField 是否是密码键盘
 *
 *  @since  1.0.1
 */
+ (void)swpTextFieldStyleLeftImage:(UITextField *)textField imageName:(NSString *)imageName placeholderName:(NSString *)placeholderName borderColor:(UIColor *)borderColor textColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius keyboardType:(UIKeyboardType)keyboardType isTextEncrypt:(BOOL)encrypt;


@end

NS_ASSUME_NONNULL_END
