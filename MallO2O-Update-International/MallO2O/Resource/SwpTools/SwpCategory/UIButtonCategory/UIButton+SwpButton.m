//
//  UIButton+SwpButton.m
//  Swp_song
//
//  Created by songweiping on 15/9/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "UIButton+SwpButton.h"

@implementation UIButton (SwpButton)

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
+ (void)swpButtonTextStyle:(UIButton *)button setTitle:(NSString *)title fontSize:(CGFloat)size fontColor:(UIColor *)color target:(id)target action:(SEL)action buttonTag:(NSInteger)tag {
    
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

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
+ (void)swpButtonSubmitStyle:(UIButton *)button backgroundColor:(UIColor *)backgroundColor setTitle:(NSString *)title fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor cornerRadius:(CGFloat)cornerRadius buttonTag:(NSInteger)tag target:(id)target action:(SEL)action {
    
    button.layer.cornerRadius  = cornerRadius;
    button.layer.masksToBounds = YES;
    button.tag                 = tag;
    button.backgroundColor     = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitleColor:fontColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

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
+ (void)swpButtonCheckBoxStyle:(UIButton *)button setTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImagName fontSize:(CGFloat)size setTitleColor:(UIColor *)color imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets buttonTag:(NSInteger)tag target:(id)target action:(SEL)action {
    
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImagName] forState:UIControlStateSelected];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = imageEdgeInsets;
}

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
+ (UIButton *)swpButtonSettingNavigationButtonWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag       = tag;
    button.frame     = CGRectMake(0, 0, 44, 44);
    [button setImage:defaultImage       forState:UIControlStateNormal];
    [button setImage:highlightedImage   forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeftButton) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    } else {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return button;
}


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
+ (UIButton *)swpButtonSettingNavigationButtonWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = CGRectMake(0, 0, 44, 44);
    button.tag       = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    if (isLeftButton) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    } else {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return button;
}



@end
