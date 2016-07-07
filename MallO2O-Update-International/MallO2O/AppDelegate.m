//
//  AppDelegate.m
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import "TabBarViewController.h"
#import "TabBarViewController.h"
#import "OrderDetailViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSnsService.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMSocial.h"
#import "Pingpp.h"

#import "SwpTools.h"

#import "MobClick.h"


@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

@property (strong ,nonatomic) NSString *messageUrl;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 项目版本号--一次调用
    self.applicationVersion = [UZCommonMethod checkAPPVersion];

    // 判断系统版本--一次调用
    self.systemVersion      = [UZCommonMethod checkSystemVersion];

    // 设置网路引擎
//    self.baseEngine         = [[BaseEngine alloc] initWithHostName:baseUrl];
    // 登陆状态
    self.login              = NO;
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"2a40AbbfELimtZOvC4nK9N9M4o4sS1QA"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    [self getInfoFromNetWork];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor     = [UIColor whiteColor];
    self.window.rootViewController  = [[TabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    if (GetUserDefault(ThirdId) != nil && ![GetUserDefault(ThirdId) isEqualToString:@""]) {
        [self autoThirdLogin];
    }else{
        [self autoLogin];
    }
    /**
     分享
     */

    [UMSocialData setAppKey:@"55ec0f2fe0f55a3af4000622"];
    
    [MobClick setCrashReportEnabled:YES];
    [MobClick startWithAppkey:@"55ec0f2fe0f55a3af4000622" reportPolicy:BATCH   channelId:@""];
    [self setShare];
    
    /*----设置icon提示数为0----*/
    [application setApplicationIconBadgeNumber:0];
    
    //-----------极光推送----------------------
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"7314312be4bfbc57ad1b1ae4"
                          channel:@"Publish channel" apsForProduction:YES];
   
//    [NSThread sleepForTimeInterval:2.0];

    //向微信注册
    [UMSocialData openLog:YES];
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    return YES;
}

#pragma mark 设置分享
/**
     设置分享
 */
