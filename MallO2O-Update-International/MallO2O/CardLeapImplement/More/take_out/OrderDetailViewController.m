//
//  OrderDetailViewController.m
//  CardLeap
//
//  Created by lin on 1/5/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "RviewDishListViewController.h"
#import "UMSocial.h"
#import "NSDictionary+RequestEncoding.h"
@interface OrderDetailViewController ()<UIWebViewDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
{
    NSString *delete_order_id;
    NSString *timely ;
    NSString *confirmId ;
    NSString *confirmStatus;
    //    NSTimer *timer;
    NSMutableArray *dishArray;
    //call phone web
    UIWebView *phoneWeb;
    NSMutableArray *phoneNumberArray;
    NSString *share_url;
}
@property (strong, nonatomic) UIWebView *orderDetailWeb;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIButton *backButton;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark --- 2015.12.24 删除web页间隔自动刷新功能。
    [self setUI];
    [self loadHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-----------get Data
-(void)getDataFromNet
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"takeout_status_message"];
    NSDictionary *dict = @{
                           @"order_id":self.order_id,
                           @"app_key":url
                           };
    [SVProgressHUD showWithStatus:@"正在加载订单"];
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            [SVProgressHUD dismiss];
            //----get share_url-------------------
            share_url = [NSString stringWithFormat:@"%@",[resultObject[@"obj"] objectForKey:@"share_url"]];
            //----save dishes array---------------
            dishArray = [[NSMutableArray alloc] init ];
            NSArray *arr = [resultObject[@"obj"] objectForKey:@"order_desc"];
            for (NSDictionary *dict in arr) {
                [dishArray addObject:dict];
            }
            //----pass data to html test----------
            NSMutableDictionary *dic = (NSMutableDictionary*)resultObject;
            NSString *methodContent=[dic jsonEncodedKeyValueString];
            NSString *info = [NSString stringWithFormat:@"%@(%@)",@"takeout_message",methodContent];
            //拼接html的web数据
            [_orderDetailWeb stringByEvaluatingJavaScriptFromString:info];
            if ([[resultObject[@"obj"] objectForKey:@"comfirm_status"] integerValue]==5 || [[resultObject[@"obj"] objectForKey:@"comfirm_status"] integerValue]==3) {
                //                [timer invalidate];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

    }

-(void)updateMessageForOrder
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"takeout_status_message"];
    NSDictionary *dict = @{
                           @"order_id":self.order_id,
                           @"app_key":url
                           };
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            [SVProgressHUD dismiss];
            //----pass data to html test----------
            NSMutableDictionary *dic = (NSMutableDictionary*)resultObject;
            NSString *methodContent=[dic jsonEncodedKeyValueString];
            NSString *info = [NSString stringWithFormat:@"%@(%@)",@"takeout_message_two",methodContent];
            //拼接html的web数据
            [_orderDetailWeb stringByEvaluatingJavaScriptFromString:info];
            if ([[resultObject[@"obj"] objectForKey:@"comfirm_status"] integerValue]==5 || [[resultObject[@"obj"] objectForKey:@"comfirm_status"] integerValue]==3) {
                //                [timer invalidate];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];
}

#pragma mark-----------load html
-(void)loadHTML
{
    _orderDetailWeb.scrollView.showsVerticalScrollIndicator = NO;
    NSURL *url = [NSURL URLWithString:self.takeout_url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    _orderDetailWeb.scalesPageToFit = NO;
    [_orderDetailWeb loadRequest:request];
}

#pragma mark-----------get UI
-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(-20, -20, 0, 20);
        [_backButton setImage:[UIImage imageNamed:@"navbar_return_no"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"navbar_return_sel"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIWebView *)orderDetailWeb
{
    if (!_orderDetailWeb) {
        _orderDetailWeb = [[UIWebView alloc] initForAutoLayout];
        _orderDetailWeb.backgroundColor = [UIColor whiteColor];
        _orderDetailWeb.delegate = self;
    }
    return _orderDetailWeb;
}

-(UIButton *)shareButton·
{
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        [_shareButton setImage:[UIImage imageNamed:@"navtakeout_send_no"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"navtakeout_send_sel"] forState:UIControlStateHighlighted];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

#pragma mark-----------set UI
-(void)setUI
{
    [self.view addSubview:self.orderDetailWeb];
    [_orderDetailWeb autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_orderDetailWeb autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [_orderDetailWeb autoPinEdgeToSuperviewEdge:ALEdgeTop  withInset:0.0f];
    [_orderDetailWeb autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    
    if (![self.identifier isEqualToString:@"1"]) {
        //set back button
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        self.navigationItem.leftBarButtonItem = leftBar;
    }
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    //[self initTimer];
}

-(void)updateOrderState
{
    //    [self updateMessageForOrder];
    [self loadHTML];
}

#pragma mark-----------webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSLog(@"scheme:%@",url.scheme);
    if([url.scheme isEqualToString:@"review"]){
        // 弹出评价页面
        [self goToReview];
    }
    return YES;
}

#pragma mark-----------alertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self deleteOrder:delete_order_id];
        }
    }else if(alertView.tag == 2){
        if (buttonIndex == 0) {
            timely = @"0";
        }else{
            timely = @"1";
        }
        [self confirmOrder:confirmId status:confirmStatus];
    }else if (alertView.tag == 3){
        if (buttonIndex == 1) {
            [UZCommonMethod callPhone:phoneNumberArray[0] superView:self.view];
        }else if (buttonIndex == 2){
            [UZCommonMethod callPhone:phoneNumberArray[1] superView:self.view];
        }
    }
}

#pragma mark-----------button action
-(void)shareAction:(UIButton*)sender
{
    NSLog(@"分享订单");
    if (share_url != nil) {
        NSString *url = share_url;
        NSString *sinaText = [NSString stringWithFormat:@"如e生活 %@",url];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:sinaText
                                         shareImage:nil
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToSms]
                                           delegate:self];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"如e生活";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    }
}

-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    NSLog(@"分享成功");
}

-(void)backAction:(UIButton*)sender
{
    NSLog(@"返回主界面");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark-----------order function
-(void)deleteOrder:(NSString*)order_id
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_status"];
    NSDictionary *dict = @{
                           @"app_key":url,
                           @"order_id":order_id
                           };
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            [SVProgressHUD dismiss];
            [self updateMessageForOrder];
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

}

-(void)confirmOrder:(NSString*)order_id status :(NSString*)status
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"update_status"];
    NSDictionary *dict = @{
                           @"app_key":url,
                           @"order_id":order_id,
                           @"confirm_status":status,
                           @"timely":timely
                           };
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            [SVProgressHUD dismiss];
            [self updateMessageForOrder];
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

}
-(void)call_phone:(NSString*)phone_num
{
    NSString *phoneNumber = phone_num;// 电话号码
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    phoneWeb=[[UIWebView alloc]init];
    if ( !phoneWeb ) {
        phoneWeb = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [phoneWeb loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

-(void)goToReview
{
    RviewDishListViewController *firVC = [[RviewDishListViewController alloc] init];
    [firVC setNavBarTitle:@"待评价菜品" withFont:14.0f];

    firVC.order_id = self.order_id;
    [self.navigationController pushViewController:firVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateOrderState];
}

@end
