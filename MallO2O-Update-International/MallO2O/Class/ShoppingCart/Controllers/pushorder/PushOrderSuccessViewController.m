//
//  PushOrderSuccessViewController.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushOrderSuccessViewController.h"
#import "HomeViewController.h"
#import "OrderDetailViewController.h"

@interface PushOrderSuccessViewController ()

@end

@implementation PushOrderSuccessViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
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
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    [self setUI];
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:@"提交成功" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    
}

/**
    设置控件
 */
- (void)setUI{
    _seeOrder.layer.cornerRadius = 5;
    _seeOrder.layer.masksToBounds = YES;
    
    _backMainView.layer.cornerRadius = 5;
    _backMainView.layer.masksToBounds = YES;
    
    _pushSuccessMoney.text = _totalMoney;
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (IBAction)seeOrder:(id)sender {
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webUrl = self.webUrl;
    viewController.webTitle = NSLocalizedString(@"orderDetailNavigationTitle", nil);
    viewController.identifier = @"1";
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)backMainView:(id)sender {
    SetUserDefault(@"返回首页", @"back_home_view");
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.rdv_tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
