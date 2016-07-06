//
//  UIBarButtonItem+SwpBarButtonItem.h
//  SMServerUser
//
//  Created by songweiping on 16/1/4.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (SwpBarButtonItem)


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
+ (UIBarButtonItem *)swpButtonItemSettingNavigationBarButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(nullable id)target action:(nullable SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;


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
+ (UIBarButtonItem *)swpButtonItemSettingNavigationBarButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(nullable id)target action:(nullable SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;

@end

NS_ASSUME_NONNULL_END
