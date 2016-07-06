 //
//  ExchangeMessageViewController.m
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  游瓶 -----> 积分商品兑换控制器

#import "ExchangeMessageViewController.h"
#import "PointShopViewController.h"

// ---------------------- 框架工具类 ----------------------

// ---------------------- view       ----------------------
#import "ExchangeSelectedTableViewCell.h"   // 添加兑换商品cell
#import "ExchangeMessageTableViewCell.h"    // 显示商品信息cell
#import "ExchangeInputTableViewCell.h"      // 输入用户信息cell
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "ExchangeModel.h"                   // 展示兑换商品 / 输入用户信息的数据模型
#import "PointShopModel.h"                  // 积分商城数据模型
//#import "UserModel.h"                       // 用户数据模型
// ---------------------- model      ----------------------

@interface ExchangeMessageViewController () <UITableViewDataSource, UITableViewDelegate, ExchangeSelectedTableViewCellDelegate, ExchangeInputTableViewCellDelegate>

#pragma mark - UIProperty
// ---------------------- UI 控件 ----------------------
/** 显示兑换商品信息 和 用户信息view */
@property (strong, nonatomic) UITableView   *exchangeMessageTableView;
/** 提交兑换按钮 */
@property (strong, nonatomic) UIButton      *commitButton;

#pragma mark - DataProperty
// ---------------------- 数据模型 ----------------------
/** 显示兑换商品信息 和 用户信息的数据源 */
@property (strong, nonatomic) NSArray   *exchangeMessageArray;
/** 商品积分 */
@property (copy  , nonatomic) NSString  *shopPoint;
/** 兑换商品总数 */
@property (copy  , nonatomic) NSString  *shopNumber;
/** 兑换商品总价格 */
@property (copy  , nonatomic) NSString  *totalPrice;
/** 用户电话 */
@property (copy  , nonatomic) NSString  *userTel;
/** 用户姓名 */
@property (copy  , nonatomic) NSString  *userName;

@end

@implementation ExchangeMessageViewController

#pragma mark - LifecycleMethod
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


#pragma mark - DataInitMethod
/**
 *  数据初始化
 */
- (void) initData {
    
    
    self.shopNumber = self.shopNumber == nil ? @"0"     : self.shopNumber;
    self.totalPrice = self.totalPrice == nil ? @"0"     : self.totalPrice;
    self.shopPoint  = self.pointShop.pointText;
    

    ExchangeModel *price            = [[ExchangeModel alloc] init];
    price.exchangeTitle             = @"单 价";
    price.exchangeDesc              = self.shopPoint;
    
    ExchangeModel *number           = [[ExchangeModel alloc] init];
    number.exchangeTitle            = @"数 量";
    number.exchangeDesc             = self.shopNumber;
    
    ExchangeModel *totalPrice       = [[ExchangeModel alloc] init];
    totalPrice.exchangeTitle        = @"总 价";
    totalPrice.exchangeDesc         = self.totalPrice;
    
    NSArray *grouped1               = @[price, number, totalPrice];
    
    
    ExchangeModel *userName         = [[ExchangeModel alloc] init];
    userName.exchangeTitle          = @"姓 名";
    userName.exchangeDesc           = @"0";
    userName.exchangePlaceholder    = @"请输入收货人姓名";
    
    ExchangeModel *userTel          = [[ExchangeModel alloc] init];
    userTel.exchangeTitle           = @"电 话";
    userTel.exchangeDesc            = @"0";
    userTel.exchangePlaceholder     = @"请输入电话";

    NSArray *grouped2               = @[userName, userTel];

    self.exchangeMessageArray       = @[grouped1, grouped2];
    
}

