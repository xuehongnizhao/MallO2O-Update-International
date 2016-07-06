//
//  ForgetPassViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "ChangeForgetPassViewController.h"


@interface ForgetPassViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPassViewController{
    NSString *codeString;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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
    codeString = [[NSString alloc] init];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {

    self.telTextField.placeholder  = NSLocalizedString(@"forgetPasswordAccountPlaceholder", nil);

    self.codeTextField.placeholder = NSLocalizedString(@"forgetPasswordVerificationCodePlaceholder", nil);

    [self.getCode setTitle:NSLocalizedString(@"forgetPasswordGetVerificationCodeButtonTitle", nil) forState:UIControlStateNormal];
    [self.getCode setTitle:NSLocalizedString(@"forgetPasswordGetVerificationCodeButtonTitle", nil) forState:UIControlStateHighlighted];
    
    [self.nextButton setTitle:NSLocalizedString(@"forgetPasswordNextStepButtonTitle", nil) forState:UIControlStateNormal];
    [self.nextButton setTitle:NSLocalizedString(@"forgetPasswordNextStepButtonTitle", nil) forState:UIControlStateHighlighted];
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"forgetPasswordNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    self.telTextField.delegate = self;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    _getCode.layer.cornerRadius = 4;
    _getCode.layer.masksToBounds = YES;
    
    _nextButton.layer.cornerRadius = 4;
    _nextButton.layer.masksToBounds = YES;
    
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_forgetView addSubview:xian];
    
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _forgetView.frame.size.height/2, SCREEN_WIDTH - 40, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_forgetView addSubview:xian];
    
    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _forgetView.frame.size.height, SCREEN_WIDTH, 0.6)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_forgetView addSubview:xian];
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (IBAction)nextButton:(id)sender {
    if (self.telTextField.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
    }
    if (self.codeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if ([codeString isEqualToString:self.codeTextField.text]) {
        ChangeForgetPassViewController *viewController = [[ChangeForgetPassViewController alloc] init];
        [self.view endEditing:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"forgetPasswordCheckVerificationCode", nil)];
    }
}
- (IBAction)getCode:(UIButton *)sender {
    NSLog(@"获取验证码");
    if (![UZCommonMethod inputString:_telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
    if (self.telTextField.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
    if ([self checkTel:self.telTextField.text]==YES)
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
                    [sender setTitle:NSLocalizedString(@"forgetPasswordGetVerificationCode", nil) forState:UIControlStateNormal];
                    sender.userInteractionEnabled = YES;
                });
            }else{
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [sender setTitle:[NSString stringWithFormat:@"%@s %@", strTime, NSLocalizedString(@"forgetPasswordRetransmission", nil)] forState:UIControlStateNormal];
                    sender.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        NSString* name=self.telTextField.text;
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"send_code"];//connect_url(@"send_code");
        NSDictionary* dict=@{
                             @"type":@"2",
                             @"user_name" : name,
                             @"app_key": url,
                             };
        
        
        [self swpPublicTooGetDataToServer:url parameters:dict isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            NSDictionary* dic=(NSDictionary*)resultObject;
            codeString = resultObject[@"obj"];
            [SVProgressHUD showSuccessWithStatus:resultObject[@"messagegyy"]];
            NSLog(@"get message:%@",[dic  objectForKey:@"message"]);
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:NSLocalizedString(@"forgetPasswordGetVerificationCodeButtonTitle", nil) forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }];
        
//        [Base64Tool postSomethingToServe:urfl andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//            NSLog(@"%@",param);
//            if ([param[@"code"] integerValue] == 200) {
//                NSDictionary* dic=(NSDictionary*)param;
//                codeString = param[@"obj"];
//                [SVProgressHUD showSuccessWithStatus:param[@"messagegyy"]];
//                NSLog(@"get message:%@",[dic  objectForKey:@"message"]);
//            }else{
//                dispatch_source_cancel(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
//                    sender.userInteractionEnabled = YES;
//                });
//            }
//           
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
