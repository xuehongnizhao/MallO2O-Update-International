//
//  ThirdRegistViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ThirdRegistViewController.h"
#import "LoginViewController.h"

@interface ThirdRegistViewController ()<UITextFieldDelegate>

@end

@implementation ThirdRegistViewController{
    NSString *codeString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    codeString = [[NSString alloc] init];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
}

/**
 初始化UI
 */
- (void)initUI{
    
    self.telTextField.placeholder = NSLocalizedString(@"loginAccountPlaceholder", nil);
    self.passWordTextField.placeholder = NSLocalizedString(@"loginPasswordPlaceholder", nil);
    
    [self.registButton setTitle:NSLocalizedString(@"loginRegister", nil) forState:UIControlStateNormal];
    [self.registButton setTitle:NSLocalizedString(@"loginRegister", nil) forState:UIControlStateHighlighted];
    
    [self setUI];
    [self setNavi];
    [self addXian];
}

/**
 设置导航栏
 */
- (void)setNavi{
    [self setNavBarTitle:self.naviTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 设置控件
 */
- (void)setUI{
    _passWordTextField.secureTextEntry = YES;
    
    _registButton.layer.cornerRadius = 4;
    _registButton.layer.masksToBounds = YES;
    
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telTextField.delegate = self;
}

/**
 給textfield添加线
 */
- (void)addXian{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textViews addSubview:view];
    view = [[UIView alloc] initWithFrame:CGRectMake(20, _textViews.frame.size.height /  2, SCREEN_WIDTH - 40, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textViews addSubview:view];
    view = [[UIView alloc] initWithFrame:CGRectMake(0, _textViews.frame.size.height, SCREEN_WIDTH, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textViews addSubview:view];
}

#pragma mark----------检查用户输入手机号，尚未确定如何验证
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] != 11)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"loginCleckAccount", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //    //1[0-9]{10}
    //
    //    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    //    NSString *regex = @"[0-9]{11}";
    //    NSString *regex = @"^((13[0-9])|(147)|(17[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    BOOL isMatch = [pred evaluateWithObject:str];
    //    if (!isMatch)
    //    {
    //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        return NO;
    //    }
    //    if([passWord.text isEqualToString:@""])
    //    {
    //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    //
    //        [alert show];
    //        return NO;
    //    }
    return YES;
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 点击注册按钮
- (IBAction)registButton:(id)sender {
    if (![UZCommonMethod inputString:_telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
        if (_telTextField.text != nil && ![_telTextField.text isEqualToString:@""]) {
                if (_passWordTextField.text != nil && ![_passWordTextField.text isEqualToString:@""]) {
                    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_reg"];//connect_url(@"yz_reg");
                    if (self.regType == nil) {
                        self.regType = @"0";
                        self.thirdID = @"0";
                    }
                    NSDictionary *dic = @{
                                          @"app_key" : url,
                                          @"user_name" : _telTextField.text,
                                          @"user_pass" : _passWordTextField.text,
                                          @"reg_type" : self.regType,
                                          @"th_id" : self.thirdID
                                          };
                    
                    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
                        [self.navigationController popViewControllerAnimated:YES];
                        if (self.thirdID != nil) {
                            NSArray *vcArray = self.navigationController.viewControllers;
                            for (MallO2OBaseViewController *viewController in vcArray) {
                                if ([viewController isKindOfClass:[LoginViewController class]]) {
                                    LoginViewController *loginVC = (LoginViewController *)viewController;
                                    [loginVC thirdID:self.thirdID reg:self.regType];
                                    [self.view endEditing:YES];
                                    [self.navigationController popToViewController:loginVC animated:YES];
                                }
                            }
                        }

                    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
                        [SVProgressHUD showErrorWithStatus:errorMessage];
                    }];
                    
//                    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//                        NSLog(@"%@",param);
//                        if ([param[@"code"] integerValue] == 200) {
//                            [self.navigationController popViewControllerAnimated:YES];
//                            if (self.thirdID != nil) {
//                                NSArray *vcArray = self.navigationController.viewControllers;
//                                for (MallO2OBaseViewController *viewController in vcArray) {
//                                    if ([viewController isKindOfClass:[LoginViewController class]]) {
//                                        LoginViewController *loginVC = (LoginViewController *)viewController;
//                                        [loginVC thirdID:self.thirdID reg:self.regType];
//                                        [self.view endEditing:YES];
//                                        [self.navigationController popToViewController:loginVC animated:YES];
//                                    }
//                                }
//                            }
//                        }else{
//                            [SVProgressHUD showErrorWithStatus:param[@"message"]];
//                        }
//                    } andErrorBlock:^(NSError *error) {
//                        
//                    }];
                    
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckPasswordNULLMessage", nil)];
                }
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccountNULLMessage", nil)];
        }
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    //    if ([textField.placeholder isEqualToString:@"请输入正确电话"]) {
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    //    }
    
    return YES;
}

@end