#pragma mark - SettingUIMethod
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
    self.view.backgroundColor = [UIColor blackColor];
    [self setNavBarTitle:@"确认兑换" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    
    [self.view addSubview:self.exchangeMessageTableView];
    [self.view addSubview:self.commitButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    [self.commitButton autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH - 40];
    [self.commitButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.commitButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:100 * Balance_Heith];
    [self.commitButton autoSetDimension:ALDimensionHeight toSize:35 * Balance_Heith];
    
//    [self.exchangeMessageTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
//    [self.exchangeMessageTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.commitButton withOffset:0];
    [self.exchangeMessageTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.exchangeMessageTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.exchangeMessageTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.exchangeMessageTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
}


#pragma mark - UITableView DataSource Method

/**
 *  tableView 数据源方法 返回tabvelView 分组个数
 *
 *  @param  tableView
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.exchangeMessageArray.count;
}

#pragma mark - 编译时报错
/**
 *  tableView 数据源方法 返回tableView 每个分组中cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSInteger
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.exchangeMessageArray[section];
    return [array count];
}

/**
 *  tableView 数据源方法 返回每个cell显示的样式和数据
 *
 *  @param  tableView
 *  @param  indexPath
 *
 *  @return OrderTableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {

        if (indexPath.row == 1) {
            // 显示 可以添加商品数量的cell
            ExchangeSelectedTableViewCell *cell = [ExchangeSelectedTableViewCell exchangeSelectedCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
            
            cell.delegate  = self;
            NSArray *array = self.exchangeMessageArray[indexPath.section];
            cell.exchange  = array[indexPath.row];
            return cell;
        
        } else {
            // 显示商品信息的cell
            ExchangeMessageTableViewCell *cell = [ExchangeMessageTableViewCell exchangeMessageCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
            NSArray *array = self.exchangeMessageArray[indexPath.section];
            if (indexPath.row == 2) {
                cell.exchangeDescView.textColor = [UIColor redColor];
            }
            cell.exchange  = array[indexPath.row];
            return cell;
        }
    }
    
    // 显示用户输入信息的cell
    ExchangeInputTableViewCell *cell = [ExchangeInputTableViewCell exchangeInputCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.delegate  = self;
    NSArray *array = self.exchangeMessageArray[indexPath.section];
    cell.exchange  = array[indexPath.row];
    return cell;
}


/**
 *  tableView 数据源方法 返回每个分组头显示的文字
 *
 *  @param  tableView
 *  @param  section
 *
 *  @return
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [@"   " stringByAppendingString:self.pointShop.nameText ];
    } else {
        return @" ";
    }

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] init];
        UILabel *textLabel = [[UILabel alloc] initForAutoLayout];
        [headerView addSubview:textLabel];
        [textLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
        [textLabel autoSetDimension:ALDimensionWidth toSize:200];
        textLabel.text = @"   兑换个人信息";
        UILabel *pointNumber = [[UILabel alloc] initForAutoLayout];
        [headerView addSubview:pointNumber];
        [pointNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 15) excludingEdge:ALEdgeLeft];
        [pointNumber autoSetDimension:ALDimensionWidth toSize:200];
//        pointNumber.text = [GetUserDefault(Person_Info) objectForKey:@"integral"];
        NSLog(@"%@",[PersonInfoModel shareInstance].myJifen);
        pointNumber.text = [PersonInfoModel shareInstance].myJifen;
        pointNumber.textAlignment = NSTextAlignmentRight;
        headerView.backgroundColor = UIColorFromRGB(0xf9f9f9);
        return headerView;
    }
    return nil;
}

/**
 *  tableView 数据源方法 返回每个分组头高度
 *
 *  @param  tableView
 *  @param  section
 *
 *  @return
 */
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

/**
 *  tableView 数据源方法 返回每个分组尾部高度
 *
 *  @param  tableView
 *  @param  section
 *
 *  @return
 */
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark - ExchangeSelectedTableViewCell Delegate Method
/**
 *  ExchangeSelectedTableViewCell Delegate (点击增加 或 减少兑换商品)
 *
 *  @param exchangeSelectedTableViewCell
 *  @param indexPath
 *  @param exchange
 *  @param button
 *  @param index
 */
- (void)exchangeSelectedTableViewCell:(ExchangeSelectedTableViewCell *)exchangeSelectedTableViewCell cellForRowAtIndexPath:(NSIndexPath *)indexPath dataModel:(ExchangeModel *)exchange didAddAndSubtractButton:(UIButton *)button buttonIndex:(NSInteger)index {

    if (index == 0) {
        NSArray *array              = self.exchangeMessageArray[indexPath.section];
        ExchangeModel *exchange     = array[indexPath.row];
        self.shopNumber             = [self countNumber:index countNumber:exchange.exchangeDesc];
        self.totalPrice             = [NSString stringWithFormat:@"%i", [self.shopNumber intValue] * [self.shopPoint intValue]];
        [self initData];
        [self.exchangeMessageTableView reloadData];
    }
    
    if (index == 1) {
        NSArray *array              = self.exchangeMessageArray[indexPath.section];
        ExchangeModel *exchange     = array[indexPath.row];
        self.shopNumber             = [self countNumber:index countNumber:exchange.exchangeDesc];
        self.totalPrice             = [NSString stringWithFormat:@"%i", [self.shopNumber intValue] * [self.shopPoint intValue]];
        [self initData];
        [self.exchangeMessageTableView reloadData];
        
    }
}

/**
 *  计算商品的增加 或 减少
 *
 *  @param type     判断增加 或 减少
 *  @param number   需要计算的数据
 *
 *  @return
 */
- (NSString *) countNumber:(NSInteger)type countNumber:(NSString *)number  {
    
    int sum = 0;
    
    if (type == 0) {
        sum = [number intValue];
        if (sum == 0) {
            return [NSString stringWithFormat:@"%i", sum];
        }
        sum--;
    }
    if (type == 1) {
        sum = [number intValue];
        sum++;
    }
    return [NSString stringWithFormat:@"%i", sum];
}


#pragma mark - ExchangeInputTableViewCell Delegate Method
/**
 *  ExchangeInputTableViewCell Delegate (取出 用户输入的信息)
 *
 *  @param cell
 *  @param indexPath
 *  @param value
 */
- (void)textFieldCell:(ExchangeInputTableViewCell *)cell updateTextLabelAtIndexPath:(NSIndexPath *)indexPath string:(NSString *)value {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.userName = value;
            NSLog(@"%@", self.userName);
        }
        
        if (indexPath.row == 1) {
            self.userTel = value;
            NSLog(@"%@", self.userTel);
        }
    }
}

