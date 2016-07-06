//
//  BaseViewController.h
//  LeDingShop
//
//  Created by songweipng on 15/4/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <MJRefresh/MJRefresh.h>
#import "SwpNetworkModel.h"

#import "MallO2OBaseViewController+SwpPublicTools.h"
#import "SwpTools.h"

typedef void(^BridgeBlock)(id data,WVJBResponseCallback callBack);

@interface MallO2OBaseViewController : UIViewController

/*! 网路数据信息参数                   !*/
@property (nonatomic, strong) SwpNetworkModel *swpNetwork;

@property (strong ,nonatomic) BridgeBlock block;


/**
 *  设置 导航控制器 title 文字
 *
 *  @param navTitle 标题名称
 *  @param navFont  文字大小
 */
- (void)setNavBarTitle:(NSString *)navTitle withFont:(CGFloat)navFont;

/**
 *  设置返回按钮
 */
- (void) setBackButton;

- (void) removeBackButton;

- (void) popViewController;

@property (copy ,nonatomic) NSString *naviText;

- (BOOL)isContainsEmoji:(NSString *)string;
/**
 *  交互方法
 *
 *  @param webView    交互的webview
 *  @param delegate   委托
 *  @param identifier 交互认证字段
 *  @param block      完成回调
 */
- (void)setwebBridge:(UIWebView *)webView andDelegate:(id)delegate getBridgeID:(NSString *)identifier complete:(BridgeBlock)block;

@end
