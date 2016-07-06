//
//  RegistViewController.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>

@end

@implementation RegistViewController{
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
    _passTextField.secureTextEntry = YES;
    
    _codeButton.layer.cornerRadius = 3;
    _codeButton.layer.masksToBounds = YES;
    
    _registButton.layer.cornerRadius = 4;
    _registButton.layer.masksToBounds = YES;
    
    self.telNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telNumTextField.delegate = self;
    
    self.telNumTextField.placeholder = NSLocalizedString(@"registAccountPlaceholder", nil);
    self.codeTextField.placeholder   = NSLocalizedString(@"registVerificationCodePlaceholder", nil);
    self.passTextField.placeholder   = NSLocalizedString(@"registPasswordAccountPlaceholder", nil);
    [self.codeButton setTitle:NSLocalizedString(@"registGetVerificationCodeButtonTitle", nil) forState:UIControlStateNormal];
    [self.codeButton setTitle:NSLocalizedString(@"registGetVerificationCodeButtonTitle", nil) forState:UIControlStateHighlighted];
    
    [self.registButton setTitle:NSLocalizedString(@"registButtonTitle", nil) forState:UIControlStateNormal];
    [self.registButton setTitle:NSLocalizedString(@"registButtonTitle", nil) forState:UIControlStateHighlighted];
}

/**
 給textfield添加线
 */
- (void)addXian{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_registTextView addSubview:view];
    view = [[UIView alloc] initWithFrame:CGRectMake(20, _registTextView.frame.size.height / 3, SCREEN_WIDTH - 40, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_registTextView addSubview:view];
    view = [[UIView alloc] initWithFrame:CGRectMake(20, _registTextView.frame.size.height / 3 * 2, SCREEN_WIDTH - 40, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_registTextView addSubview:view];
    view = [[UIView alloc] initWithFrame:CGRectMake(0, _registTextView.frame.size.height, SCREEN_WIDTH, 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_registTextView addSubview:view];
}

#pragma mark 验证码点击事件
- (IBAction)codeButton:(UIButton *)sender {
    NSLog(@"获取验证码");
    if ([self checkTel:self.telNumTextField.text]==YES)
    {
        __block int timeout=59;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [sender setTitle:NSLocalizedString(@"registGetVerificationCodeButtonTitle", nil) forState:UIControlStateNormal];
                    sender.userInteractionEnabled = YES;
                });
            }else{
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [sender setTitle:[NSString stringWithFormat:@"%@s %@",strTime, NSLocalizedString(@"forgetPasswordRetransmission", nil)] forState:UIControlStateNormal];
                    sender.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        NSString* name=self.telNumTextField.text;
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"send_code"];//connect_url(@"send_code");
        NSDictionary* dict=@{
                             @"type":@"1",
                             @"user_name" : name,
                             @"app_key": url,
                             };
        
        [self swpPublicTooGetDataToServer:url parameters:dict isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            NSDictionary* dic=(NSDictionary*)resultObject;
            codeString = resultObject[@"obj"];
            NSLog(@"get message:%@",[dic objectForKey:@"message"]);
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:NSLocalizedString(@"registGetVerificationCodeButtonTitle", nil) forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
            [SVProgressHUD showSuccessWithStatus:errorMessage];

            
        }];
        
//        [Base64Tool postSomethingToServe:url andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//            NSLog(@"%@",param);
//            if ([param[@"code"] integerValue] == 200) {
//                NSDictionary* dic=(NSDictionary*)param;
//                codeString = param[@"obj"];
//                NSLog(@"get message:%@",[dic  objectForKey:@"message"]);
//                [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//            }else{
//                dispatch_source_cancel(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
//                    sender.userInteractionEnabled = YES;
//                });
//                [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//            }
//            //            _checkCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"obj"]];
//        } andErrorBlock:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:@"网络不给力,稍后重试"];
//        }];
    }
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
    if (![UZCommonMethod inputString:_telNumTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
    if ([_codeTextField.text isEqualToString:codeString]) {
        if (_telNumTextField.text != nil && ![_telNumTextField.text isEqualToString:@""]) {
            if (_codeTextField.text != nil && ![_codeTextField.text isEqualToString:@""]) {
                if (_passTextField.text != nil && ![_passTextField.text isEqualToString:@""]) {
                    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_reg"];//connect_url(@"yz_reg");
                    if (self.regType == nil) {
                        self.regType = @"0";
                        self.thirdID = @"0";
                    }
                    NSDictionary *dic = @{
                                          @"app_key" : url,
                                          @"user_name" : _telNumTextField.text,
                                          @"user_pass" : _passTextField.text,
                                          @"reg_type" : self.regType,
                                          @"th_id" : self.thirdID
                                          };
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
                    
                    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
                        [self.navigationController popViewControllerAnimated:YES];
                        if (self.thirdID != nil) {
                            NSArray *vcArray = self.navigationController.viewControllers;
                            for (MallO2OBaseViewController *viewController in vcArray) {
                                if ([viewController isKindOfClass:[LoginViewController class]]) {
                                    LoginViewController *loginVC = (LoginViewController *)viewController;
                                    if (![self.thirdID isEqualToString:@"0"] && self.thirdID != nil) {
                                        [loginVC thirdID:self.thirdID reg:self.regType];
                                    }
                                    [self.view endEditing:YES];
                                    [self.navigationController popToViewController:loginVC animated:YES];
                                }
                            }
                        }

                    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
                        [SVProgressHUD showErrorWithStatus:errorMessage];
                    }];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"forgetPasswordCheckVerificationCode", nil)];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"forgetPasswordCheckVerificationCode", nil)];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"registAccountPlaceholder", nil)];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"forgetPasswordCheckVerificationCode", nil)];
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
