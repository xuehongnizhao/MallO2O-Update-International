//
//  RechargeSuccessViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "RechargeSuccessViewController.h"
#import "OrderDetailViewController.h"
#import "DicoverViewController.h"

@interface RechargeSuccessViewController ()

@end

@implementation RechargeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackButton];
    [self setNavBarTitle:@"充值成功" withFont:NAV_TITLE_FONT_SIZE];
    self.payMoney.text = self.payMoneyText;
}

- (void)popViewController{
    NSArray *array = self.navigationController.viewControllers;
    for (MallO2OBaseViewController *vc in array) {
        if ([vc isMemberOfClass:[OrderDetailViewController class]]) {
            OrderDetailViewController *viewController = (OrderDetailViewController *)vc;
            [viewController reloadWebView:[NSString stringWithFormat:@"http://b2c.yitaoo2o.com/phone_web/yi_goods/yy_goods?u_id=%@",[UserModel shareInstance].u_id]];
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rechargeHistory:(id)sender {
//    if ([self.successType integerValue] == 1) {
//        OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
//        viewController.webUrl = [NSString stringWithFormat:@"http://o2omall.youzhiapp.com/action/ac_shop/chongzhi_list?u_id=%@",[UserModel shareInstance].u_id];
//        viewController.webTitle = @"消费记录";
//        viewController.canGoRoot = YES;
//        [self.navigationController pushViewController:viewController animated:YES];
//        return;
//    }
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webUrl = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_shop/chongzhi_list?u_id=%@",[UserModel shareInstance].u_id];
    viewController.webTitle = @"充值记录";
    viewController.canGoRoot = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)backToHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
