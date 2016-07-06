//
//  ChangeForgetPassViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ChangeForgetPassViewController.h"
#import "LoginViewController.h"

@interface ChangeForgetPassViewController ()

@end

@implementation ChangeForgetPassViewController

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
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
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
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"changeForgetPasswordNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _surButton.layer.cornerRadius = 4;
    _surButton.layer.masksToBounds = YES;
    
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_changeForgetView addSubview:xian];
    
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _changeForgetView.frame.size.height/3, SCREEN_WIDTH - 40, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_changeForgetView addSubview:xian];
    
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _changeForgetView.frame.size.height/3*2, SCREEN_WIDTH - 40, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_changeForgetView addSubview:xian];
    
    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _changeForgetView.frame.size.height, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_changeForgetView addSubview:xian];
    
    self.userNameText.placeholder = NSLocalizedString(@"changeForgetPasswordAccountPlaceholder", nil);
    self.passwordText.placeholder = NSLocalizedString(@"changeForgetPasswordPleaseNewPassword", nil);
    self.surePassText.placeholder = NSLocalizedString(@"changeForgetPasswordPleaseConfirmThePassword", nil);
    
    [self.surButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
    [self.surButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateHighlighted];
    
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureButton:(id)sender {
    if (![UZCommonMethod inputString:_userNameText.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_edit_pass"];//connect_url(@"yz_edit_pass");
    if (_userNameText.text != nil && ![_userNameText.text isEqualToString:@""]) {
        if (_passwordText.text != nil && ![_passwordText.text isEqualToString:@""]) {
            if (_surePassText.text != nil && ![_surePassText.text isEqualToString:@""]) {
                NSDictionary *dic = @{
                                      @"app_key" : url,
                                      @"user_name" : _userNameText.text,
                                      @"user_pass" : _passwordText.text,
                                      @"user_pass2" : _surePassText.text
                                      };
                
                [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
                    [self.view endEditing:YES];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
                } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
                    [SVProgressHUD showErrorWithStatus:errorMessage];
                }];
                
//                [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//                    NSLog(@"%@",param);
//                    if ([param[@"code"] integerValue] == 200) {
//                        [self.view endEditing:YES];
//                        [self.navigationController popToRootViewControllerAnimated:YES];
//                        [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//                    }else{
//                        [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//                    }
//                } andErrorBlock:^(NSError *error) {
//                    [SVProgressHUD showSuccessWithStatus:@"网络异常"];
//                }];
                
            }else
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"changeForgetPasswordPleaseConfirmThePassword", nil)];
        }else
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckPasswordNULLMessage", nil)];
    }else
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccountNULLMessage", nil)];
    
}
@end
