//
//  LoginViewController.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgetPassViewController.h"
#import "ShoppingCartViewController.h"
#import "JPUSHService.h"
#import "UMSocial.h"

#import "ThirdRegistViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *thirdLoginPromptView;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self addUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([_identifier isEqualToString:@"1"]) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }else{
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 初始化数据
/**
    初始化数据
 */
- (void)initData{
    _usernameText.text = GetUserDefault(UserName);
    if ([GetUserDefault(IS_REMEBER) boolValue]) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sel_remember"]];
        _passwordText.text = GetUserDefault(PassWord);
        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
    }else{
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_remember"]];
        [_remImgButton setBackgroundImage:imgView.image forState
                                         :UIControlStateNormal];
    }
}

/**
   添加控件
 */
- (void)addUI{
    
    
    self.usernameText.placeholder = NSLocalizedString(@"loginAccountPlaceholder", nil);
    
    self.passwordText.placeholder = NSLocalizedString(@"loginPasswordPlaceholder", nil);
    
    
    [self.rememberPass setTitle:NSLocalizedString(@"loginRememberPassword", nil) forState:UIControlStateNormal];
    [self.rememberPass setTitle:NSLocalizedString(@"loginRememberPassword", nil) forState:UIControlStateHighlighted];
//    self.rememberPass.layer.borderWidth = 1;
    self.rememberPass.titleLabel.textAlignment = NSTextAlignmentRight;
    
    self.forgetPass.text = NSLocalizedString(@"loginForgetPassword", nil);
    
    [self.loginButton setTitle:NSLocalizedString(@"loginButtonTitle", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:NSLocalizedString(@"loginButtonTitle", nil) forState:UIControlStateHighlighted];
    
    self.thirdLoginPromptView.text = NSLocalizedString(@"loginThirdPartyLoginPromptTitle", nil);
    
    [self initUI];
    [self setNavi];
    [self setUI];
    
    
}

/**
    初始化控件
 */
- (void)initUI{
    /**
         咳咳
     */
    _qqLogin.layer.cornerRadius = _qqLogin.frame.size.height/2;
    _qqLogin.layer.masksToBounds = YES;
    [_qqLogin setBackgroundImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
    
    _wxLogin.layer.cornerRadius = _wxLogin.frame.size.height/2;
    _wxLogin.layer.masksToBounds = YES;
    [_wxLogin setBackgroundImage:[UIImage imageNamed:@"wx_login"] forState:UIControlStateNormal];
    
    _sinaLogin.layer.cornerRadius = _sinaLogin.frame.size.height/2;
    _sinaLogin.layer.masksToBounds = YES;
    [_sinaLogin setBackgroundImage:[UIImage imageNamed:@"sina_login"] forState:UIControlStateNormal];
    
    _passwordText.delegate = self;
}

/**
    设置控件
 */
- (void)setUI{
    /**
        无聊的设置，更改UI时可能需要修改
     */
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 4;
    
    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textFieldView addSubview:xian];
    xian = [[UIView alloc] initWithFrame:CGRectMake(20, _textFieldView.frame.size.height / 2, SCREEN_WIDTH - 40, 1)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textFieldView addSubview:xian];
    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _textFieldView.frame.size.height, SCREEN_WIDTH, 1)];
    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [_textFieldView addSubview:xian];
    
    _passwordText.secureTextEntry = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassGes)];
    _forgetPass.userInteractionEnabled = YES;
    [_forgetPass addGestureRecognizer:gesture];
}

/**
    忘记密码的点击事件
 */
- (void)forgetPassGes{
    ForgetPassViewController *viewController = [[ForgetPassViewController alloc] init];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
    设置导航栏
 */
- (void)setNavi{
    [self setNavBarTitle:NSLocalizedString(@"loginNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
//    [self setBackButton];
    [self setNaviRightButton];
}

/**
    导航栏右侧注册按钮
 */
- (void)setNaviRightButton{
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 50* Balance_Width, 30);
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    rightButton.titleLabel.textColor = [UIColor blackColor];
    rightButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -40);
    [rightButton setTitle:NSLocalizedString(@"loginRegister", nil) forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

/**
    实现注册的点击事件
 */
- (void)regist{
    RegistViewController *viewController = [[RegistViewController alloc] init];
    [self.view endEditing:YES];
    viewController.naviTitle = NSLocalizedString(@"loginRegister", nil);
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark  登录按钮
- (IBAction)loginButton:(id)sender {
    /**
        呵呵哒
     */
    if (_usernameText.text != nil && ![_usernameText.text isEqualToString:@""]) {
        if (_passwordText.text != nil && ![_passwordText.text isEqualToString:@""]) {
            [self loginWithUrl];
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckPasswordNULLMessage", nil)];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccountNULLMessage", nil)];
    }
}

#pragma mark---------设备号获取以及回调函数
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
}

#pragma mark----设置别名
-(void)setAlian :(NSString*)alian
{
    [JPUSHService setTags:nil alias:alian fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);

    }];
}

