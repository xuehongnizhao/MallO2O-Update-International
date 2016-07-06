//
//  MineViewController.m
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "LoginViewController.h"
#import "MoreViewController.h"
#import "PointShopViewController.h"
#import "EditPerInfoViewController.h"
#import "ChangePassViewController.h"
#import "MyCollectionViewController.h"
#import "PushOrderViewController.h"
#import "MyOrderViewController.h"
#import "AppraisalViewController.h"
#import "AdressDetailController.h"
#import "MineHeaderView.h"
#import "MessageViewController.h"
#import "OrderDetailViewController.h"
#import "RechargeViewController.h"
#import "MineCateTableViewCell.h"
#import "PersonInfoTableViewCell.h"
#import "MyCollectionShopViewController.h"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  我的列表
 */
@property (strong ,nonatomic) UITableView *mineTableView;
/**
 *  各功能图片名称数组
 */
@property (strong ,nonatomic) NSArray *imgNameArray;
/**
 *  各功能的名称
 */
@property (strong ,nonatomic) NSArray *typeTextArray;

@end

@implementation MineViewController{
    UIButton* rightButton;
    NSArray *imgArray;
    NSArray *labelTextArray;
    NSMutableDictionary *mineCateDic;
    NSMutableDictionary *mineCateMoneyDic;
    NSString *collectionNum;
    NSString *collectShopNum;
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
    if (self.rdv_tabBarController.tabBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }

    [self getCollectionNum];
    [_mineTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    mineCateDic = [NSMutableDictionary dictionary];
    mineCateMoneyDic = [NSMutableDictionary dictionary];
    
    _imgNameArray = @[@"my_onebuy",@"message_sel",@"per_4",@"edit_password",@"per_5"];
    _typeTextArray = @[
                       NSLocalizedString(@"mineOneOfMyPurchases", nil),
                       NSLocalizedString(@"mineNews", nil),
                       NSLocalizedString(@"mineAddressManagement", nil),
                       NSLocalizedString(@"mineModifyPassword", nil),
                       NSLocalizedString(@"mineMore", nil)
                       ];
    imgArray = @[@"1",@"2",@"3",@"4"];
    
    labelTextArray = @[
                       NSLocalizedString(@"minePendingPayment", nil),
                       NSLocalizedString(@"mineInProgress", nil),
                       NSLocalizedString(@"mineEvaluation", nil),
                       NSLocalizedString(@"mineRefund", nil)];

    [mineCateDic setValue:imgArray forKey:@"img"];
    [mineCateDic setValue:labelTextArray forKey:@"text"];
    NSArray *textArray = @[
                           NSLocalizedString(@"mineBalanceRecharge", nil),
                           NSLocalizedString(@"mineTopRecords", nil)
                           ];
    NSArray *moneyImgArray = @[@"5",@"6"];

    [mineCateMoneyDic setValue:moneyImgArray forKey:@"img"];
    [mineCateMoneyDic setValue:textArray forKey:@"text"];
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
    [self setNavBarTitle:@"我的" withFont:NAV_TITLE_FONT_SIZE];
    
}

/**
    设置导航栏右侧按钮
 */
- (void)setNaviRightButton{

}

/**
    导航栏右侧按钮点击事件
 */
- (void)messageButton{
    NSLog(@"未定功能  暂时添加点击事件");
    if ([GetUserDefault(AUTOLOGIN) boolValue] == NO) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    MessageViewController *viewController = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
    [self.view addSubview:_mineTableView];
    _mineTableView.showsVerticalScrollIndicator = NO;
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
//    _mineTableView.bounces = nil;
    [UZCommonMethod hiddleExtendCellFromTableview:_mineTableView];
}

/**
 返回首页
 */
- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index{
    self.rdv_tabBarController.selectedIndex = index;
    if (index == 0) {
        SetUserDefault(@"返回首页", @"back_home_view");
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    [_mineTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
//    if ((SCREEN_HEIGHT - 115) < _mineTableView.contentSize.height) {
//        _mineTableView.scrollEnabled = YES;
//    }else{
//        _mineTableView.scrollEnabled = NO;
//    }
}

#pragma mark 设置tableview的数据源和委托
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
    if (section == 3) {
        return _typeTextArray.count;
    }
    if (section == 0) {
        return 1;
    }
    return 2;
}
/**
 *  获取收藏商家数量 收藏商品数量  个人积分和余额
 */
- (void)getCollectionNum{
    collectionNum = @"0";
    collectShopNum = @"0";
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"user_four_info"];
    if ([[UserModel shareInstance].u_id isEqualToString:@"0"] || [UserModel shareInstance].u_id.length == 0) {
        return;
    }
    NSDictionary *jifenDic = @{
                               @"app_key" : url,
                               @"u_id"    : [UserModel shareInstance].u_id
                               };
    
    if ([GetUserDefault(AUTOLOGIN) boolValue]) {
        [self swpPublicTooGetDataToServer:url parameters:jifenDic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            if (resultObject[@"obj"][@"goods_num"] == nil || [resultObject[@"obj"][@"goods_num"] isEqualToString:@""]) {
                return;
            }
            collectionNum = resultObject[@"obj"][@"goods_num"];
            collectShopNum = resultObject[@"obj"][@"shop_num"];
            
            [self.mineTableView reloadData];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
        
        
    }else
        collectionNum = @"0";
}

/**
    数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        MineTableViewCell *cell = [MineTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
        cell.imgView.image = [UIImage imageNamed:_imgNameArray[indexPath.row]];
        cell.nameLabel.text = _typeTextArray[indexPath.row];
        cell.nameLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        MineCateTableViewCell *cell = [MineCateTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
        [mineCateDic setValue:[NSString stringWithFormat:@"%d", (int)indexPath.section] forKey:@"index"];
        cell.dic = mineCateDic;
        [self clickCell:cell];
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        MineCateTableViewCell *cell = [MineCateTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
        [mineCateMoneyDic setValue:[NSString stringWithFormat:@"%d", (int)indexPath.section] forKey:@"index"];
        cell.dic = mineCateMoneyDic;
        [self clickCell:cell];
        return cell;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        MineTableViewCell *cell = [MineTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"per_1"];
        cell.nameLabel.text = NSLocalizedString(@"mineAllOrders", nil);
        cell.nameLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        MineTableViewCell *cell = [MineTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"per_2"];
        cell.nameLabel.text = NSLocalizedString(@"mineMyWallet", nil);
        cell.nameLabel.font = [UIFont systemFontOfSize:16];
        cell.yueLabel.text = NSLocalizedString(@"mineBalance", nil);
        return cell;
    }
    PersonInfoTableViewCell *cell = [PersonInfoTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = [NSDictionary dictionary];
    if ([GetUserDefault(AUTOLOGIN) boolValue] == YES) {
        //个人信息
//        dic = GetUserDefault(Person_Info);
    }else{
        dic = @{
                              @"user_pic"  : @"",
                              @"user_nickname" : @"点击登录",
                              @"integral"  : @"0"
                              };
    }
    NSArray *array = @[
//                       @{@"type":NSLocalizedString(@"mineMyPoints", nil)},
//                       @{@"type":NSLocalizedString(@"mineBusinessCollection", nil),
//                         @"detail":collectShopNum},
//                       @{@"type":NSLocalizedString(@"mineGoodsCollection", nil),
//                         @"detail":collectionNum}
                       ];
    [self clickPersonInfoCell:cell];
    cell.array = array;
    return cell;
}

#pragma param - 商家收藏跳转 商品收藏跳转 我的积分跳转
- (void)clickPersonInfoCell:(PersonInfoTableViewCell *)cell{
    __weak typeof (MineViewController *) vc = self;
    [cell getIndex:^(NSInteger index) {
        if ([GetUserDefault(AUTOLOGIN) boolValue] == NO) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc setBackButton];
            return;
        }
        if (index == 0) {
            PointShopViewController *viewController = [[PointShopViewController alloc] init];
            [vc.navigationController pushViewController:viewController animated:YES];
        }
        if (index == 1) {
            MyCollectionShopViewController *viewController = [[MyCollectionShopViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        if (index == 2) {
            MyCollectionViewController *viewController = [[MyCollectionViewController alloc] init];
            [vc.navigationController pushViewController:viewController animated:YES];
        }
    }];
}
/**
 *  点击待付款、待发货。。。和余额充值、余额记录cell内的功能
 *
 *  @param cell 个人中心cell  定向跳转订单和余额cell是一个
 */
- (void)clickCell:(MineCateTableViewCell *)cell{
    __weak typeof (MineViewController *) vc = self;
    [cell getIndex:^(NSInteger index) {
        if ([GetUserDefault(AUTOLOGIN) boolValue] == NO) {
            LoginViewController *viewController = [[LoginViewController alloc] init];
            [viewController setBackButton];
            [self.navigationController pushViewController:viewController animated:YES];
            return;
        }
        switch (index) {
            case 10:
                [vc pushMyOrderViewController:1];
                break;
            case 11:
                [vc pushMyOrderViewController:2];
                break;
            case 12:
                [vc pushMyOrderViewController:3];
                break;
            case 13:
                [vc pushMyOrderViewController:4];
                break;
            case 20:
                NSLog(@"跳转余额充值");
            {
                OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
                viewController.webTitle = NSLocalizedString(@"rechargeCenterNavigationTitle", nil);
                viewController.webUrl = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_shop/cz_card?u_id=%@",[UserModel shareInstance].u_id];
                [self.navigationController pushViewController: viewController animated:YES];
            }
                break;
            case 21:
                NSLog(@"跳转充值记录");
            {
                OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
                viewController.webTitle = NSLocalizedString(@"rechargeRecordNavigationTitle", nil);
                viewController.webUrl = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_shop/chongzhi_list?u_id=%@",[UserModel shareInstance].u_id];
                [self.navigationController pushViewController:viewController animated:YES];
            }
                break;
            default:
                break;
        }
    }];
}

/**
    cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 55 * Balance_Heith;
    }
    if (indexPath.section != 0 && indexPath.row == 0) {
        return 38 * Balance_Heith;
    }
    if ((indexPath.section == 1 || indexPath.section == 2) && indexPath.row == 1) {
        return 77;
    }
    return 38 * Balance_Heith;
}

/**
    header高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 155;
    if (section == 0) {
        return 145 * Balance_Heith;
    }
    return 10 * Balance_Heith;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

///**
//    设置header
// */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145 * Balance_Heith)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"per_background"]];
        imgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 145 * Balance_Heith);
        [view addSubview:imgView];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personBackground)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:gesture];
        
        [self addHeaderUI:imgView];
        return view;
    }
    return ({UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        view;
    });
}


