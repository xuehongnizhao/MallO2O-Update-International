//
//  PushOrderViewController.m
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushOrderViewController.h"
#import "PushAddressTableViewCell.h"
#import "PushOrderBTableViewCell.h"

#import "PushPayTableViewCell.h"
#import "PointNumTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "OrderMarkModel.h"
#import "InputMarkMessageViewController.h"
#import "GoodsWebViewController.h"
#import "OrderDetailViewController.h"
#import "PushOrderSuccessViewController.h"
#import "AdressDetailController.h"

#import "WXApi.h"
#import "payRequsestHandler.h"
#import "WechatOrderInformation.h"

#import "Pingpp.h"
#import "PingppURLResponse.h"

static NSString *cellID = @"pushOrderCell";

@interface PushOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,WXApiDelegate>

@property (strong ,nonatomic) UITableView *orderTableView;

@property (strong ,nonatomic) UIDatePicker *datePicker;

@property (strong ,nonatomic) UILabel *totalLabel;

@property (strong ,nonatomic) UILabel *totalMoneyLabel;

@property (strong ,nonatomic) UIButton *commitButton;

@property (strong ,nonatomic) UIView *commitView;

@property (strong ,nonatomic) UserModel *personInfoModel;

@end

@implementation PushOrderViewController{
    NSString *dateString;
    NSIndexPath *selectIndex;
    NSIndexPath *pointNumIndex;
    NSArray *payArray;
    NSMutableDictionary *dic;
    NSString *pointString;
    NSMutableDictionary *songhuoDic;
    int payMode;
    NSDictionary *alipayOrderDic;
    NSString *payTypeName;
    NSString *pointNumber;
    NSArray *payMarkArray;
    NSString *myMoney;
    NSString *isUseMoney;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@",GetUserDefault(Person_Info));
    [self initData];
    [self initUI];
    NSLog(@"%@",_shopCarArray[5]);
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
    [self.navigationController setNavigationBarHidden:NO];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [_orderTableView reloadData];
}


#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    /**
        列表显示的一些东西  顺序有点乱
     */
    self.personInfoModel = [UserModel shareInstance];
    pointNumber = [[NSString alloc] init];
    payTypeName = [[NSString alloc] init];
    payTypeName = @"支付宝";
    alipayOrderDic = [[NSDictionary alloc] init];
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"优 惠" forKey:@"typeName"];
    [dic setValue:@"0元" forKey:@"typeDetail"];
    songhuoDic = [[NSMutableDictionary alloc] init];
    [songhuoDic setValue:NSLocalizedString(@"pushOrderCellTimePlaceholder", nil) forKey:@"typeName"];
    pointNumIndex = [[NSIndexPath alloc] init];
    selectIndex = [[NSIndexPath alloc] init];
    payArray = @[NSLocalizedString(@"pushOrderCellPlaceholderPaymentAlipay", nil), NSLocalizedString(@"pushOrderCellPlaceholderPaymentWeChat", nil), NSLocalizedString(@"pushOrderCellPlaceholderPaymentPaymentInCash", nil)];
//    payArray = @[NSLocalizedString(@"pushOrderCellPlaceholderPaymentPaymentInCash", nil)];
    payMarkArray = @[@"pay_alipay",@"pay_wechat",@"pay_arrive"];
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
    [self setNavBarTitle:NSLocalizedString(@"pushOrderNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.orderTableView];
    [self.view addSubview:self.commitView];
    [_commitView addSubview:self.totalLabel];
    [_commitView addSubview:self.totalMoneyLabel];
    [_commitView addSubview:self.commitButton];
}

/**
 重写返回方法
 */
- (void)popViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 提交订单部分
/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    /**
        ui细节
     */
    /**view里的控件*/
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_commitView autoSetDimension:ALDimensionHeight toSize:46];
    _commitView.layer.borderWidth = 0.6;
    _commitView.layer.borderColor = UIColorFromRGB(0xd9d9d9).CGColor;
    /**view里的控件*/
    
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_totalLabel sizeToFit];
    _totalLabel.text = NSLocalizedString(@"pushOrderUserAmountPaid", nil);

    /**
        总金额数  从购物车web页获取
     */
    [_totalMoneyLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_totalMoneyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_totalMoneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_totalLabel withOffset:3];
    [_totalMoneyLabel autoSetDimension:ALDimensionWidth toSize:200];
    [self setTotalMoney];
    
    
