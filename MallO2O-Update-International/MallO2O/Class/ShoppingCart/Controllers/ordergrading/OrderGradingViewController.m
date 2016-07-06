//
//  OrderGradingViewController.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OrderGradingViewController.h"
#import "OrderGradingModel.h"
#import "OrderGradingTableViewCell.h"
#import "AppraisalViewController.h"

@interface OrderGradingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *gradingTableView;

@end

@implementation OrderGradingViewController{
    NSMutableArray *tableViewArray;
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
    tableViewArray = [[NSMutableArray alloc] init];
    [self getDataFromUrl];
}

- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"goods_comment_list"];//connect_url(@"goods_comment_list");
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"order_id"    : _order_id,
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        
        tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
        [_gradingTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
//    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        if ([param[@"code"] integerValue] == 200) {
//            tableViewArray = [self arrayWithParam:param[@"obj"]];
//            [_gradingTableView reloadData];
//        }else{
//            [SVProgressHUD showErrorWithStatus:param[@"message"]];
//        }
//    } andErrorBlock:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络异常"];
//    }];
}

- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        OrderGradingModel *model = [OrderGradingModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
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
    [self setNavBarTitle:@"发布评价" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.gradingTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_gradingTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark tableivew委托和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderGradingTableViewCell *cell = [OrderGradingTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    cell.orderModel = tableViewArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderGradingModel *model = tableViewArray[indexPath.row];
    AppraisalViewController *viewController = [[AppraisalViewController alloc] init];
    viewController.orderId = _order_id;
    viewController.goods_id = model.goodsId;
    viewController.og_id = model.og_id;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableView *)gradingTableView{
    if (!_gradingTableView) {
        _gradingTableView = [[UITableView alloc] initForAutoLayout];
        [UZCommonMethod hiddleExtendCellFromTableview:_gradingTableView];
        _gradingTableView.delegate = self;
        _gradingTableView.dataSource = self;
    }
    return _gradingTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45 * Balance_Heith;
}

@end