- (void)pushMyOrderViewController:(NSInteger)orderType{
    MyOrderViewController *viewController = [[MyOrderViewController alloc] init];
    viewController.selectIndex = orderType;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark 跳转编辑用户信息
/**
    点击个人中心头的背景
    跳转编辑个人信息页面
 */
- (void)personBackground{
    if ([GetUserDefault(AUTOLOGIN) boolValue]) {
        EditPerInfoViewController *viewController = [[EditPerInfoViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

/**
    设置header内部控件
 */
- (void)addHeaderUI:(UIView *)view{
    if ([GetUserDefault(AUTOLOGIN) boolValue] == YES) {
        //个人信息
//        NSDictionary *dic = GetUserDefault(Person_Info);
        NSDictionary *dic = [NSDictionary dictionary];
        [self setInfo:dic infView:view];
    }else{
        NSDictionary *dic = @{
                              @"user_pic"  : @"",
                              @"user_nickname" : @"点击登录",
                              @"integral"  : @"0"
                              };
        [self setInfo:dic infView:view];
    }
}
/**
 *  设置姓名  头像  和是否vip的样式（tableviewheader）
 *
 *  @param dic  弃用
 *  @param view 父视图
 */
- (void)setInfo:(NSDictionary *)dic infView:(UIView *)view{
    if ([[UserModel shareInstance].user_name isEqualToString:@""] || [UserModel shareInstance].user_name == nil) {
        [UserModel shareInstance].user_name = NSLocalizedString(@"mineClickOnLogin", nil);
    }
    UIImageView *imgView = [[UIImageView alloc] initForAutoLayout];
    [view addSubview:imgView];
    [imgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30 * Balance_Heith];
    [imgView autoSetDimension:ALDimensionHeight toSize:84 * Balance_Heith];
    [imgView autoSetDimension:ALDimensionWidth toSize:84 * Balance_Heith];
    [imgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[UserModel shareInstance].user_pic] placeholderImage:[UIImage imageNamed:@"person_default"]];
    imgView.layer.cornerRadius = 42 * Balance_Heith;
    imgView.layer.masksToBounds = YES;
    
    UIImageView *vipImage = [[UIImageView alloc] initForAutoLayout];
    [view addSubview:vipImage];
    [vipImage autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imgView withOffset:0];
    [vipImage autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:imgView withOffset:0];
    [vipImage autoSetDimension:ALDimensionHeight toSize:18];
    [vipImage autoSetDimension:ALDimensionWidth toSize:48];
//    vipImage.layer.borderWidth = 1;
//    [[UserModel shareInstance].isVip isEqualToString:@"0"] || [PersonInfoModel shareInstance].isVip == nil ? (vipImage.image = [UIImage imageNamed:@"no_vip"]) : (vipImage.image = [UIImage imageNamed:@"vip"]);
    
    UILabel *perNameLabel = [[UILabel alloc] init];
    perNameLabel.textAlignment = NSTextAlignmentCenter;
    [self setLabel:perNameLabel withFrame:CGRectMake(0 * Balance_Width, 115 * Balance_Heith, SCREEN_WIDTH, 30 * Balance_Heith) andText:[UserModel shareInstance].user_name];
    perNameLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:perNameLabel];
}
/**
    设置label的固定属性
 */
- (void)setLabel:(UILabel *)label withFrame:(CGRect)rect andText:(NSString *)string{
    label.frame = rect;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.text = string;
}

/**
    选择cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",GetUserDefault(AUTOLOGIN));
    if ([GetUserDefault(AUTOLOGIN) boolValue] == NO) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                MyOrderViewController *viewController = [[MyOrderViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
                viewController.webTitle = NSLocalizedString(@"rechargeCenterNavigationTitle", nil);
                viewController.webUrl = [NSString stringWithFormat:@"http://b2c.yitaoo2o.com/action/ac_shop/cz_card?u_id=%@",[UserModel shareInstance].u_id];
                [self.navigationController pushViewController: viewController animated:YES];
            }
        }
        
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
                viewController.webTitle = NSLocalizedString(@"oneDollarForMeNavigationTitle", nil);
                viewController.webUrl = [@"http://b2c.yitaoo2o.com/phone_web/yi_goods/yy_list" stringByAppendingFormat:@"?u_id=%@",[UserModel shareInstance].u_id];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            if (indexPath.row == 1) {
                [self messageButton];
            }
            if (indexPath.row == 2) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Address" bundle:[NSBundle mainBundle]];
                AdressDetailController *vc = [story instantiateViewControllerWithIdentifier:@"adress"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (indexPath.row == 3) {
                ChangePassViewController *viewController = [[ChangePassViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            if (indexPath.row == 4) {
                MoreViewController *viewController = [[MoreViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
    }
}

@end
