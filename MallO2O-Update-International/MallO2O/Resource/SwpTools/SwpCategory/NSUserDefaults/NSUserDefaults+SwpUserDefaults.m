//
//  NSUserDefaults+SwpUserDefaults.m
//  Swp_song
//
//  Created by songweiping on 16/1/5.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "NSUserDefaults+SwpUserDefaults.h"

@implementation NSUserDefaults (SwpUserDefaults)

/*!
 *  @author swp_song, 2016-01-05 17:16:50
 *
 *  @brief  swpUserDefaultSetObject ( NSUserDefaults 存入 数据 )
 *
 *  @param  object      value
 *
 *  @param  key         key
 *
 *  @since  1.0.1
 */
+ (void)swpUserDefaultSetObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

/*!
 *  @author swp_song, 2016-01-05 17:20:19
 *
 *  @brief  swpUserDefaultGetObject ( 取出 NSUserDefaults 存储的数据  )
 *
 *  @param  key
 *
 *  @return id
 *
 *  @since  1.0.1
 */
+ (id)swpUserDefaultGetObject:(NSString *)key {
   return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/*!
 *  @author swp_song, 2016-01-05 17:31:04
 *
 *  @brief  swpUserDefaultRemoveObjectForKey ( 移除 NSUserDefault )
 *
 *  @param  key
 *
 *  @since  1.0.1
 */
+ (void)swpUserDefaultRemoveObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


@end
