//
//  AboutUsViewController.m
//  MallO2O
//
//  Created by mac on 15/6/11.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *aboutWebView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    NSURL *url            = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_aboutWebView loadRequest:request];
    [SVProgressHUD showWithStatus:@"正在加载中"];
}

#pragma mark 添加控件
- (void)addUI{
    [self setNavi];
    _aboutWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _aboutWebView.delegate = self;
    [self.view addSubview:_aboutWebView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)setNavi{
    [self setNavBarTitle:_naviTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}


@end
