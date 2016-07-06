//
//  SwpTools.h

//
//  Created by songweiping on 15/12/28.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class AppDelegate;

NS_ASSUME_NONNULL_BEGIN


@interface SwpTools : NSObject


#pragma mark - Get System Version & App Version Methods

/*!
 *  @author swp_song, 2015-12-28 14:43:54
 *
 *  @brief  swpToolCheckSystemVersion   ( 判断应用运行在什么系统版本上 )
 *
 *  @return 返回系统版本 ：7.0     6.0     6.1等
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolCheckSystemVersion;


/*!
 *  @author swp_song, 2015-12-28 14:44:47
 *
 *  @brief  swpToolCheckAppVersion      ( 判断应用的版本号 )
 *
 *  @return 返回版本号
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolCheckAppVersion;


#pragma mark - Hiddle TableView Excessed Cell & Setting TableView Cell Separate Wire - Methods
/*!
 *  @author swp_song, 2015-12-28 14:49:54
 *
 *  @brief  swpToolHiddleExcessedCellFromTableview  ( 隐藏 Tableivew 中多余的 Cell )
 *
 *  @param  tableview
 *
 *  @since  1.0.4
 */
+ (void)swpToolHiddleExcessedCellFromTableview:(UITableView *)tableview;

/*!
 *  @author swp_song, 2015-12-28 14:51:10
 *
 *  @brief  swpToolSettingTableViewAllCellWire  ( 设置 Cell 的分割线 )
 *
 *  @param  tableView
 *
 *  @param  cell
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell;



#pragma mark - WebView Load Servers URL Method
/*!
 *  @author swp_song, 2015-12-28 14:52:02
 *
 *  @brief  swpToolWebViewLoadServersURL    ( WebView 加载 服务器端 URL )
 *
 *  @param  webView
 *
 *  @param  URLstring
 *
 *  @since  1.0.4
 */
+ (void)swpToolWebViewLoadServersURL:(UIWebView *)webView serversURLString:(NSString *)URLstring;

/*!
 *  @author swp_song, 2016-01-31 15:20:45
 *
 *  @brief  swpToolWKWebViewLoadServersURL  ( WKWebView 加载 服务器端 URL )
 *
 *  @param  wkWebView
 *
 *  @param  URLstring
 *
 *  @since  1.0.4
 */
+ (void)swpToolWKWebViewLoadServersURL:(WKWebView *)wkWebView serversURLString:(NSString *)URLstring;


#pragma mark - Call Phone & Message - Methods
/*!
 *  @author swp_song, 2015-12-28 14:53:54
 *
 *  @brief  swpToolCallPhone    ( 拨打 电话 )
 *
 *  @param  phoneNumber         ( 电话 号码 )
 *
 *  @param  view                ( 当前 控制 view )
 *
 *  @since  1.0.4
 */
+ (void)swpToolCallPhone:(NSString *)phoneNumber superView:(UIView *)view;

/*!
 *  @author swp_song, 2015-12-28 14:55:16
 *
 *  @brief  swpToolSendMessage  ( 快速跳转到 发送 信息页面 <只能给固定人发送信息, 不能编辑信息内容> )
 *
 *  @param  phoneNumber
 *
 *  @since  1.0.4
 */
+ (void)swpToolSendMessage:(NSString *)phoneNumber;

#pragma mark - Trim String Front And Back Blanker Methods
/*!
 *  @author swp_song, 2015-12-28 14:55:56
 *
 *  @brief  swpToolTrimString   ( 去除 字符串 前后 空格 )
 *
 *  @param  string
 *
 *  @return string
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolTrimString:(NSString *)string;


#pragma mark - Setting Button Timer Method
/*!
 *  @author swp_song, 2015-12-28 14:56:54
 *
 *  @brief  在 button 设置倒计时 计时器
 *
 *  @param  button
 *
 *  @param  time
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingButtonTimer:(UIButton *)button andTime:(int)time;

#pragma mark - Jump ViewController Method
/*!
 *  @author swp_song, 2015-12-28 15:13:09
 *
 *  @brief  swpToolJumpContrillerWith   ( Jump ViewController <跳转控制器 根据字符串实例化 控制器> )
 *
 *  @param  navigationController
 *
 *  @param  controllerClass
 *
 *  @since  1.0.4
 */
