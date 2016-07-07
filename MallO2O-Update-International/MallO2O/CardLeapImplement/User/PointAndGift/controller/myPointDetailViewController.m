//
//  myPointDetailViewController.m
//  cityo2o
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "myPointDetailViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "myPointDetalTableViewCell.h"
#import "ExchangeRecordDetailViewController.h"
#import "myPointInfo.h"

@interface myPointDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;//分页
    NSMutableArray *myPointListArray;//详细列表数组
}
@property (strong,nonatomic) UITableView *myPointTableview;//积分详细列表
@property (strong,nonatomic) UIButton *hintButton;
@end

@implementation myPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setUI];
    [self getDataFromNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-----设置界面
-(void)setUI
{
    [self.view addSubview:self.myPointTableview];
    [_myPointTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_myPointTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [_myPointTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_myPointTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.hintButton];
    self.navigationItem.rightBarButtonItem = rightBar;
}

#pragma mark------初始化数据
-(void)initData
{
    page = 1;
    myPointListArray = [[NSMutableArray alloc] init];
}

#pragma mark-----积分详细列表
-(UITableView *)myPointTableview
{
    if (!_myPointTableview) {
        _myPointTableview = [[UITableView alloc] initForAutoLayout];
        _myPointTableview.delegate = self;
        _myPointTableview.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_myPointTableview];
        _myPointTableview.mj_footer=[MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerBeginRefreshing)];
        _myPointTableview.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerBeginRefreshing)];

        if ([_myPointTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_myPointTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([_myPointTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_myPointTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _myPointTableview;
}

#pragma mark-------积分说明文档
-(UIButton *)hintButton
{
    if (!_hintButton) {
        _hintButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_hintButton setTitle:@"积分说明" forState:UIControlStateNormal];
        [_hintButton setTitle:@"积分说明" forState:UIControlStateHighlighted];
        _hintButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_hintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_hintButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_hintButton addTarget:self action:@selector(hintAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hintButton;
}

#pragma mark-------上拉加载 下拉刷新方法
-(void)headerBeginRefreshing
{
    page = 1;
    [self getDataFromNetwork];
}

-(void)footerBeginRefreshing
{
    page++;
    [self getDataFromNetwork];
}

#pragma mark-------跳转积分说明
-(void)hintAction:(UIButton*)sender
{
    ExchangeRecordDetailViewController *firVC = [[ExchangeRecordDetailViewController alloc] init];
    [firVC setHiddenTabbar:YES];
    [firVC setNavBarTitle:@"积分说明" withFont:14.0f];
    firVC.url = [NSString stringWithFormat:@"http://%@/%@",baseUrl, [SwpTools swpToolGetInterfaceURL:@"point_message"]];
    [self.navigationController pushViewController:firVC animated:YES];
}

#pragma mark-------获取网络数据
-(void)getDataFromNetwork
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"my_point_log"];
    NSDictionary *dict = @{
                           @"app_key":url,
                           @"u_id":[UserModel shareInstance].u_id,
                           @"page":[NSString stringWithFormat:@"%d",page]
                           };
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            NSArray *myArray = resultObject[@"obj"];
            if (page == 1) {
                [myPointListArray removeAllObjects];
            }
            for (NSDictionary *dic in myArray) {
                myPointInfo *info = [[myPointInfo alloc] initWithDictionary:dic];
                [myPointListArray addObject:info];
            }
            [self.myPointTableview.mj_header beginRefreshing];
            [self.myPointTableview.mj_footer beginRefreshing];
            [self.myPointTableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];
}

#pragma mark-------tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"my_point_cell";
    myPointDetalTableViewCell *cell=(myPointDetalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil)
    {
        cell = [[myPointDetalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject]removeFromSuperview];
    }
    //----自定义操作----------
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    myPointInfo *tmpInfo = [myPointListArray objectAtIndex:indexPath.row];
    [cell configureCell:tmpInfo];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myPointListArray count];
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
