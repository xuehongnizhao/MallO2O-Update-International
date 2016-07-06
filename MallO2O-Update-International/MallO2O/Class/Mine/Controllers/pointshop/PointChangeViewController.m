//
//  PointChangeViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointChangeViewController.h"
#import "PointChangeTableViewCell.h"

@interface PointChangeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *pointTableView;

@end

@implementation PointChangeViewController{
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
    [self getDataFromUrl];
}

- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_point_log"];//[NSString stringWithFormat:@"http://%@/%@",baseUrl, connect_url(@"my_point_log")];
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id" : GetUserDefault(U_ID)
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
//    
//    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:YES swpResultSuccess:^(id  _Nonnull resultObject) {
//        
//    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
//        
//    }];
    [SwpRequest swpPOST:url parameters:dic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        tableViewArray = resultObject[@"obj"];
        [_pointTableView reloadData];
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
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
    [self setNavBarTitle:@"积分记录" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _pointTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_pointTableView];
    _pointTableView.delegate = self;
    _pointTableView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_pointTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_pointTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark tableview数据源方法和委托
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PointChangeTableViewCell *cell = [PointChangeTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    [cell setGoodsName:[tableViewArray[indexPath.row] objectForKey:@"site_name"]];
    [cell setGoodsMuch:[tableViewArray[indexPath.row] objectForKey:@"point"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
