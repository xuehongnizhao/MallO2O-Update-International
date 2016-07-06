//
//  PayMoneyViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "PayMoneyTableViewCell.h"
#import "PushPayTableViewCell.h"
#import "RechargeModel.h"

@interface PayMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *payTableView;

@end

@implementation PayMoneyViewController{
    NSArray *payArray;
    NSArray *payMarkArray;
    int payMode;
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

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    payArray = @[@"支付宝",@"微信支付"];
    payMarkArray = @[@"pay_alipay",@"pay_wechat"];
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
    [self setNavBarTitle:@"支付" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.payTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - 支付列表
- (UITableView *)payTableView{
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
    }
    return _payTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return payArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayMoneyTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PayMoneyTableViewCell" owner:self options:nil] lastObject];
        cell.payMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_model.pushMoney];
        cell.getMoneyLabel.text = [_model.getMoney stringByAppendingString:@"充值卡"];
        return cell;
    }else{
        PushPayTableViewCell *cell = [PushPayTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
        if (payMode == indexPath.row) {
            [cell setIsSelectImg:YES andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }else{
            [cell setIsSelectImg:NO andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        payMode = (int)indexPath.row;
    }
    [_payTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 71;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 40;
}

@end
