//
//  MoreViewController.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "AboutUsViewController.h"
#import "JPUSHService.h"
#import "OpinionViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong ,nonatomic) UITableView *moreTableView;

@end

@implementation MoreViewController{
    NSArray *tableViewArray;
    NSArray *tableViewImgArray;
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
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    if (_opinionMessage != nil) {
        [SVProgressHUD showSuccessWithStatus:_opinionMessage];
        _opinionMessage = nil;
    }
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    tableViewArray = @[
                       @[NSLocalizedString(@"moreAboutApp", nil),
                         NSLocalizedString(@"morePrivacyRights", nil)
                         ],
                       @[NSLocalizedString(@"Feedback", nil),
                         NSLocalizedString(@"moreGiveMeAGrade", nil)
                         ],
                       @[NSLocalizedString(@"moreUseHelp",  nil),
                         NSLocalizedString(@"moreCodeSharing", nil),
                         ],
                       @[NSLocalizedString(@"moreClearCache", nil),
                         NSLocalizedString(@"moreExitLogin", ni)]];
    tableViewImgArray = @[@[@"more_1",@"more_2"],@[@"more_3",@"more_4"],@[@"more_5",@"more_6"],@[@"more_7",@"more_8"]];}

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
    [self setNavBarTitle:NSLocalizedString(@"moreNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_moreTableView];
    _moreTableView.delegate = self;
    _moreTableView.dataSource = self;
//    _moreTableView.style = UITableViewStyleGrouped;
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}


#pragma mrak tableview的代理方法和数据源方法
/**
    组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

/**
    行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

/**
    数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [MoreTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    [cell setNameText:tableViewArray[indexPath.section][indexPath.row]];
    [cell setImgText:tableViewImgArray[indexPath.section][indexPath.row]];
    return cell;
}

/**
    头高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

/**
    脚高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

/**
    点击 根据不同的index来判断不同的事情
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    [self jumpWebView:@"http://b2c.yitaoo2o.com/action/ac_more/yz_about" andTitle:NSLocalizedString(@"moreAboutApp", nil)];
                }
                    break;
                 case 1:
                {
                    [self jumpWebView:@"http://b2c.yitaoo2o.com/action/ac_more/privacy" andTitle:NSLocalizedString(@"morePrivacyRights", nil)];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    OpinionViewController *viewController = [[OpinionViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    [self jumpWebView:@"http://b2c.yitaoo2o.com/action/ac_more/help" andTitle:NSLocalizedString(@"moreUseHelp", nil)];
                }
                    break;
                    
                case 1:
                    [self jumpWebView:@"http://b2c.yitaoo2o.com/action/ac_more/code_img" andTitle:NSLocalizedString(@"moreCodeSharing", nil)];
                    break;
                    
                default:
                    break;
            }
            break;
        
        case 3:
            switch (indexPath.row) {
                case 0:
                    [self clearCache];
                    break;
                case 1:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"moreExitLoginPromptTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"NO", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
                    alertView.tag = 2;
                    [alertView show];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            
            break;
    }
}

- (void)clearCache{
    float cacheSize = (float)[[SDImageCache sharedImageCache] getSize]/1024/1024;
    NSString *imgCache = [NSString stringWithFormat:@"%@%0.2fM", NSLocalizedString(@"moreClearCachePromptTitle", ni),cacheSize];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", nil) message:imgCache delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    alertView.tag = 1;
    [alertView show];
}

/**
    更多页面的weburl地址和跳转web页
 */
- (void)jumpWebView:(NSString *)url andTitle:(NSString *)string{
    AboutUsViewController *viewController = [[AboutUsViewController alloc] init];
    viewController.webUrl = url;
    viewController.naviTitle = string;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark alert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            SetUserDefault(@"NO", IsLogin);
//            SetUserDefault(@"0", U_ID);
            SetUserDefault(nil, Address);
            SetUserDefault(@"", PassWord);
            SetUserDefault(@"", ThirdId);
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self setAlian:@"0"];
            [self.navigationController popViewControllerAnimated:YES];
            [PersonInfoModel clearPersonInfo];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"moreExitLoginSuccess", nil)];
        }
    }else{
        if (buttonIndex == 1) {
            [[SDImageCache sharedImageCache] clearDisk];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"moreClearCacheSuccessPromptTitle", ni)];
        }
    }
}

#pragma mark---------设备号获取以及回调函数
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark----设置别名
-(void)setAlian :(NSString*)alian
{
    [JPUSHService setTags:nil alias:alian fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
}

@end