#pragma mark 记住密码
- (IBAction)rememberPass:(id)sender {
    NSLog(@"asdf");
    /**
        是否记住密码
        如果记住，本地存储一下，设置记住密码的图片
     */
    if ([GetUserDefault(IS_REMEBER) boolValue]) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_remember"]];
        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
        SetUserDefault(@"NO", IS_REMEBER);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sel_remember"]];
        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
        SetUserDefault(@"YES", IS_REMEBER);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark 登录上传数据
- (void)loginWithUrl{
    if (![UZCommonMethod inputString:_usernameText.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];
    SetUserDefault(_usernameText.text, UserName);
    if ([GetUserDefault(IS_REMEBER) boolValue]) {
        SetUserDefault(_passwordText.text, PassWord);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        SetUserDefault(@"", _passwordText.text);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"user_name" : _usernameText.text,
                          @"user_pass" : _passwordText.text,
                          @"reg_type" : @"0",
                          @"th_id" : @"0"
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        /*
         登录时本地存储一些数据  根据key能看出存储什么数据
         */
        SetUserDefault(@"YES", AUTOLOGIN);
        SetUserDefault(_usernameText.text, UserName);
        SetUserDefault(_passwordText.text, PassWord);
        SetUserDefault(@"", ThirdId);
        [[NSUserDefaults standardUserDefaults] synchronize];
        [UserModel mj_objectWithKeyValues:resultObject[@"obj"]];
        [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"]]];
        /**
         获取当前栈里的viewcontroller并变成一数组
         */
        NSArray *array = self.navigationController.viewControllers;
        /*
         定义一个购物车的控制器
         */
        ShoppingCartViewController *viewController = array[0];
        /*
         判断返回的上个界面是否是购物车的控制器
         如果是，pop时隐藏navigationbar
         如果不是，pop时什么都不管
         */
        [self.view endEditing:YES];
        if ([viewController isKindOfClass:[ShoppingCartViewController class]]) {
            [viewController.navigationController setNavigationBarHidden:YES];
            [self.navigationController popToViewController:viewController animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"loginSuccess", nil)];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
//    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        NSLog(@"%@",param);
//        if ([param[@"code"] integerValue] == 200) {
//            /*
//                登录时本地存储一些数据  根据key能看出存储什么数据
//             */
//            SetUserDefault(@"YES", AUTOLOGIN);
//            SetUserDefault(_usernameText.text, UserName);
//            SetUserDefault(_passwordText.text, PassWord);
//            SetUserDefault(param[@"obj"][@"u_id"], U_ID);
//            SetUserDefault(param[@"obj"], Person_Info);
//            SetUserDefault(param[@"obj"][@"vip"], Vip);
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [PersonInfoModel savePersonInfo:param[@"obj"]];
//            [self setAlian:[@"user_" stringByAppendingFormat:@"%@", param[@"obj"][@"u_id"]]];
//            /**
//                 获取当前栈里的viewcontroller并变成一数组
//             */
//            NSArray *array = self.navigationController.viewControllers;
//            /*
//                定义一个购物车的控制器
//             */
//            ShoppingCartViewController *viewController = array[0];
//            /*
//                判断返回的上个界面是否是购物车的控制器
//                如果是，pop时隐藏navigationbar
//                如果不是，pop时什么都不管
//             */
//            [self.view endEditing:YES];
//            if ([viewController isKindOfClass:[ShoppingCartViewController class]]) {
//                [viewController.navigationController setNavigationBarHidden:YES];
//                [self.navigationController popToViewController:viewController animated:YES];
//            }else{
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//        }else{
//            [SVProgressHUD showErrorWithStatus:param[@"message"]];
//        }
//    } andErrorBlock:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络异常"];
//
//    }];
    
}
/**
 qq登录
 */
- (IBAction)qqLogin:(id)sender {
    [self thirdLogin:UMShareToQQ andRegType:@"1"];
}

/**
 微信登录
 */
- (IBAction)wxLogin:(id)sender {
    [self thirdLogin:UMShareToWechatSession andRegType:@"3"];
}

/**
 新浪登录
 */
- (IBAction)sinaLogin:(id)sender {
    [self thirdLogin:UMShareToSina andRegType:@"2"];
}

- (void)thirdLogin:(NSString *)loginType andRegType:(NSString *)regType {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:loginType];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:loginType];
            SetUserDefault(snsAccount.openId, ThirdId);
            SetUserDefault(regType, LoginType);
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self thirdID:snsAccount.openId reg:regType];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

- (void)thirdID:(NSString *)thirdId reg:(NSString *)regType{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];//@"action/ac_user/yz_login";
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"reg_type" : regType,
                          @"th_id" : thirdId,
                          @"user_pass" : @"0"
                          };
    
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        /*
         登录时本地存储一些数据  根据key能看出存储什么数据
         */
        SetUserDefault(@"YES", AUTOLOGIN);
//        SetUserDefault(resultObject[@"obj"][@"u_id"], U_ID);
//        SetUserDefault(resultObject[@"obj"], Person_Info);
        [UserModel mj_objectWithKeyValues:resultObject[@"obj"]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
        /**
         获取当前栈里的viewcontroller并变成一数组
         */
        NSArray *array = self.navigationController.viewControllers;
        /*
         定义一个购物车的控制器
         */
        ShoppingCartViewController *viewController = array[array.count - 1];
        /*
         判断返回的上个界面是否是购物车的控制器
         如果是，pop时隐藏navigationbar
         如果不是，pop时什么都不管
         */
        [self.view endEditing:YES];
        if ([viewController isKindOfClass:[ShoppingCartViewController class]]) {
            [viewController.navigationController setNavigationBarHidden:YES];
            [self.navigationController popToViewController:viewController animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"loginSuccess", nil)];

    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        ThirdRegistViewController *viewController = [[ThirdRegistViewController alloc] init];
        viewController.regType = regType;
        viewController.thirdID = thirdId;
        viewController.naviTitle = NSLocalizedString(@"thirdRegistNavigationTitle", nil);
        [self.view endEditing:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];

    }];
}

- (IBAction)forgetLayer:(id)sender {
    NSLog(@"asdf");
    /**
     是否记住密码
     如果记住，本地存储一下，设置记住密码的图片
     */
    if ([GetUserDefault(IS_REMEBER) boolValue]) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_remember"]];
        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
        SetUserDefault(@"NO", IS_REMEBER);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sel_remember"]];
        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
        SetUserDefault(@"YES", IS_REMEBER);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return textField.textInputMode != nil;
}

@end
