//
//  GoodsWebViewController.m
//  MallO2O
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsWebViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "OrderGradingViewController.h"
#import "PushOrderViewController.h"
#import "HomeRecJumpViewController.h"
#import "Base64.h"
#import "ShareView.h"
#import "ShopCarIndependenceViewController.h"

@interface GoodsWebViewController ()<UIWebViewDelegate ,UMSocialDataDelegate ,UMSocialUIDelegate ,UIActionSheetDelegate>

@property (strong ,nonatomic) UIWebView *webView;

@property (strong ,nonatomic) UIView *blackView;

@property (strong ,nonatomic) ShareView *shareView;

@property (strong ,nonatomic) NSDictionary *webDictionaryData;

@end

@implementation GoodsWebViewController{
    WebViewJavascriptBridge *_bridge;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];

    [self setwebBridge];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self setBackType];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/**
 *  商品详情跳转商家的交互
 */
- (void)setwebBridge{
    __weak typeof(self) vc = self;
    [self setwebBridge:self.webView andDelegate:self getBridgeID:@"goods_web" complete:^(id data, WVJBResponseCallback callBack) {
        NSLog(@"testObjcCallback called: %@", data);
        vc.webDictionaryData = [NSDictionary dictionaryWithDictionary:(NSDictionary *)data];
        [vc pushShopInfo];
    }];
}
/**
 *  跳转页面传值
 */