+ (void)swpToolJumpContrillerWith:(UINavigationController *)navigationController push:(NSString *)controllerClass;


#pragma mark - Check Page Method
/*!
 *  @author swp_song, 2015-12-28 15:14:11
 *
 *  @brief  swpToolChekPageWithDataSource   ( Check page )
 *
 *  @param  dataSource
 *
 *  @param  page
 *
 *  @param  firstPage
 *
 *  @return NSMutableArray
 *
 *  @since  1.0.4
 */
+ (NSMutableArray *)swpToolChekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage;

/*!
 *  @author swp_song, 2015-12-28 15:15:26
 *
 *  @brief  swpToolSettingLabelProperty ( Setting Lable Property )
 *
 *  @param  label
 *
 *  @param  isShow
 *
 *  @param  fontSize
 *
 *  @param  fontColor
 *
 *  @since  1.0.4
 */
+ (void)swpToolSettingLabelProperty:(UILabel *)label showBorderWidth:(BOOL)isShow fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

#pragma mark - Setting View UITapGestureRecognizer Method
/*!
 *  @author swp_song, 2015-12-28 15:18:35
 *
 *  @brief  swpToolSettingTapGestureRecognizer  ( Setting View UITapGestureRecognizer <绑定 一个 点击事件 给一个 view> )
 *
 *  @param view
 *
 *  @param tag
 *
 *  @param count
 *
 *  @param target
 *
 *  @param action
 *
 *  @param cancels
 *
 *  @return
 *
 *  @since  1.0.4
 */
+ (UITapGestureRecognizer *)swpToolSettingTapGestureRecognizer:(UIView *)view viewTag:(NSInteger)tag clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels;

#pragma mark - Time Dispose Method
/*!
 *  @author swp_song, 2015-12-28 15:20:33
 *
 *  @brief  swpToolGetSystemDateWithFormat  ( Time Dispose <按照 指定 格式 时间 转换成字符串> )
 *
 *  @param  format
 *
 *  @return NSString
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolGetSystemDateWithFormat:(NSString *)format;

#pragma - mark Delete Sandbox File Method
/*!
 *  @author swp_song, 2015-12-28 15:21:27
 *
 *  @brief  swpToolDeleteFileWithFileName   ( Delete Sandbox File )
 *
 *  @param  fileName
 *
 *  @return BOOL
 *
 *  @since  1.0.4
 */
+ (BOOL)swpToolDeleteFileWithFileName:(NSString *)fileName;

#pragma mark - Image Compress Methods
/*!
 *  @author swp_song, 2015-12-08 11:13:51
 *
 *  @brief  swpToolCompressImage    ( Image Compress Methods <图片 压缩> )
 *
 *  @param  image
 *
 *  @param  size
 *
 *  @return UIImage
 *
 *  @since  1.0.4
 */
+ (UIImage *)swpToolCompressImage:(UIImage *)image scaleToSize:(CGSize)size;


#pragma mark - Data Save Plist & Get Plist Data - Methods
/*!
 *  @author swp_song, 2015-12-28 15:23:57
 *
 *  @brief  swpToolDataWriteToPlist  ( 将 数据写入 plist 文件中 )
 *
 *  @param  writeData                写入数据
 *
 *  @param  plistName                plist 文件名称
 *
 *  @return BOOL                     写入 成功 返回 YES 写入失败 返回 NO
 *
 *  @since  1.0.4
 */
+ (BOOL)swpToolDataWriteToPlist:(NSDictionary*)writeData plistName:(nullable NSString *)plistName;

