//
//  BaseViewController.m
//  LeDingShop
//
//  Created by songweipng on 15/4/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

#import "UINavigationBar+BackgroundColor.h"

@interface MallO2OBaseViewController ()

@property (strong ,nonatomic) UILabel* titleLabel;

@property (strong ,nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation MallO2OBaseViewController


#pragma mark - 生命周期方法

-(void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;//设置bar的风格，控制字体颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
}

/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 导航控制器的颜色
//    [self.navigationController.navigationBar swp_SetBackgroundColor:UIColorFromRGB(DefaultColor)];
    [self.navigationController.navigationBar swp_SetBackgroundColor:[UIColor whiteColor]];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) removeBackButton{
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame     = CGRectMake(0, 0, 44, 44);
    leftButton.imageEdgeInsets            = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

#pragma mark - 设置返回按钮
/**
 *  设置返回按钮
 */
- (void) setBackButton {
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame     = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[UIImage imageNamed:@"return_no"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"navbar_return_sel"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageEdgeInsets            = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

- (void)popViewController {
//    [self resignFirstResponder];
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - setNavBarTitleWithFont
/**
 *  设置 导航控制器 title 文字
 *
 *  @param navTitle 标题名称
 *  @param navFont  文字大小
 */
- (void)setNavBarTitle:(NSString *)navTitle withFont:(CGFloat)navFont {
    //自定义标题
    _titleLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    _titleLabel.font            = [UIFont systemFontOfSize:navFont];
    _titleLabel.backgroundColor = nil;                   //设置Label背景透明
    _titleLabel.textColor       = [UIColor blackColor];  //设置文本颜色
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.opaque          = NO;
    _titleLabel.text            = navTitle;              //设置标题
    self.navigationItem.titleView = _titleLabel;
    
}


- (void)setNaviText:(NSString *)naviText{
    _titleLabel.text = naviText;
}

- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

#pragma mark - Init Data Methods
- (SwpNetworkModel *)swpNetwork {
    if (!_swpNetwork) {
        _swpNetwork                   = [SwpNetworkModel shareInstance];
        _swpNetwork.swpNetworkEncrypt = YES;
    }
    return _swpNetwork;
}

/**
 *  交互方法
 *
 *  @param webView    交互的webview
 *  @param delegate   委托
 *  @param identifier 交互认证字段
 *  @param block      完成回调
 */
- (void)setwebBridge:(UIWebView *)webView andDelegate:(id)delegate getBridgeID:(NSString *)identifier complete:(BridgeBlock)block{
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:delegate];
    [_bridge registerHandler:identifier handler:^(id data, WVJBResponseCallback responseCallback) {
        if (block) {
            block(data,responseCallback);
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