- (void)pushShopInfo{
    HomeRecJumpViewController *viewController = [[HomeRecJumpViewController alloc] init];
    viewController.shopId = _webDictionaryData[@"shop_id"];
    viewController.shopName = _webDictionaryData[@"shop_name_ios"];
    viewController.shopAddress = _webDictionaryData[@"shop_address_ios"];
    viewController.imgUrl = _webDictionaryData[@"shop_img_ios"];
    viewController.naviTitle = NSLocalizedString(@"homeRecJumpBusinessDetailsNavigationTitle", nil);
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setBackType{
    _identifier = GetUserDefault(@"back_home_view");
//    NSLog(@"asdfasdfasdfasdf=====%@",GetUserDefault(U_ID));
    if ([GetUserDefault(AUTOLOGIN) boolValue] == YES) {
//        NSLog(@"%@",[_webViewUrl stringByAppendingFormat:@"&u_id=%@",GetUserDefault(U_ID) ]);
//        NSURL *url            = [NSURL URLWithString:[_webViewUrl stringByAppendingFormat:@"&u_id=%@",GetUserDefault(U_ID)]];
        NSURL *url            = [NSURL URLWithString:[_webViewUrl stringByAppendingFormat:@"&u_id=%@",[UserModel shareInstance].u_id]];
        NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }else{
        NSURL *url            = [NSURL URLWithString:[_webViewUrl stringByAppendingString:@"&u_id="]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    if ([_identifier isEqualToString:@"返回首页"]) {
        //        [self.navigationController popToRootViewControllerAnimated:YES];
        NSArray *array = self.navigationController.viewControllers;
        HomeViewController *viewController = array[0];
        [viewController.rdv_tabBarController setTabBarHidden:NO animated:NO];
        [self.navigationController popToViewController:viewController animated:NO];
    }else{
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    if ([GetUserDefault(@"back_home_view") isEqualToString:@"返回首页"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    _webDictionaryData = [NSDictionary dictionary];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
}

- (void)popViewController{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 添加导航按钮
 */
- (void)addItemButton{
    _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame     = CGRectMake(0, 0, 34, 34);
    _rightButton.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [_rightButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"share_sel"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"share_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
}

#pragma mark - 设置分享  添加提示
- (void)share{
    [[[UIApplication sharedApplication].delegate window] addSubview:self.blackView];
    [[[UIApplication sharedApplication].delegate window] addSubview:self.shareView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackGround:)];
    self.blackView.userInteractionEnabled = YES;
    [self.blackView addGestureRecognizer:gesture];
    _shareView.imageArray = @[@"UMS_wechat_session_icon@2x",@"UMS_wechat_timeline_icon", @"UMS_qq_icon",@"UMS_sina_icon"];
    _shareView.shareName = @[@"微信好友",@"朋友圈",@"QQ",@"微博"];
    [UIView animateWithDuration:0.2 animations:^{
        _shareView.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_WIDTH/5, SCREEN_WIDTH, SCREEN_WIDTH/5);
        [_blackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    }];
}

- (void)clickBackGround:( UITapGestureRecognizer *)gesture{
    [UIView animateWithDuration:0.2 animations:^{
        _shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH/5);
        _blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [_shareView removeFromSuperview];
        [_blackView removeFromSuperview];
        _shareView = nil;
        _blackView = nil;
    }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = [_webViewUrl stringByAppendingString:@"&&a"];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"蚁淘购" image:[UIImage imageNamed:@"share_icon"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                
            }
        }];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [SVProgressHUD dismiss];
    
}

/**
 分享回调
 */
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response{
    
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:self.webTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self addItemButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.webView];
}

- (ShareView *)shareView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"share_icon"]];
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH/5)];
        [_shareView clickShareImg:^(NSInteger shareNumber) {
            if (shareNumber == 0) {
                [UMSocialData defaultData].extConfig.wechatSessionData.url = [_webViewUrl stringByAppendingString:@"&&a"];
                [UMSocialData defaultData].extConfig.wechatSessionData.title = _shopName;
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"我在蚁淘购发现了一个不错的商品，赶快来看看吧。" image:imageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        [self clickBackGround:nil];
                    }
                }];
            }
            if (shareNumber == 1) {
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = [_webViewUrl stringByAppendingString:@"&&a"];
                [UMSocialData defaultData].extConfig.wechatTimelineData.title = _shopName;
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"我在蚁淘购发现了一个不错的商品，赶快来看看吧。" image:imageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        [self clickBackGround:nil];
                    }
                }];
            }
            if (shareNumber == 2) {
                [UMSocialData defaultData].extConfig.qzoneData.url = [_webViewUrl stringByAppendingString:@"&&a"];
                [UMSocialData defaultData].extConfig.qzoneData.title = _shopName;
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"我在蚁淘购发现了一个不错的商品，赶快来看看吧。" image:imageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        [self clickBackGround:nil];
                    }
                }];
            }
            
            if (shareNumber == 3) {
                [UMSocialData defaultData].extConfig.sinaData.urlResource.url = [_webViewUrl stringByAppendingString:@"&&a"];
                
                [UMSocialData defaultData].extConfig.sinaData.shareText = _shopName;
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"我在蚁淘购发现了一个不错的商品，赶快来看看吧。" image:imageView.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        [self clickBackGround:nil];
                    }
                }];
            }
        }];
    }
    return _shareView;
}

- (UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _blackView;
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
//        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.dataDetectorTypes = UIDataDetectorTypeLink;
        _webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    }
    return _webView;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    //    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
    //    [SVProgressHUD showWithStatus:@"" maskType:1];
}

/**
 *  原始交互
 *
 *  @param webView
 *  @param request
 *  @param navigationType
 *
 *  @return
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSLog(@"%@",[url scheme]);
    if ([[url scheme] isEqualToString:@"myapp"]) {
        //        [self.rdv_tabBarController setSelectedIndex:2];
        ShopCarIndependenceViewController *viewController = [[ShopCarIndependenceViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[url scheme] isEqualToString:@"login"]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[url scheme] isEqualToString:@"teambuying"]) {
        NSString *subStr = [NSString stringWithFormat:@"%@",url];
        NSString *aaa= [subStr substringFromIndex:13];
        NSLog(@"%@",aaa);
        NSArray *array = [aaa componentsSeparatedByString:@"-"];
        PushOrderViewController *viewController = [[PushOrderViewController alloc] init];
        viewController.shopCarArray = array;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    return YES;
}

- (void)reloadWebView:(NSString *)urla{
    NSURL *url            = [NSURL URLWithString:urla];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