- (void)setShare{
     [UMSocialData setAppKey:@"55ec0f2fe0f55a3af4000622"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:APP_ID appSecret:@"6ad21a458d3ebebfa0dc34242760cbcf" url:@"http://www.114lives.com"];
    [UMSocialQQHandler setQQWithAppId:@"1104763572" appKey:@"LU37ehGMxcMGrjRN" url:@"http://www.114lives.com"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3204389630" secret:@"99c49e55484ac534ddf193016399b46e" RedirectURL:@"http://www.114lives.com"];
}

#pragma mark 分享回调
/**
    友盟分享回掉
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    }
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;

    }
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    
    NSLog(@"%@", url.host);
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"] || [url.host isEqualToString:@"pingpp"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    } else {
        return  [UMSocialSnsService handleOpenURL:url];
    }
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}
    
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    NSString *string = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSLog(@"%@",userInfo);
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [self didPushMessageJumpController:_messageUrl];
    }];
    [alertC addAction:action];

    [self.window.rootViewController presentViewController:alertC animated:YES completion:^{
        
    }];
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark------收到通知回调
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void
                        (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@",userInfo);
    _messageUrl = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"message_url"]];
    
    if (application.applicationState == UIApplicationStateActive) {
        [self showPushMessage:userInfo];
        
    }else{
        [self didPushMessageJumpController:_messageUrl];
    }
    
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark 收到推送通知
- (void)showPushMessage:(NSDictionary *)userInfo{
    NSString *string = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self didPushMessageJumpController:_messageUrl];
    }];
    [alertC addAction:action];
    
    [self.window.rootViewController presentViewController:alertC animated:YES completion:^{
        
    }];
}


#pragma mark----设置别名
-(void)setAlian :(NSString*)alian
{
    [JPUSHService setTags:nil alias:alian fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
           NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
    }];
}

- (void)didPushMessageJumpController: (NSString *)url{
    TabBarViewController *tabBarVC = (TabBarViewController *)self.window.rootViewController;
    NSInteger index = tabBarVC.selectedIndex;
    BaseViewController *baseVC = [tabBarVC.viewControllers objectAtIndex:index];
    UIViewController    *currentViewCtrl = ((UINavigationController*)baseVC).topViewController;
    
    int isExist = 0;
    // 取出 所有控制器
    NSArray *subViews = currentViewCtrl.navigationController.viewControllers;
    
    // 循环遍历 找出跳转的控制器是否存在
    OrderDetailViewController *shopOreder = [[OrderDetailViewController alloc] init];
    for (BaseViewController *obj in subViews) {
        if ([obj isKindOfClass:[OrderDetailViewController class]]) {
            isExist    = 1;
            shopOreder = (OrderDetailViewController *)obj;
            break;
        }
    }
    
//    // 控制器是否存在
//    if (isExist == 0) {
//        // 不存在 跳转
//        shopOreder.webUrl = url;
//        [shopOreder.rdv_tabBarController setTabBarHidden:YES animated:YES];
//        shopOreder.identifier = @"1";
//        [currentViewCtrl.navigationController pushViewController:shopOreder animated:YES];
//    } else{
//        // 存在 刷新
//        [shopOreder reloadWebView:url];
//    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 获取主接口数据
/**
 *  getInfoFromNetWork 写入plist 文件
 *  获取主接口数据
 */
-(void)getInfoFromNetWork {
    
    
    
    
    NSString *url         = [NSString stringWithFormat:@"http://%@/%@", baseUrl, base_set];
    NSString *sys_type    = [[UIDevice currentDevice] systemName];
    NSString *sys_version = [[UIDevice currentDevice] systemVersion];
    NSString *device_type = @"iPhone";
    NSString *brand       = @"苹果";
    NSString *model       = [[UIDevice currentDevice] model]  ;
    NSString *lat         = @"126.650516";
    NSString *lng         = @"45.759086";
    NSString *u_id        = @"0";
    
    NSDictionary *paramDic = @{
                               @"sys_type":    sys_type,
                               @"sys_version": sys_version,
                               @"device_type": device_type,
                               @"brand":       brand,
                               @"model":       model,
                               @"app_key":     url,
                               @"lat":         lat,
                               @"lng":         lng,
                               @"u_id":        u_id
                               };
    
    
    [SwpRequest swpPOST:url parameters:paramDic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            if ([SwpTools swpToolDataWriteToPlist:resultObject plistName:nil]) {
                NSDictionary *dictData = [SwpTools swpToolGetDictionaryFromPlist:nil];
                NSLog(@"%@", dictData);
                SetUserDefault(resultObject[@"obj"][@"ios_download"], @"ios_download");
                NSLog(@"%@", GetUserDefault(@"ios_download"));
                [self performSelectorOnMainThread:@selector(getURLFilter) withObject:nil waitUntilDone:YES];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:resultObject[swpNetwork.swpNetworkMessage]];
        }

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
    
}
/**
 *  @author zq, 16-05-25 17:05:21
 *
 *  url过滤
 */
- (void)getURLFilter{
    
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"as_url_filter"];
    NSDictionary *dic = @{
                           @"app_key":url
    
                           };
                           
    [SwpRequest swpPOST:url parameters:dic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            SetUserDefault(resultObject[@"obj"], URLFilter);
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSLog(@"获取失败");
        }

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"网络不正常");
    }];


}
#pragma mark 自动登录
/**
 *  自动登录
 */
- (void)autoLogin{
    
    
    if ([GetUserDefault(AUTOLOGIN) boolValue]) {
         NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];
        if (GetUserDefault(UserName) == nil || [GetUserDefault(UserName) isEqualToString:@""]) {
            SetUserDefault(@"NO", AUTOLOGIN);
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"user_name" : GetUserDefault(UserName),
                              @"user_pass" : GetUserDefault(PassWord),
                              @"reg_type" : @"0",
                              @"th_id" : @"0"
                              };
        
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            
            if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
                [UserModel mj_objectWithKeyValues:resultObject[@"obj"]];
                SetUserDefault(@"YES", AUTOLOGIN);
                [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                SetUserDefault(@"NO", AUTOLOGIN);
                [UserModel mj_objectWithKeyValues:nil];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [UserModel mj_objectWithKeyValues:nil];
        }];
    }
}
/**
 *  三方自动登录
 */
- (void)autoThirdLogin{
    if ([GetUserDefault(AUTOLOGIN) boolValue]) {
        
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];//@"action/ac_user/yz_login";
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"reg_type" : GetUserDefault(LoginType),
                              @"th_id" : GetUserDefault(ThirdId),
                              @"user_pass" : @"0"
                              };
        
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            
            if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
                [UserModel mj_objectWithKeyValues:resultObject[@"obj"]];
                SetUserDefault(@"YES", AUTOLOGIN);
                [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                SetUserDefault(@"NO", AUTOLOGIN);
                [UserModel mj_objectWithKeyValues:nil];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                [UserModel mj_objectWithKeyValues:nil];
        }];
    }
}

@end
