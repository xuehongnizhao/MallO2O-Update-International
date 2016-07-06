//
//  defaultName.h
//  WMYRiceNoodles
//
//  Created by mac on 13-12-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/**
 * @file         defaultName.h
 * @brief        NSUserDefault的key集合
 *
 * @author       xiaocao
 * @version      0.1
 * @date         2012-12-19
 * @since        2012-12 ~
 */

#ifndef WMYRiceNoodles_defaultName_h
#define WMYRiceNoodles_defaultName_h

#define everLaunch  @"firstEnter"           /*!< 判断是否第一次进入应用: yes-不是第一次，no-是第一次 */

#define ALL_URL(key) [[[[JSONOfNetWork getDictionaryFromPlist] objectForKey:@"obj"]objectForKey:@"api"]objectForKey:key]

// 写入NSUserDefault中的数据
#define SetUserDefault(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
// 获取NSUserDefault中的数据
#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 系统字体大小
#define SYSTEM_FONT_SIZE(size) [UIFont systemFontOfSize:size];

// 是否base64加密
#define IS_USE_BASE64 @"YES"

#define IS_REMEBER @"Remember"
#define IsLogin @"Login"


#define alphaGray [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:0.3]


#define NAV_TITLE_FONT_SIZE 18

#endif
