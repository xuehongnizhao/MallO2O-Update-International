//
//  RechargeViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/20.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableViewCell.h"
#import "RechargeModel.h"
#import "MoneyInfoTableViewCell.h"
#import "RechargeView.h"
#import "PayMoneyViewController.h"

static NSString *cellID = @"rechargeCell";
static NSString *moneyCell = @"moneyCell";

@interface RechargeViewController ()<UITableViewDataSource,UITableViewDelegate ,RechargeViewDelegate>

@property (strong ,nonatomic) UITableView *rechargeTabelView;

@property (strong ,nonatomic) NSIndexPath *selectIndexPath;

@property (strong ,nonatomic) UIButton *rechargeButton;

@end

@implementation RechargeViewController{
    NSArray *moneyArray;
    BOOL rechargeViewIsExsit;
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
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    RechargeModel *model1 = [RechargeModel initWithGetMoney:@"1000元" andPushMoney:@"900元"];
    RechargeModel *model2 = [RechargeModel initWithGetMoney:@"500元" andPushMoney:@"480元"];
    RechargeModel *model3 = [RechargeModel initWithGetMoney:@"200元" andPushMoney:@"190元"];
    RechargeModel *model4 = [RechargeModel initWithGetMoney:@"100元" andPushMoney:@"95元"];
    moneyArray = @[model1,model2,model3,model4];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    self.rechargeTabelView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:@"充值卡" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.rechargeTabelView];
    [self.view addSubview:self.rechargeButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.rechargeTabelView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_rechargeButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [_rechargeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_rechargeButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_rechargeButton autoSetDimension:ALDimensionHeight toSize:40];
}

#pragma mark - 充值列表
- (UITableView *)rechargeTabelView{
    if (!_rechargeTabelView) {
        _rechargeTabelView = [[UITableView alloc] initForAutoLayout];
        [_rechargeTabelView registerClass:[RechargeTableViewCell class] forCellReuseIdentifier:cellID];
        [_rechargeTabelView registerClass:[MoneyInfoTableViewCell class] forCellReuseIdentifier:moneyCell];
        _rechargeTabelView.delegate = self;
        _rechargeTabelView.dataSource = self;
        _rechargeTabelView.scrollEnabled = NO;
    }
    return _rechargeTabelView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section > 0) {
        RechargeTableViewCell *cell = [RechargeTableViewCell rechargeTableView:tableView cellForRowAtIndexPath:indexPath cellID:cellID];
        if (_selectIndexPath == nil) {
            indexPath.section == 1 && indexPath.row == 0 ? [cell selectImage:YES] : [cell selectImage:NO];
        }else{
            indexPath == _selectIndexPath ? [cell selectImage:YES] : [cell selectImage:NO];
        }
        cell.model = moneyArray[indexPath.section - 1];
        return cell;
    }else{
        MoneyInfoTableViewCell *cell = [MoneyInfoTableViewCell moneyInfoTableView:tableView cellForRowAtIndexPath:indexPath cellID:moneyCell];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndexPath = [[NSIndexPath alloc] init];
    _selectIndexPath = indexPath;
    [_rechargeTabelView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 200;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        RechargeView *view = [[RechargeView alloc] init];
        view.isExist = rechargeViewIsExsit;
        view.delegate = self;
        return view;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    return view;
} 

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    if (section == 1) {
        UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
        [view addSubview:titleLabel];
        [titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.text = @"充值金额";
    }
    return view;
}

#pragma mark - 充值按钮  点击跳转充值页面
- (UIButton *)rechargeButton{
    if (!_rechargeButton) {
        _rechargeButton = [[UIButton alloc] initForAutoLayout];
        [_rechargeButton setTitle:@"立即充值" forState:UIControlStateNormal];
        [_rechargeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rechargeButton setBackgroundImage:[UZCommonMethod setImageFromColor:UIColorFromRGB(DefaultColor) viewWidth:1 viewHeight:1] forState:UIControlStateNormal];
        [_rechargeButton addTarget:self action:@selector(clickRechargeButton) forControlEvents:UIControlEventTouchUpInside];
        _rechargeButton.layer.cornerRadius = 4;
        _rechargeButton.layer.masksToBounds = YES;
        _rechargeButton.enabled = NO;
    }
    return _rechargeButton;
}

- (void)clickRechargeButton{
    NSLog(@"点击了充值按钮");
    if (_selectIndexPath == nil) {
        _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    }
    PayMoneyViewController *viewController = [[PayMoneyViewController alloc] init];
    viewController.model = moneyArray[_selectIndexPath.section - 1];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickXieYi{
    NSLog(@"代理带出来点击协议事件");
}

- (void)imageIsSelect:(BOOL)isSelect{
    NSLog(@"图片是否被点击");
    if (isSelect) {
        _rechargeButton.enabled = YES;
    }else{
        _rechargeButton.enabled = NO;
    }
    rechargeViewIsExsit = isSelect;
}

@end
