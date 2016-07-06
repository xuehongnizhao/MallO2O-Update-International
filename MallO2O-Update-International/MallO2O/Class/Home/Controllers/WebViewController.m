//
//  WebViewController.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    [self.view addSubview:self.webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setNavBarTitle:self.webTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    NSURL *url            = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)popViewController{
    if ([_identifier integerValue] == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
    }
    return _webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSLog(@"%@",[url scheme]);
    if([[url scheme] isEqualToString:@"ordergradding"]){
    }
    
    return YES;
}

- (void)reloadWebView:(NSString *)urla{
    NSURL *url            = [NSURL URLWithString:urla];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
