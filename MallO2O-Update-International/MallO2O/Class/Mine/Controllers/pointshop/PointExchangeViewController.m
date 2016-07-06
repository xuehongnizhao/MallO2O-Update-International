//
//  PointExchangeViewController.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointExchangeViewController.h"
#import "ExchangeMessageViewController.h"
#define Complete 530/1080


@interface PointExchangeViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIImageView *pointImgView;

@property (strong ,nonatomic) UILabel *pointLabel;

@property (strong ,nonatomic) UIButton *exchangeButton;

@property (strong ,nonatomic) UIWebView *webView;

@end

@implementation PointExchangeViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self setWebVIewInfo];
    _webView.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",_model);
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
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
}

- (void)setWebVIewInfo{
    NSURL *url            = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
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

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:@"礼品详情" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _pointImgView = [[UIImageView alloc] initForAutoLayout];
    [self.view addSubview:_pointImgView];
    _pointImgView.layer.borderWidth = 0.6;
    
    _pointLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:_pointLabel];
    
    _exchangeButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:_exchangeButton];
    
    _webView = [[UIWebView alloc] initForAutoLayout];
    [self.view addSubview:_webView];
    _webView.delegate = self;
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_pointImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-0.6];
    [_pointImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-0.6];
    [_pointImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-0.6];
    [_pointImgView autoSetDimension:ALDimensionHeight toSize:SCREEN_WIDTH * Complete];
    [_pointImgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _pointImgView.layer.borderColor = [UIColorFromRGB(0xe3e3e3) CGColor];
    
    [_pointLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pointImgView withOffset:5 * Balance_Heith];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:100];
    [_pointLabel autoSetDimension:ALDimensionHeight toSize:30 * Balance_Heith];
    _pointLabel.text = [_pointText stringByAppendingString:@"积分"];
    _pointLabel.textColor = UIColorFromRGB(0xf34453);
    
    [_exchangeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_exchangeButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pointImgView withOffset:5 * Balance_Heith];
    [_exchangeButton autoSetDimension:ALDimensionHeight toSize:30 * Balance_Heith];
    [_exchangeButton autoSetDimension:ALDimensionWidth toSize:90 * Balance_Width];
    [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:14 * Balance_Width];
    _exchangeButton.layer.cornerRadius = 4;
    _exchangeButton.layer.masksToBounds = YES;
    _exchangeButton.backgroundColor = UIColorFromRGB(0xf54635);
    [_exchangeButton addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];
    
    [_webView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pointLabel withOffset:5 * Balance_Heith];
    [_webView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-0.6];
    [_webView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-0.6];
    [_webView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-0.6];
    _webView.layer.borderWidth = 0.6;
    _webView.layer.borderColor = [UIColorFromRGB(0xe3e3e3) CGColor];
}

- (void)exchange{
    ExchangeMessageViewController *viewController = [[ExchangeMessageViewController alloc] init];
    viewController.pointShop = self.model;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
