//
//  MessageViewController.m
//  MallO2O
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "OrderDetailViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong ,nonatomic) UITableView *messageTableView;

@end

@implementation MessageViewController{
    NSArray *messageArray;
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
    [self getDataFromUrl];
}

/**
 获取数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_message"];
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id" : GetUserDefault(U_ID)
                          @"u_id"    : [UserModel shareInstance].u_id
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        messageArray = [self arrayWithParam:resultObject[@"obj"]];
        [self.messageTableView reloadData];

    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
//    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        if ([param[@"code"] integerValue] == 200) {
//            messageArray = [self arrayWithParam:param[@"obj"]];
//            [self.messageTableView reloadData];
//        }
//    } andErrorBlock:^(NSError *error) {
//        
//    }];
}

/**
 数组转模型数组
 */
- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        MessageModel *model = [MessageModel arrayWithDic:dic];
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
    [self setNavBarTitle:NSLocalizedString(@"messageNewsNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self settingDeleteMessageButton];
}

- (void)settingDeleteMessageButton{
    UIButton *deleteMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteMessage.frame = CGRectMake(0, 0, 35, 35);
    [deleteMessage setBackgroundImage:[UIImage imageNamed:@"delete_msg_sel"] forState:UIControlStateHighlighted];
    [deleteMessage setBackgroundImage:[UIImage imageNamed:@"delete_msg_sel"] forState:UIControlStateNormal];
    [deleteMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteMessage addTarget:self action:@selector(deleteMessage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteMessage];
}

- (void)deleteMessage{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"messageNewsClearAllTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_message_time"];
        NSDictionary *dic = @{
                              @"app_key" : url,
//                              @"u_id" : GetUserDefault(U_ID)
                              @"u_id"    : [UserModel shareInstance].u_id
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            [self getDataFromUrl];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
        
//        [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//            if ([param[@"code"] integerValue] == 200) {
//                [self getDataFromUrl];
//                [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//            }else{
//                [SVProgressHUD showErrorWithStatus:param[@"message"]];
//            }
//        } andErrorBlock:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:@"网络异常"];
//        }];
    }
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.messageTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_messageTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark - tableview的委托
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [MessageTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
    cell.model = messageArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = messageArray[indexPath.row];
    OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
    viewController.webTitle = @"消息详情";
    viewController.webUrl = model.message_url;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)messageTableView{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initForAutoLayout];
        [UZCommonMethod hiddleExtendCellFromTableview:_messageTableView];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
    }
    return _messageTableView;
}

@end
