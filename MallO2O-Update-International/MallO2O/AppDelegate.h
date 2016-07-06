//
//  AppDelegate.h
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

#define baseUrl @"192.168.1.141/life114"
//#define baseUrl @"manager.114lives.com"

#define base_set @"base_set/ac_base"

#define NUMBERS @"0123456789"

//设置比例  依据iphone5为基准
#define Balance_Width SCREEN_WIDTH/320.0
//#define Balance_Heith SCREEN_HEIGHT/480
#define Balance_Heith (SCREEN_HEIGHT < 568.0 ? SCREEN_HEIGHT /480.0 : SCREEN_HEIGHT /568.0)

#define DefaultColor 0xf64532
#define UserName @"username"
#define PassWord @"password"
#define APIKey      @"a1dc1078153f05f524b8785c4f1a4d7a"//高德地图
#define Address @"address"
#define LoadOver @""
#define City_ID @"city_id"
#define City_Name @"city_name"
//三方登录类型
#define LoginType @"login_type"
#define ThirdId @"third_id"
//#define Vip @"vip"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (assign, nonatomic) float          systemVersion;/*!< 表示当前应用的操作系统版本号 */
@property (strong, nonatomic) NSString       *applicationVersion;/*!< 应用版本号 */

//@property (strong, nonatomic) BaseEngine     *baseEngine;/*!< 网络层引擎的实例对象 */
//@property (strong, nonatomic) AppStoreEngine *appStoreEngine;/*!< 网络层、针对APPStore */

@property (strong ,nonatomic) BMKMapManager *mapManager;

@property (strong, nonatomic) NSDictionary   *baseDict;
@property (assign, nonatomic, getter = isLogin)  BOOL login;
@property (copy ,nonatomic) NSURL *wechatPayReturnUrl;

@end