/*!
 *  @author swp_song, 2015-12-28 15:24:29
 *
 *  @brief  swpToolGetDictionaryFromPlist   ( 取出 plist 文件中数据 返回一个字典 )
 *
 *  @param  plistName                       plist 文件名称
 *
 *  @return NSDictionary                    返回 取出的数据 字典
 *
 *  @since  1.0.4
 */
+ (NSDictionary *)swpToolGetDictionaryFromPlist:(nullable NSString *)plistName;

/*!
 *  @author swp_song, 2015-12-28 15:25:17
 *
 *  @brief  swpToolGetInterfaceURL  ( 取出 主接口 接口 URL )
 *
 *  @param  key                     ( url key )
 *
 *  @return NSString                ( url )
 *
 *  @since  1.0.4
 */
+ (NSString *)swpToolGetInterfaceURL:(nullable NSString *)key;

#pragma mark - Tools Methods
/*!
 *  @author swp_song, 2015-12-28 16:07:24
 *
 *  @brief  swpToolScreenWidth ( 取出 设备 实际的宽度值 )
 *
 *  @return CGFloat
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenWidth;

/*!
 *  @author swp_song, 2015-12-28 16:10:21
 *
 *  @brief  swpToolScreenHeight     ( 取出 设备 实际的高度值 )
 *
 *  @return CGFloat
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenHeight;

/*!
 *  @author swp_song, 2015-12-28 16:16:23
 *
 *  @brief  swpToolScreenSize   ( 取出 设备 实际的宽高 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolScreenSize;

/*!
 *  @author swp_song, 2015-12-28 16:33:13
 *
 *  @brief  swpToolScreenScale  ( 计算 宽高比 )
 *
 *  @param  screenWidth         ( 固定 宽度 或 高度 )
 *
 *  @param  scaleWidth          比例值  (2:1 <2为该参数> )
 *
 *  @param  scaleHeight         比例值  (2:1 <1为该参数> )
 *
 *  @return CGFloat             计算反比的数值
 *
 *  @since  1.0.4
 */
+ (CGFloat)swpToolScreenScale:(CGFloat)screenWidth scaleWidth:(CGFloat)scaleWidth scaleHeight:(CGFloat)scaleHeight;

/*!
 *  @author swp_song, 2015-12-31 09:21:17
 *
 *  @brief  swpToolIphone4sScreenSize  ( 获取 4 / 4s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone4sScreenSize;

/*!
 *  @author swp_song, 2015-12-31 09:23:37
 *
 *  @brief  swpToolIphone5sScreenSize  ( 获取 5 / 5s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone5sScreenSize;

/*!
 *  @author swp_song, 2015-12-31 09:27:35
 *
 *  @brief  swpToolIphone6sScreenSize  ( 获取 6 / 6s 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone6sScreenSize;

/*!
 *  @author swp_song, 2015-12-31 09:30:56
 *
 *  @brief  swpToolIphone6pScreenSize  ( 获取 6p / 6ps 屏幕尺寸 )
 *
 *  @return CGSize
 *
 *  @since  1.0.4
 */
+ (CGSize)swpToolIphone6pScreenSize;

#pragma mark - Get Application Delegate Method
/*!
 *  @author swp_song, 2016-01-12 11:55:22
 *
 *  @brief  swpToolApplicationDelegate ( 获取工 AppDelegat 代理 )
 *
 *  @return AppDelegate
 *
 *  @since  1.0.4
 */
+ (AppDelegate *)swpToolApplicationDelegate;

#pragma mark - Check Existence Controller
/*!
 *  @author swp_song, 2016-01-12 11:58:42
 *
 *  @brief  swpToolCheckNavigationControllerExistenceController ( 验证 导航控制器 中 是否存在 指定 控制器 )
 *
 *  @param  navigationController
 *
 *  @param  checkController
 *
 *  @param  checkResult
 *
 *  @since  1.0.4
 */
+ (void)swpToolCheckNavigationControllerExistenceController:(UINavigationController *)navigationController checkController:(Class) checkController checkResult:(void(^)(id obj, UINavigationController *navigationController, BOOL * _Nonnull stop))checkResult;

@end

NS_ASSUME_NONNULL_END
