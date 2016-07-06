//
//  UITextField+SwpTextField.m
//  Swp_song
//
//  Created by songweiping on 15/9/7.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "UITextField+SwpTextField.h"

@implementation UITextField (SwpTextField)

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
+ (void)swpTextFieldStyle:(UITextField *)textField placeholderName:(NSString *)placeholderName borderColor:(UIColor *)borderColor textColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius  keyboardType:(UIKeyboardType)keyboardType isTextEncrypt:(BOOL)encrypt {
    
    // 边框圆角
    UIColor  *typeColor                   =  borderColor == nil ? [UIColor blackColor] : borderColor;
    
    // 边框圆角
    textField.backgroundColor             = [UIColor whiteColor];
    textField.layer.borderWidth           = borderWidth;
    textField.layer.cornerRadius          = cornerRadius;
    textField.layer.borderColor           = typeColor.CGColor;
    textField.layer.masksToBounds         = YES;
    textField.textColor                   = textColor;
    textField.font                        = [UIFont systemFontOfSize:fontSize];
    textField.keyboardType                = keyboardType;
    textField.secureTextEntry             = encrypt;
    textField.clearButtonMode             = UITextFieldViewModeWhileEditing;
    
    // 文字的间距
    textField.textAlignment               = NSTextAlignmentLeft;
    textField.leftViewMode                = UITextFieldViewModeAlways;
    UIView *view                          = [[UIView alloc] init];
    view.frame                            = CGRectMake(0, 0, 15, 0);
    textField.leftView                    = view;
    // placeholder
    NSMutableDictionary *attrs            = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = textColor;
    //    attrs[NSFontAttributeName]            = [UIFont systemFontOfSize:14];
    textField.attributedPlaceholder       = [[NSAttributedString alloc] initWithString:placeholderName attributes:attrs];
}


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
+ (void)swpTextFieldStyleLeftImage:(UITextField *)textField imageName:(NSString *)imageName placeholderName:(NSString *)placeholderName borderColor:(UIColor *)borderColor textColor:(UIColor *)textColor textFontSize:(CGFloat)fontSize borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius keyboardType:(UIKeyboardType)keyboardType isTextEncrypt:(BOOL)encrypt {
    
    UIColor  *typeColor                   =  borderColor == nil ? [UIColor whiteColor] : borderColor;
    
    // 边框圆角
    textField.backgroundColor             = [UIColor whiteColor];
    textField.layer.borderWidth           = borderWidth;
    textField.layer.cornerRadius          = cornerRadius;
    textField.layer.borderColor           = typeColor.CGColor;
    textField.layer.masksToBounds         = YES;
    textField.textColor                   = textColor;
    textField.font                        = [UIFont systemFontOfSize:fontSize];
    textField.keyboardType                = keyboardType;
    textField.secureTextEntry             = encrypt;
    textField.clearButtonMode             = UITextFieldViewModeWhileEditing;
    
    // 文字的间距
    textField.textAlignment               = NSTextAlignmentLeft;
    textField.leftViewMode                = UITextFieldViewModeAlways;
    
    // 现在 textField 左侧显示 一张图
    UIImage     *image                    = [UIImage imageNamed:imageName];
    UIImageView *imageView                = [[UIImageView alloc] initWithImage:image];
    // 图片居中
    imageView.contentMode                 = UIViewContentModeCenter;
    UIView  *view                         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.frame                       = view.frame;
    [view addSubview:imageView];
    textField.leftView                    = view;
    
    // placeholder
    NSMutableDictionary *attrs            = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = textColor;
    //    attrs[NSFontAttributeName]            = [UIFont systemFontOfSize:14];
    textField.attributedPlaceholder       = [[NSAttributedString alloc] initWithString:placeholderName attributes:attrs];
}


@end
