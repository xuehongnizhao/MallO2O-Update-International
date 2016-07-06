//
//  NSUserDefaults+SwpUserDefaults.h
//  Swp_song
//
//  Created by songweiping on 16/1/5.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (SwpUserDefaults)

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
+ (void)swpUserDefaultSetObject:(nullable id)object forKey:(NSString *)key;

/*!
 *  @author swp_song, 2016-01-05 17:20:19
 *
 *  @brief  swpUserDefaultGetObject ( 取出 NSUserDefaults 存储的数据  )
 *
 *  @param  key          key
 *
 *  @return id
 *
 *  @since  1.0.1
 */
+ (id)swpUserDefaultGetObject:(NSString *)key;

/*!
 *  @author swp_song, 2016-01-05 17:31:04
 *
 *  @brief  swpUserDefaultRemoveObjectForKey ( 移除 NSUserDefault )
 *
 *  @param  key
 *
 *  @since  1.0.1
 */
+ (void)swpUserDefaultRemoveObjectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
