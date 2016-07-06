//
//  UIBarButtonItem+SwpBarButtonItem.m
//  SMServerUser
//
//  Created by songweiping on 16/1/4.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "UIBarButtonItem+SwpBarButtonItem.h"

@implementation UIBarButtonItem (SwpBarButtonItem)

/*!
 *  @author swp_song, 2016-01-04 18:57:24
 *
 *  @brief  swpButtonItemSettingNavigationBarButtonItemWithImage  (Setting UINavigationBar Button is ImageButton )
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
 *  @return UIBarButtonItem     <Return UIBarButtonItem>
 *
 *  @since  1.0.1
 */
+ (UIBarButtonItem *)swpButtonItemSettingNavigationBarButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    //    button.layer.borderWidth = 1;
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
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


/*!
 *  @author swp_song, 2016-01-04 18:57:44
 *
 *  @brief  swpButtonSettingNavigationBarButtonItemWithTitle ( Setting UINavigationBar Button is TitleButton )
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
 *  @return UIBarButtonItem   <Return UIBarButtonItem>
 *
 *  @since  1.0.1
 */
+ (UIBarButtonItem *)swpButtonItemSettingNavigationBarButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = CGRectMake(0, 0, 44, 44);
    button.tag       = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeftButton) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    } else {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
