//
//  OneBuySuccessViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/3.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "OneBuySuccessViewController.h"
#import "OrderDetailViewController.h"
#import "DicoverViewController.h"

@interface OneBuySuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *goOneBtn;
- (IBAction)clickGoOnButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
- (IBAction)clickHistoryButton:(id)sender;

@end

@implementation OneBuySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view fr[om its nib.
    [self setNavBarTitle:@"支付成功" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popViewController{
    NSArray *array = self.navigationController.viewControllers;
    for (MallO2OBaseViewController *vc in array) {
        if ([vc isMemberOfClass:[OrderDetailViewController class]]) {
            OrderDetailViewController *viewController = (OrderDetailViewController *)vc;
            [viewController reloadWebView:[NSString stringWithFormat:@"http://b2c.yitaoo2o.com/phone_web/yi_goods/yy_goods?u_id=%@",[PersonInfoModel shareInstance].uID]];
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickGoOnButton:(id)sender {
    [self popViewController];
}
    
- (IBAction)clickHistoryButton:(id)sender {
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webUrl = [@"http://b2c.yitaoo2o.com/phone_web/yi_goods/yy_list" stringByAppendingFormat:@"?u_id=%@",[PersonInfoModel shareInstance].uID];
    viewController.webTitle = @"参与记录";
    viewController.canGoRoot = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    return;
}
@end