#pragma mark - DidButtonMethod
/**
 *  当前控制器 所有安按钮绑定方法
 *
 *  @param button
 */
- (void) didButton:(UIButton *)button {
    button.enabled = NO;
    if (![self checkCommitData]) {
        button.enabled = YES;
        return;
    }
    [self commitData:button];
}


#pragma mark - DataDisposeMethod
/**
 *  提交 兑换商品数据
 */
- (void) commitData:(UIButton *)button {
    if (self.userTel.length != 11) {
        button.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请输入有效的手机号"];
        return;
    }
    NSLog(@"%@",self.userName);
    if ([[self.totalPrice substringToIndex:self.totalPrice.length] floatValue] < 0) {
        [SVProgressHUD showErrorWithStatus:@"积分不足"];
        button.enabled = YES;
        return;
    }
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"mall_order"];//[NSString stringWithFormat:@"http://%@/%@",baseUrl, connect_url(@"mall_order")];
    NSDictionary *dic = @{
                          @"app_key"     : url,
                          @"u_name"      : self.userName,
                          @"tel"         : self.userTel,
                          @"integral_id" : _pointShop.goodsId,
                          @"pay_integral": [self.totalPrice substringToIndex:self.totalPrice.length],
//                          @"u_id"        : GetUserDefault(U_ID),
                          @"u_id"        : [PersonInfoModel shareInstance].uID,
                          @"num"         : self.shopNumber
                          };
    
   [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
       
       NSLog(@"%@",resultObject);
       if ([resultObject[@"code"] integerValue] == 200) {
           [PersonInfoModel shareInstance].myJifen = [NSString stringWithFormat:@"%d",[resultObject[@"obj"][@"integral"] intValue]];
           NSArray *arr = self.navigationController.viewControllers;
           for (MallO2OBaseViewController *vc in arr) {
               if ([vc isKindOfClass:[PointShopViewController class]]) {
                   PointShopViewController *viewController = (PointShopViewController *)vc;
                   [self.navigationController popToViewController:viewController animated:YES];
                   viewController.svpShowMessage = resultObject[@"message"];
               }
           }
       }
       button.enabled = YES;
   } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
       button.enabled = YES;
   }];
    
//    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        NSLog(@"%@",param);
//        if ([param[@"code"] integerValue] == 200) {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:GetUserDefault(Person_Info)];
//            [dic setValue:[NSString stringWithFormat:@"%@",param[@"obj"][@"integral"] ] forKey:@"integral"];
//            SetUserDefault(dic, Person_Info);
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            NSMutableArray *arr = self.navigationController.viewControllers.mutableCopy;
//            self.navigationController.viewControllers = arr;
//            PointShopViewController *viewController = arr[1];
//            [self.navigationController popToViewController:viewController animated:YES];
////            [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//            viewController.svpShowMessage = param[@"message"];
//        }
//        button.enabled = YES;
//    } andErrorBlock:^(NSError *error) {
//        button.enabled = YES;
//    }];
}

/**
 *  验证 提交商品信息
 *
 *  @return
 */
- (BOOL) checkCommitData  {
    
    
    if ([self.totalPrice intValue] == 0) {
        [SVProgressHUD showErrorWithStatus:@"数量不能为0"];
        return NO;
    }
    
//    NSString *pointText = [GetUserDefault(Person_Info) objectForKey:@"integral"];
    NSString *pointText = [PersonInfoModel shareInstance].myJifen;
    if ([pointText intValue] <= [self.totalPrice intValue]) {
        [SVProgressHUD showErrorWithStatus:@"积分不够！"];
        return NO;
    }
    
    if ([UZCommonMethod trimString:self.userName].length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        return NO;
    }
    
    if ([UZCommonMethod trimString:self.userTel].length == 0) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        return NO;
    }

    return YES;
}
//
#pragma mark - UIInitMethod
- (UITableView *)exchangeMessageTableView {
    
    if (!_exchangeMessageTableView) {
        _exchangeMessageTableView = [[UITableView alloc] initForAutoLayout];
        _exchangeMessageTableView.dataSource = self;
        _exchangeMessageTableView.delegate   = self;
        _exchangeMessageTableView.rowHeight  = 44;
        [UZCommonMethod hiddleExtendCellFromTableview:_exchangeMessageTableView];
        
    }
    return _exchangeMessageTableView;
}
//
- (UIButton *)commitButton {
    
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initForAutoLayout];
        [_commitButton setTitle:@"确认兑换" forState:UIControlStateNormal];
        _commitButton.backgroundColor = UIColorFromRGB(0x78c4d2);
        _commitButton.layer.cornerRadius = 4;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        _commitButton.tag = 1;
    }
    return _commitButton;
}

/**
 *  控制器销毁
 */
- (void)dealloc{
    NSLog(@"控制器已销毁");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