//    NSString *money = [self settingMyMoney];
//    NSString *totalMoney = [NSString stringWithFormat:@"%f",([_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue])];
    //去掉余额后需要支付的金额
//    NSString *payMoney = [NSString stringWithFormat:@"%0.2f",[totalMoney floatValue] - [money floatValue]];
//    float payMoney = [totalMoney floatValue];
//    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f元",[payMoney floatValue]];
    _totalMoneyLabel.textColor = UIColorFromRGB(0xe34a51);
    
    /**
        提交按钮  按钮的点击事件为   "clickCommitButton"
     */
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_commitButton autoSetDimension:ALDimensionWidth toSize:70];
    _commitButton.layer.cornerRadius = 4;
    _commitButton.layer.masksToBounds = YES;
    [_commitButton addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [_commitButton setTitle:NSLocalizedString(@"pushOrderCommitButtonTitle", nil) forState:UIControlStateNormal];
    _commitButton.titleLabel.textColor = [UIColor blackColor];
    _commitButton.backgroundColor = UIColorFromRGB(0xe34a51);
}

/**
 *  获取支付金额
 */
- (void)setTotalMoney{
//    if ([[UserModel shareInstance].myMoney floatValue] >= ([_shopCarArray[0] floatValue]+ [_shopCarArray[1] floatValue])) {
//        _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f元  (余额支付)", ([_shopCarArray[0] floatValue]+ [_shopCarArray[1] floatValue])];
//    }else{
//        _totalMoneyLabel.text = [NSString stringWithFormat:@"%0.2f",( [_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue] - [[UserModel shareInstance].myMoney floatValue])];
//    }
}

#pragma mark 点击提交按钮
- (void)clickCommitButton{
    NSLog(@"%@",dic);
    _commitButton.enabled = NO;
    [SVProgressHUD showWithStatus:@"提交订单中..."];
    [self getInfoFromTableView];
//    [self clientAlipay];
}

#pragma mark 初始化控件
/**
    初始化列表
 */
- (UITableView *)orderTableView{
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110) style:UITableViewStyleGrouped];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        [_orderTableView registerClass:[PushOrderBTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _orderTableView;
}

- (void)dealloc{

}

/**
    提交的view
 */
- (UIView *)commitView{
    if (_commitView == nil) {
        _commitView = [[UIView alloc] initForAutoLayout];
    }
    return _commitView;
}

/**
    初始化“总金额”label
 */
- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalLabel;
}

/**
    初始化金额数label
 */
- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalMoneyLabel;
}

/**
    初始化提交按钮
 */
- (UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initForAutoLayout];
    }
    return _commitButton;
}

#pragma mark - 设置我的余额
- (NSString *)settingMyMoney{
    NSString *useMoney = [[NSString alloc] init];
    myMoney = [[NSString alloc] init];
//    myMoney = [PersonInfoModel shareInstance].myMoney;
    NSString *totalMoney = [NSString stringWithFormat:@"%f",([_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue])];
    if ([myMoney floatValue] >= [totalMoney floatValue]) {
        useMoney = [NSString stringWithFormat:@"%0.2f",[totalMoney floatValue]];
    }else{
        useMoney = [NSString stringWithFormat:@"%0.2f", [myMoney floatValue]];
    }
    return useMoney;
}

#pragma mark - tableview的数据源方法和委托
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1)
        return 1;
    else if (section == 2)
        return 1;
    else if (section == 3)
        return 2;
    else if (section == 4)
        return 3;
//    else if (section == 4)
//        return 1;
    else if (section == 5){
        if ([_shopCarArray[8] isEqualToString:@"1"]) {
            return 2;
        }
        return 2;
    }
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultcell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultcell"];
        }
