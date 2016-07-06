//
//  UIColor+SwpColor.m
//  Swp_song
//
//  Created by songweiping on 15/12/27.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import "UIColor+SwpColor.h"

@implementation UIColor (SwpColor)



/*!
 *  @author swp_song, 2015-12-28 09:16:29
 *
 *  @brief  swpColorFromHEX ( 根据16进制获取颜色 )
 *
 *  @param  hexValue        ( 16进制色值 )
 *
 *  @return UIColor
 *
 *  @since  1.0.1
 */
+ (UIColor *)swpColorFromHEX:(NSInteger)hexValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0];
}

/*!
 *  @author swp_song, 2015-12-28 09:53:24
 *
 *  @brief  swpColorFromRGB ( 根据 RGB 三基色 取色 )
 *
 *  @param  red             红
 *
 *  @param  green           绿
 *
 *  @param  blue            蓝
 *
 *  @param  alpha           透明度
 *
 *  @return UIColor
 *
 *  @since  1.0.1
 */
+ (UIColor *)swpColorFromRGB:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}


/*!
 *  @author swp_song, 2015-12-28 11:48:23
 *
 *  @brief  swpColorFromRandom ( 生成一个随机的颜色 )
 *
 *  @return UIColor
 *
 *  @since  1.0.1
 */
+ (UIColor *)swpColorFromRandom {
    return [UIColor swpColorFromRGB:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256) alpha:1];
}

@end
