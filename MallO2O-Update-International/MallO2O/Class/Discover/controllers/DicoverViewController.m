//
//  DicoverViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "DicoverViewController.h"
#import "DiscoverTableViewCell.h"
#import "OrderDetailViewController.h"
#import "FindCodeViewController.h"
#import "SearchResultViewController.h"
#import "LoginViewController.h"

#import "OrderDetailViewController.h"

@interface DicoverViewController ()<UITableViewDataSource ,UITableViewDelegate ,FindCodeViewControllerDelegate>

@property (strong ,nonatomic) UITableView *discoverTableView;

@end

@implementation DicoverViewController{
    NSArray *tableViewArray;
    NSArray *imgArray;
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
    
}


/**
 *  视图加载完成 调用
 *
 *  @param animated
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    if (self.goToHome) {
        self.goToHome = NO;
        [self.rdv_tabBarController setSelectedIndex:0];
    }
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    tableViewArray = @[
                       @[NSLocalizedString(@"dicoverBesom", nil)],
                       @[NSLocalizedString(@"dicoverOneMoney", nil), NSLocalizedString(@"dicoverShake", nil), NSLocalizedString(@"dicoverTurntable", nil)],
                       ];
    imgArray = @[
                 @[@"dis_sao"],
                 @[@"dis_yiyuan",@"dis_yao",@"dis_zhuanpan"],
                 ];
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
    [self setNavBarTitle:NSLocalizedString(@"dicoverNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    self.discoverTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114) style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableViewArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = tableViewArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [DiscoverTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    cell.imgView.image = [UIImage imageNamed:imgArray[indexPath.section][indexPath.row]];
    cell.nameLabel.text = tableViewArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 *Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        [self alert];
//    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        if ([self checkLogin] == YES) {
            [self pushWebView:NSLocalizedString(@"dicoverTurntableNavigationTitle", nil) andWebUrl:[[SwpTools swpToolGetInterfaceURL:@"game_url"] stringByAppendingFormat:@"?u_id=%@",[UserModel shareInstance].u_id]];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        FindCodeViewController *viewController = [[FindCodeViewController alloc] init];
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:^{
            
        }];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        if ([self checkLogin] == YES) {
            [self pushWebView:NSLocalizedString(@"dicoverShakeNavigationTitle", nil) andWebUrl:[NSString stringWithFormat:@"http://b2c.yitaoo2o.com/phone_web/yy_yao/y_yao?u_id=%@",[UserModel shareInstance].u_id]];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([self checkLogin] == YES) {
            [self pushWebView:NSLocalizedString(@"dicoverOneMoneyNavigationTitle", nil) andWebUrl:[NSString stringWithFormat:@"http://b2c.yitaoo2o.com/phone_web/yi_goods/yy_goods?u_id=%@",[UserModel shareInstance].u_id]];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        if ([self checkLogin] == YES) {
            [self pushWebView:NSLocalizedString(@"dicoverSendNavigationTitle", nil) andWebUrl:[NSString stringWithFormat:@"http://b2c.yitaoo2o.com/phone_web/yy_psy/yp_psy?u_id=%@",[UserModel shareInstance].u_id]];
        }
    }
}

/**
 *  跳转web详情页面
 *
 *  @param webTitle 页面标题
 *  @param webUrl   页面
 */
- (void)pushWebView:(NSString *)webTitle andWebUrl:(NSString *)webUrl{
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webTitle = webTitle;
    viewController.webUrl = webUrl;
//    viewController.canGoRoot = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (BOOL)checkLogin{ 
    if ([GetUserDefault(AUTOLOGIN) boolValue] == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc setBackButton];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark 扫码委托
/**
 获取扫码值 并进行操作
 */
-(void)getFindCodeFVCCodeNum:(NSString *)string{
    SearchResultViewController *viewController = [[SearchResultViewController alloc] init];
    viewController.codeText = string;
    [viewController setNavBarTitle:@"扫一扫" withFont:NAV_TITLE_FONT_SIZE];
    //    viewController.searchResultTableView.hidden = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)alert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该功能即将上线" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}

@end