//        cell.imageView.image = [UIImage imageNamed:@"my_onebuy"];
        cell.textLabel.text = NSLocalizedString(@"pushOrderPromptTitle", nil);
        cell.textLabel.textColor = UIColorFromRGB(0x444444);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    if (indexPath.section == 1) {
        PushAddressTableViewCell *cell = [PushAddressTableViewCell cellOfTabelView:tableView cellForRowAtIndex:indexPath];
        cell.dict = GetUserDefault(Address);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 3){
        PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:@"moneyCell"];
        NSArray *array = [NSArray array];
        NSDictionary *dic1 = @{
//                               @"typeDetail" : [NSLocalizedString(@"Money", nil) stringByAppendingString:[PersonInfoModel shareInstance].myMoney],
                               @"typeName"   : NSLocalizedString(@"pushOrderCellPlaceholderAccountBalances", nil),
                               };
        NSDictionary *dic2 = @{
                               @"typeDetail" : [NSLocalizedString(@"Money", nil) stringByAppendingString:[self settingMyMoney]],
                               @"typeName"   : NSLocalizedString(@"pushOrderCellPlaceholderUseBalance", nil)
                               };
        array = @[dic1,dic2];
        cell.dic = array[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){
        PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:@"orderTimeCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.dic = songhuoDic;
        return cell;
    }else if(indexPath.section == 4){
        PushPayTableViewCell *cell = [PushPayTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
        if (payMode == indexPath.row) {
            [cell setIsSelectImg:YES andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }else{
            [cell setIsSelectImg:NO andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }
        return cell;
    }else if (indexPath.section == 5){
        if (indexPath.row != 2) {
            PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:@"orderBCell"];
            if (indexPath.row == 3) {
                pointNumIndex = indexPath;
                cell.dic = dic;
            }
            if (indexPath.row == 1) {
                NSMutableDictionary *yunFeiDic = [[NSMutableDictionary alloc] init];
                [yunFeiDic setValue:NSLocalizedString(@"pushOrderCellPlaceholderFreight", nil) forKey:@"typeName"];
                [yunFeiDic setValue:[NSString stringWithFormat:@"%@%@" ,NSLocalizedString(@"Money", nil) , _shopCarArray[1]] forKey:@"typeDetail"];
                cell.dic = yunFeiDic;
            }
            if (indexPath.row == 0) {
                NSMutableDictionary *shopCard = [NSMutableDictionary dictionary];
                [shopCard setValue:NSLocalizedString(@"pushOrderCellPlaceholderViewProductList", nil) forKey:@"typeName"];
                [shopCard setValue:[NSString stringWithFormat:@"%@%@",_shopCarArray[4], NSLocalizedString(@"TheNumberOf", nil)] forKey:@"typeDetail"];
                cell.dic = shopCard;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }else{
            PointNumTableViewCell *cell = [PointNumTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
//            NSMutableDictionary *pointDic = GetUserDefault(Person_Info);[pointDic objectForKey:@"integral"]
//            cell.pointString = [[PersonInfoModel shareInstance].myJifen stringByAppendingString:@"积分"];
            return cell;
        }
        
    }else{
         PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:cellID];
        [self setCell:cell atIndexPath:indexPath];
        return cell;
    } 
}

- (void)setCell:(PushOrderBTableViewCell *)cell atIndexPath:(NSIndexPath *)index{
    OrderMarkModel *model = [[OrderMarkModel alloc] init];
    model.markTextString = _markString;
    cell.model = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 6) {
        return [tableView fd_heightForCellWithIdentifier:cellID configuration:^(PushOrderBTableViewCell *cell) {
            [self setCell:cell atIndexPath:indexPath];
        }];
    }
    else if (indexPath.section == 1)
        return 60;
    else
        return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath;
    if (indexPath.section == 1) {
        [self selectAddress];
    }
    if (indexPath.section == 2) {
        [self addDatePicker];
    }
    if (indexPath.section == 4) {
        payMode = (int)indexPath.row;
        [_orderTableView reloadData];
        if (indexPath.row == 0) {
            payTypeName = @"支付宝";
            [self setTotalMoney];
            [self setCellMyMoney:indexPath];
        }
        if (indexPath.row == 1) {
            payTypeName = @"微信支付";
            [self setTotalMoney];
            [self setCellMyMoney:indexPath];
        }
        if (indexPath.row == 2) {
            payTypeName = @"货到付款";
            [self setCellMyMoney:indexPath];
            _totalMoneyLabel.text = [NSString stringWithFormat:@"%0.2f",[_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue]];
        }
    }
    if(indexPath.section == 5){
        if (indexPath.row == 0) {
            GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
            viewController.webTitle = @"商品清单";
            NSLog(@"%@",_shopCarArray[3]);
            NSString *subUrl = [_shopCarArray[3] substringFromIndex:4];
            viewController.webViewUrl = [@"http:" stringByAppendingString:subUrl];
            viewController.shopName = NSLocalizedString(@"productDetailsNavigationTitle", nil);
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    if (indexPath.section == 6) {
        InputMarkMessageViewController *viewController = [[InputMarkMessageViewController alloc] init];
        if (self.markString != nil) {
            viewController.markString = self.markString;
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/**
 *  设置cell显示的余额
 *
 *  @param idexPath 索引
 */
- (void)setCellMyMoney:(NSIndexPath *)idexPath{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:1 inSection:3];
    PushOrderBTableViewCell *cell = [self.orderTableView cellForRowAtIndexPath:indexPath];
    PushOrderBTableViewCell *cellTwo = [self.orderTableView cellForRowAtIndexPath:indexPathTwo];
    NSString *userMyMoney = [NSString string];
    if (idexPath.row == 2) {
        userMyMoney = [NSString stringWithFormat:@"%@0.00", NSLocalizedString(@"Money", nil)];//@"0.00元";
    }else{
//        userMyMoney = [NSLocalizedString(@"Money", nil) stringByAppendingString: [PersonInfoModel shareInstance].myMoney];
    }
    NSDictionary *dic1 = @{
//                           @"typeDetail":[NSLocalizedString(@"Money", nil) stringByAppendingString: [PersonInfoModel shareInstance].myMoney],
                           @"typeName" : NSLocalizedString(@"pushOrderCellPlaceholderAccountBalances", nil),
                           };
    NSDictionary *dic2 = @{
                           @"typeDetail":userMyMoney,
                           @"typeName" : NSLocalizedString(@"pushOrderCellPlaceholderUseBalance", nil),
                           };
    cell.dic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    cellTwo.dic = [NSMutableDictionary dictionaryWithDictionary:dic2];
//    [self.orderTableView reloadRowsAtIndexPaths:@[indexPath,indexPathTwo] withRowAnimation:UITableViewRowAnimationNone];
//    [self.orderTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    switch (section) {
        case 1:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderAddressTitle", nil)];
            break;
        case 3:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderMyWalletTitle", nil)];
            break;
        case 2:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderTimeTitle", nil)];
            break;
            
        case 4:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderPaymentTitle", nil)];
            break;
            
        case 5:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderCommodityInformationTitle", nil)];
            break;
            
        case 6:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderNoteInformationTitle", nil)];
            break;
            
        default:
            break;
    }
    return view;
}

- (void)labelInView:(UIView *)view andLabelText:(NSString *)string{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    label.text = string;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorFromRGB(0x444444);
    [view addSubview:label];
}

#pragma mark 提交订单页面数据
- (void)getInfoFromTableView{
    NSDictionary *addressDic = GetUserDefault(Address);
    NSString *address = addressDic[@"address"];
    NSString *addressId = addressDic[@"address_id"];
    NSLog(@"送货地址%@---送货时间%@----支付方式%d=-= =-=%@------%@----andid%@",address,dateString,payMode,_totalMoneyLabel.text,_markString,addressId);
    /*-----支付方式 1为在线支付 0为货到付款-----*/
    NSString *payType = [[NSString alloc] init];
    if (payMode == 2) {
        payType = @"0";
    }else{
        payType = @"1";
    }
    /*-----获取收货人信息-----*/
    NSDictionary *personInfo = GetUserDefault(Address);
    //积分处理
//    NSString *inputPointNum = [PersonInfoModel shareInstance].myJifen;//[GetUserDefault(Person_Info) objectForKey:@"integral"];
//    NSInteger orderPoint = [inputPointNum integerValue] - [pointNumber integerValue];
//    [PersonInfoModel shareInstance].myJifen = [NSString stringWithFormat:@"%d",(int)orderPoint];
    
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"insert_order"];//connect_url(@"insert_order");
    if ([_shopCarArray[2] isEqualToString:@"1"]) {
        [self pushDataToUrl:personInfo andUrl:url andPayType:payType];
    }else{
        NSString *pushUrl = [SwpTools swpToolGetInterfaceURL:@"group_insert"];//connect_url(@"group_insert");
        [self pushDataToUrl:personInfo andUrl:pushUrl andPayType:payType];
    }
}
/**
 *  提交订单
 *
 *  @param personInfo 个人信息  弃用
 *  @param url        app_key  不同提交方式app_key不同
 *  @param payType    支付类型
 */
- (void)pushDataToUrl:(NSDictionary *)personInfo andUrl:(NSString *)url andPayType:(NSString *)payType{
    if ([personInfo objectForKey:@"consignee"] != nil && ![[personInfo objectForKey:@"consignee"] isEqualToString:@""]) {
        if ([dateString isEqualToString:@""] || dateString == nil) {
            dateString = NSLocalizedString(@"pushOrderCellTimePlaceholder", nil);
        }
        if (_markString == nil || [_markString isEqualToString:@""]) {
            _markString = @" ";
        }
        if ([pointNumber isEqualToString:@""]|| pointNumber == nil) {
            pointNumber = @"0";
        }
        NSString *useMoney = [NSString string];
        if ([payTypeName isEqualToString:@"支付宝"]) {
//                                        [self clientAlipay];
            payType = @"1";
            useMoney = [self settingMyMoney];
        }
        if ([payTypeName isEqualToString:@"微信支付"]) {
//                                        [self sendPay_demo];
            payType = @"2";
            useMoney = [self settingMyMoney];
        }
        if ([payTypeName isEqualToString:@"货到付款"]) {
            payType = @"0";
        }
        isUseMoney = [[NSString alloc] init];
        
        NSString *totalMoney = [NSString stringWithFormat:@"%f",([_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue])];
        if ([totalMoney floatValue] > [[self settingMyMoney] floatValue]) {
            isUseMoney = @"0";
//            payType = @"1";
        }else{
            isUseMoney = @"1";
            useMoney = [self settingMyMoney];
//            payType = @"0";
        }
        if (isUseMoney == nil || [isUseMoney isEqualToString:@""]) {
            isUseMoney = @"0";
        }
        if (useMoney == nil || [useMoney isEqualToString:@""]) {
            useMoney = @"0";
        }
//        NSString *pushMOney = [NSString stringWithFormat:@"%0.2f",[totalMoney floatValue]];
            NSDictionary *orderDic = @{
                                       @"app_key" : url,
                                       @"pay_type" : payType,
                                       @"u_id"    : self.personInfoModel.u_id,
                                       @"consignee" : [personInfo objectForKey:@"consignee"],
                                       @"mobile"   : [personInfo objectForKey:@"phone_tel"],
                                       @"address"  : [personInfo objectForKey:@"address"],
                                       @"remark"   : _markString,
                                       @"micro_time" : _shopCarArray[7],
                                       @"ship_time" : dateString,
                                       @"goods_list" : _shopCarArray[5],
                                       @"address_id" : [personInfo objectForKey:@"address_id"],
                                       @"jifen"  : pointNumber,
                                       @"balbance":useMoney,
                                       @"isbalbance" : isUseMoney,
                                       };
            [SwpRequest swpPOST:url parameters:orderDic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
                if ([resultObject[@"code"] integerValue] == 200) {
                    if (![payType isEqualToString:@"0"] && resultObject[@"obj"][@"ping"] != nil) {
                        alipayOrderDic = resultObject[@"obj"];
                        NSString *money = [[_totalMoneyLabel.text substringFromIndex:1] substringToIndex:_totalMoneyLabel.text.length - 2];
                        float moneyNum = [money floatValue];
                        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:resultObject[@"obj"]];
                        [paramDic setValue:[NSString stringWithFormat:@"%d",(int)(moneyNum * 100)] forKey:@"total_money"];
                        [paramDic setValue:[[resultObject objectForKey:@"obj"] objectForKey:@"order_id"] forKey:@"order_id"];
                        [paramDic setValue:[WechatOrderInformation orderNumber].orderNumber forKey:@"prepayid"];
                        WechatOrderInformation *model = [WechatOrderInformation dicWithDic:paramDic];
                        [WechatOrderInformation saveInfor:model];
                        //跳转ping++支付
                        [self getPingpp:resultObject[@"obj"][@"ping"]];
                        NSLog(@"%@",resultObject);
                    }else{
                        PushOrderSuccessViewController *viewController = [[PushOrderSuccessViewController alloc] init];
                        viewController.webUrl = resultObject[@"obj"][@"url"];
                        viewController.totalMoney = @"订单提交成功";
                        [self.navigationController pushViewController:viewController animated:YES];
                        //                        if ([isUseMoney isEqualToString:@"1"]) {
                        if (![payTypeName isEqualToString:@"货到付款"]) {
//                            NSString *payMyMoney = [self settingMyMoney];
//                            NSString *personMoney = [PersonInfoModel shareInstance].myMoney;
//                            [PersonInfoModel shareInstance].myMoney = [NSString stringWithFormat:@"%0.2f",[personMoney floatValue] - [payMyMoney floatValue]];
                        }
                        //                        }
                    }
                }else{
                    _commitButton.enabled = YES;
                    [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
                }

            } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                _commitButton.enabled = YES;
                [SVProgressHUD showErrorWithStatus:@"网络异常"];
            }];
    }else{
        _commitButton.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
    }
}
/**
 *  ping++提交订单
 *
 *  @param charge ping++所需的参数
 */
- (void) getPingpp:(NSObject *)charge {
    
    [Pingpp createPayment:charge viewController:self appURLScheme:nil withCompletion:^(NSString *result, PingppError *error){
        [SVProgressHUD dismiss];
        NSLog(@"%@", result);
        if ([result isEqualToString:@"success"]) {
            // 支付成功
            NSLog(@"成功");
            PushOrderSuccessViewController *viewController = [[PushOrderSuccessViewController alloc] init];
            viewController.totalMoney = [NSString stringWithFormat:@"成功支付%@",_totalMoneyLabel.text];
            viewController.webUrl = [alipayOrderDic objectForKey:@"url"];
            [self.navigationController pushViewController:viewController animated:YES];
            if ([isUseMoney isEqualToString:@"0"]) {
//                NSString *payMyMoney = [self settingMyMoney];
//                NSString *personMoney = [PersonInfoModel shareInstance].myMoney;
//                [PersonInfoModel shareInstance].myMoney = [NSString stringWithFormat:@"%0.2f",[personMoney floatValue] - [payMyMoney floatValue]];
            }
        } else {
            // 支付失败或取消
            NSLog(@"Error: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
            if (error.code == 5) {
                [SVProgressHUD showErrorWithStatus:@"取消支付"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}

#pragma mark 选择地址
- (void)selectAddress{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Address" bundle:[NSBundle mainBundle]];
    AdressDetailController *vc = [story instantiateViewControllerWithIdentifier:@"adress"];
    vc.isSelectAddress = @"YES";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 添加时间选择器  注意8与7的区别
/**
 *  选择时间控件   ios7与89问题不同  写两套
 */
- (void)addDatePicker{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController* alertVc=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction* ok=[UIAlertAction actionWithTitle:NSLocalizedString(@"pushOrderCellSelectTimeButtonTitle", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"MM-dd hh:mm"];
            dateString = [[NSString alloc] init];
            dateString=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:_datePicker.date]];
            songhuoDic = [[NSMutableDictionary alloc] init];
            [songhuoDic setValue:dateString forKey:@"typeName"];
            [_orderTableView reloadRowsAtIndexPaths:@[selectIndex] withRowAnimation:0];
        }];
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.minimumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 200 * Balance_Heith);
        [alertVc.view addSubview:_datePicker];
        [alertVc addAction:ok];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0&&[[[UIDevice currentDevice] systemVersion] floatValue] <8.0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:NSLocalizedString(@"pushOrderCellSelectTimeButtonTitle", nil) destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10, 200 * Balance_Heith)];
        _datePicker.minimumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [actionSheet addSubview:_datePicker];
        [actionSheet showInView:self.view];
    }
}

/**
    actionsheet委托
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"MM-dd hh:mm"];
        dateString = [[NSString alloc] init];
        dateString=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:_datePicker.date]];
        songhuoDic = [[NSMutableDictionary alloc] init];
        [songhuoDic setValue:dateString forKey:@"typeName"];
        [_orderTableView reloadRowsAtIndexPaths:@[selectIndex] withRowAnimation:0];
    }
}

#pragma mark 设置选择时间控件
- (void)setDatePickerInActionSheet:(UIActionSheet *)acs{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 90, acs.frame.size.width, acs.frame.size.height)];
    
    datePicker.userInteractionEnabled = YES;
    [acs addSubview:datePicker];
}

@end
