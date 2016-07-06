//
//  ChangePassViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ChangePassViewController.h"

@interface ChangePassViewController ()<UITextFieldDelegate>

@end

@implementation ChangePassViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
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
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
    self.oldPassword.placeholder  = NSLocalizedString(@"changePassOldPasswordPlaceholder", nil);
    self.inputNewPass.placeholder = NSLocalizedString(@"changePassInputNewPasswordPlaceholder", nil);
    self.surPassword.placeholder  = NSLocalizedString(@"changePassConfirmNewPasswordPlaceholder", nil);

    [self.changeButton setTitle:NSLocalizedString(@"changePassSubmitButton", nil) forState:UIControlStateNormal];
    [self.changeButton setTitle:NSLocalizedString(@"changePassSubmitButton", nil) forState:UIControlStateHighlighted];
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
    [self setNavBarTitle:NSLocalizedString(@"changePassModifyPasswordNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _oldPassword.delegate = self;
    _inputNewPass.delegate = self;
    _surPassword.delegate = self;
    
    _changeButton.layer.cornerRadius = 4;
    _changeButton.layer.masksToBounds = YES;
    
    _oldPassword.font = [UIFont systemFontOfSize:15];
    
    _inputNewPass.font = [UIFont systemFontOfSize:15];
    
    _surPassword.font = [UIFont systemFontOfSize:15];
    
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_passBackView addSubview:xian];
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _passBackView.frame.size.height/3, SCREEN_WIDTH - 40, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_passBackView addSubview:xian];
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _passBackView.frame.size.height/3 * 2, SCREEN_WIDTH - 40, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_passBackView addSubview:xian];
    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _passBackView.frame.size.height, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
    [_passBackView addSubview:xian];
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

- (IBAction)changeButton:(id)sender {
    
    if (_oldPassword.text != nil && ![_oldPassword.text isEqualToString:@""]) {
        if (_inputNewPass.text != nil && ![_inputNewPass.text isEqualToString:@""]) {
            if (_surPassword.text != nil && ![_surPassword.text isEqualToString:@""]) {
                if (![_inputNewPass.text isEqualToString:_surPassword.text]) {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"changePassCheckNewPasswordsTitle", nil)];
                    return;
                }
                NSString *url = [SwpTools swpToolGetInterfaceURL:@"edit_pass"];
                NSDictionary *dic = @{
                                      @"app_key"  : url,
//                                      @"u_id"     : GetUserDefault(U_ID),
                                      @"u_id"     : [PersonInfoModel shareInstance].uID,
                                      @"old_pass" : _oldPassword.text,
                                      @"new_pass" : _inputNewPass.text
                                      };
                
                [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
                    [self.view endEditing:YES];
                    [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
                    [self.navigationController popViewControllerAnimated:YES];

                } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
                    [SVProgressHUD showErrorWithStatus:errorMessage];
                }];
                
                
//                [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//                    NSLog(@"%@",param);
//                    if ([param[@"code"] integerValue] == 200) {
//                        [self.view endEditing:YES];
//                        [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:param[@"message"]];
//                    }
//                } andErrorBlock:^(NSError *error) {
//                    [SVProgressHUD showErrorWithStatus:@"网络异常"];
//                }];
                
            }else
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"changePassCkeckOldPasswordsTitle", nil)];
        }
        else
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"changePassCkeckNewPasswordsNULLTitle", nil)];
    }else
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"changePassCkeckOlePasswordsNULLTitle", nil)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return textField.textInputMode != nil;
}

@end
