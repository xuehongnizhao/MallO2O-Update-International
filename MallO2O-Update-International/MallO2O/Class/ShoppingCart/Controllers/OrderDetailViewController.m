//
//  OrderDetailViewController.m
//  MallO2O
//
//  Created by mac on 15/6/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "LoginViewController.h"
#import "OrderGradingViewController.h"
#import "PushOrderViewController.h"
#import "RechargeSuccessViewController.h"

#import "OneBuySuccessViewController.h"

#import <Base64nl/Base64.h>

/**
 支付宝SDK
 */
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "DataSigner.h"

#import "Base64.h"
#import "Pingpp.h"

@interface OrderDetailViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;

@end

@implementation OrderDetailViewController{
    NSArray *payOrderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    payOrderArray = [[NSArray alloc] init];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.webTitle isEqualToString:@"开心大转盘"] || [self.webTitle isEqualToString:@"摇一摇"]) {
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"user_point"];
        NSDictionary *dic = @{
                              @"app_key" : url,
//                              @"u_id" : GetUserDefault(U_ID)
                              @"u_id"    : [PersonInfoModel shareInstance].uID
                              };
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            [PersonInfoModel shareInstance].myJifen = resultObject[@"obj"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
        }];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    [self.view addSubview:self.webView];
//    _webView.detectsPhoneNumbers=NO;
    _webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setNavBarTitle:self.webTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    NSURL *url            = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)popViewController{
    if (self.canGoRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        if ([_identifier integerValue] == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

/**
 webview的代理方法 用于与web页交互
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSLog(@"%@",[url scheme]);
    
    if([[url scheme] isEqualToString:@"gotoappraisal"]){
        NSString *urlStr = [NSString stringWithFormat:@"%@",url];
        NSString *subStr = [urlStr substringFromIndex:16];
        NSArray *orderInfoArray = [subStr componentsSeparatedByString:@"-"];
        OrderGradingViewController *viewController = [[OrderGradingViewController alloc] init];
        viewController.order_id = orderInfoArray[0];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[url scheme] isEqualToString:@"tel"]) {
        NSString *telNumber = [url host];
        [UZCommonMethod callPhone:telNumber superView:self.view];
    }
    if ([[url scheme] isEqualToString:@"gopay"]) {
        if ([GetUserDefault(IsLogin) boolValue]) {
            NSString *str = [NSString stringWithFormat:@"%@",url];
            str = [str substringFromIndex:8];
            NSLog(@"%@",str);
            payOrderArray = [str componentsSeparatedByString:@"-"];
            [self clientAlipay];
        }
    }
    if ([[url scheme] isEqualToString:@"cz"]) {
        NSLog(@"%@",url);
        if ([self.webTitle isEqualToString:@"一元购"]) {
            id json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBase64EncodedString:[[NSString stringWithFormat:@"%@",url] substringFromIndex:5]] options:0 error:nil];
            NSDictionary *dic = (NSDictionary *)json;
            [self getPingpp:dic[@"obj"] andInputMoney:@"0"];
            return YES;
        }
        NSString *ping = [NSString stringWithFormat:@"%@",url.host];
        NSArray *pingArray = [ping componentsSeparatedByString:@"-"];
        [self getPingggFromData:pingArray];
    }
    return YES;
}


- (void)getPingggFromData:(NSArray *)array{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"zhifu_an"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"pay_type" : array[0],
                          @"u_id" : array[1],
                          @"sale_price" : array[2],
                          @"all_price" : array[3]
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [self getPingpp:resultObject[@"obj"] andInputMoney:array[3]];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (void) getPingpp:(NSObject *)charge andInputMoney:(NSString *)inputMoney{
    NSDictionary *dic = (NSDictionary *)charge;
    NSString *money = [NSString stringWithFormat:@"%0.2f",[dic[@"amount"] floatValue]/100];
    if ([self.webTitle isEqualToString:@"一元购"]) {
        money = [NSString stringWithFormat:@"%0.2f",[dic[@"0"][@"price"] floatValue]/100];
        charge = dic[@"ping"];
    }
    [Pingpp createPayment:charge viewController:self appURLScheme:nil withCompletion:^(NSString *result, PingppError *error){
        [SVProgressHUD dismiss];
        NSLog(@"%@", result);
        if ([result isEqualToString:@"success"]) {
            // 支付成功
            NSLog(@"成功");
            if ([self.webTitle isEqualToString:@"一元购"]) {
                OneBuySuccessViewController *viewController = [[OneBuySuccessViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
                return ;
            }
            PersonInfoModel *info = [PersonInfoModel shareInstance];
            float moneyd = [info.myMoney floatValue] + [money floatValue];
            info.myMoney = [NSString stringWithFormat:@"%.2f",moneyd];
            RechargeSuccessViewController *viewController = [[RechargeSuccessViewController alloc] init];
            viewController.payMoneyText = [NSString stringWithFormat:@"成功充值%@元",inputMoney];
            viewController.successType = @"1";
            [self.navigationController pushViewController:viewController animated:YES];
        } else {
            // 支付失败或取消
            NSLog(@"Error: code=%d msg=%@", error.code, [error getMsg]);
            if (error.code == 5) {
                [SVProgressHUD showErrorWithStatus:@"取消支付"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                //                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}

/**
 跳转支付宝支付
 */
-(void)clientAlipay{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088801332045787";
    NSString *seller = @"master@youdro.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMRHDv/As4J3UqmzCGEja7LCpLrV9cuz9FueRVHHd3LMpKkABIguRyi0bUYZCGfv2AfbdCBjKil+Z+W6Uu2F3a4ppR4OzLU7o1c81eHBpcOTSRRmLNVEDCcsH48ZVIUIp9jI1ZpTVs26l7KYVOPBBpOy5lWMHlrF0fG5vw0/Xd21AgMBAAECgYEAmLg1ing09JHFhvcf0P1PgkMDC8EJRFucCWGHzE7ouTFT+Y9i91cS1TA2SjGWIdE0BUETBVRDbQ/G5a/pcJkVV12Com0rEjJ3FwpzjE+Jcqgu+18sEHMSKL0XLY6z7ZZnXIqOrGNoIf7V9QH5ScP+wOG3YMAwtGIp6W+J5NtJgU0CQQDyA52Qd+McS/GwWQy77bg9Xsr3qGhkpKUbr4C8EeUNiCUxCEYQ6wN6zIO6nuA/Js1Yhx0Hv5L4PxQnAvEMO8gzAkEAz57PtbFSrKqUmKYa7K3MAFsnx6aFIAMyzro7lnWGNclITLKFYfYBv60KwBmMI2eTEDSvvHmLuxZk8C5TL6b6dwJBAL5N1YKaoz3HAiAXhgno3i1z8spX5O7vAN4KXYKF18WSPxyVUvNOuge/9f2znMZL7sEkTdGf9SO8Bk6+42kpQT0CQAWDJeihCJzk+oUDA/v8sUnhIbE/TpGHBDZQ43wfKq0K5wyCQOBU877vDTYEd6AJA/KOM4xBfeA9u/hUgojlWgkCQQDesuKI92RLe96Wcrt5YYERsiX2IbvmQ67Wj/js8PR7PnYx/uS1RP7hUaSAb8ugZX/H9ZsuKd6ZlXMWo35iw3VT";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = payOrderArray[0]; //订单ID（由商家自行制定）
    order.productName = @"蚁淘商品订单"; //商品标题
    order.productDescription = @"优质生活，尽在蚁淘！"; //商品描述
    
    order.amount = payOrderArray[1]; //商品价格
//    order.notifyURL =  @"shop.youzhiapp.com/action/phoneAlipay/notify_url"; //回调URL
    order.notifyURL =  @"yitao.youzhiapp.com/action/phoneAlipay/notify_url";
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    /*
     ===========
     应用注册scheme,在AlixPayDemo-Info.plist定义URL types 用于快捷支付成功后重新唤起商户应用
     ===========
     */
    NSString *appScheme = @"mallo2o";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            BOOL is_success = NO;
            NSString *resultSting = resultDic[@"result"] ;
            NSArray *resultStringArray =[resultSting componentsSeparatedByString:NSLocalizedString(@"&", nil)];
            for (NSString *str in resultStringArray)
            {
                NSString *newstring = nil;
                newstring = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSArray *strArray = [newstring componentsSeparatedByString:NSLocalizedString(@"=", nil)];
                for (int i = 0 ; i < [strArray count] ; i++)
                {
                    NSString *st = [strArray objectAtIndex:i];
                    if ([st isEqualToString:@"success"])
                    {
                        is_success = YES;
                        NSLog(@"%@",[strArray objectAtIndex:1]);
                        break;
                    }
                }
                //跳出循环判断
                if (is_success) {
                    break;
                }
            }
            
            //判断支付成功 去跳转到支付成功页面  ---访问后台接口为准
            if ([resultDic[@"resultStatus"] integerValue] == 9000 && is_success) {
                //                GroupPaySuccessViewController *firVC = [[GroupPaySuccessViewController alloc] init];
                //                [firVC setHiddenTabbar:YES];
                //                [firVC setNavBarTitle:@"支付成功" withFont:14.0f];
                //                firVC.passArray = array;
                //                firVC.order_id = order_ids;
                //                firVC.messageDict  = self.dict;
                //                //firVC.info = self.info;
                //                [self.navigationController pushViewController:firVC animated:YES];
                [self.webView reload];
            }else
            [self.webView reload];
        }];
    }
}

- (void)reloadWebView:(NSString *)urla{
    [_webView removeFromSuperview];
    _webView = nil;
    [self setUI];
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
