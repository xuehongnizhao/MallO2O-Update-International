//
//  UIFont+SwpFont.m
//  Swp_song
//
//  Created by songweiping on 15/12/28.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import "UIFont+SwpFont.h"

@implementation UIFont (SwpFont)

/*!
 *  @author swp_song, 2015-12-28 11:02:20
 *
 *  @brief  swpFontSystemSize ( 系统字体大小 )
 *
 *  @param  fontSize
 *
 *  @return UIFont
 *
 *  @since  1.0.1
 */
+ (UIFont *)swpFontSystemSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize];
}

@end
