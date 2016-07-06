//
//  UZCommonMethod.h
//  WMYRiceNoodles
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 * @brief           公用方法类
 *
 *                  封装了一些常用方法
 * @author          xiaog
 * @version         0.1
 * @date            2012-12-18
 * @since           2012-12 ~
 */
@interface UZCommonMethod : NSObject



+ (void)settingBackButtonImage:(NSString *)imagename
                 selectedImage:(NSString *)selImagename
                  andContrller:(UIViewController *)controller;

/**
 *	@brief	在应用内拨打电话
 *
 *	@param 	phoneNumber 	电话号码
 *	@param 	view 	调用controller的view
 */
+ (void)callPhone:(NSString *)phoneNumber
        superView:(UIView *)view;


/**
 *	@brief	设置按钮的image或者backgroundImage
 *
 *	@param 	button 	按钮
 *	@param 	imageUrl 	正常状态的图片名称
 *	@param 	highLightImageUrl 	高亮状态的图片名称
 */
+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl;

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)checkSystemVersion;


/**
 *	@brief	判断应用的版本号
 *
 *	@return	返回版本号
 */
+ (NSString *)checkAPPVersion;



/**
 *	@brief	隐藏tableivew中多余的cell
 *
 *	@param 	tableview 	承载的Tableview
 */
+ (void)hiddleExtendCellFromTableview:(UITableView *)tableview;


/**
 *	@brief	给应用提供统一的返回按钮样式
 *          
 *  图片尺寸是 40*40 80*80
 *	@param 	imagename 	正常状态时的图片名称
 *	@param 	selImagename 	高亮时候的状态名称
 */
+ (void)settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename;


/**
 *  补全tableViewCell分割线
 *
 *  @param tableView
 *  @param cell
 */
+ (void)settingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell;

/**
 *  截取 字符串 前后空格
 *  @param      string
 *  @return     NSString
 */
+ (NSString *) trimString:(NSString *)string;

/**
 *  web 加载 远程URL
 *
 *  @param webView 需要加载url的webView
 *  @param string  加载的 url 字符串
 */
+ (void) webViewUpLoadUrl:(UIWebView *)webView withString:(NSString *)string;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void) dialingPhone:(NSString *)phoneNumber;

/**
 *  发送短信息
 *
 *  @param phoneNumber 电话号码
 */
+ (void) sendMessage:(NSString *)phoneNumber;

/**
 *  判断 是否是分页数据 是分页数据 (是分页数据 数组不清空)
 *
 *  @param dataArray 数据源数组
 *  @param page      分页数
 *  @param firstPage 第一页
 *
 *  @return 数据源
 */
+ (NSMutableArray *) chekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage;

/**
 设置label的通用方法
 */
+ (void)settingLabel:(UILabel *)label labelColor:(UIColor *)color labelFont:(int)fontSize lbelXian:(BOOL)xian;
/**
 将纯色转换成图片
 */
+ (UIImage *)setImageFromColor:(UIColor *)color viewWidth:(CGFloat )width viewHeight:(CGFloat )height;

/**
 判断手机号
 */
+(BOOL)inputString:(NSString *)textString;

@end

