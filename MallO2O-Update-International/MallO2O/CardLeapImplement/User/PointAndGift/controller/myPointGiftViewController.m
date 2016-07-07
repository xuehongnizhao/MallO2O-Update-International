//
//  myPointGiftViewController.m
//  cityo2o
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "myPointGiftViewController.h"
#import "myPointGiftTableViewCell.h"
#import "myPointGiftInfo.h"
#import "myPointGiftTableViewCell.h"
#import "UIScrollView+MJRefresh.h"
#import "ExchangeRecordViewController.h"
#import "pintGIftDetailViewController.h"

@interface myPointGiftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *giftArray;//礼品
    NSString *myPoint;//用户积分数量
    int page;//分页
}
@property (strong,nonatomic)UITableView *myGiftTableview;
@end

@implementation myPointGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setUI];
    [self getDataFromNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark------setUI 设置界面显示
-(void)setUI
{
    [self.view addSubview:self.myGiftTableview];
    [_myGiftTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_myGiftTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [_myGiftTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_myGiftTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
//    [self followScrollView:_myGiftTableview];
}

#pragma mark-------初始化数据
-(void)initData
{
    giftArray = [[NSMutableArray alloc] init];
    page = 1;
}

#pragma mark-------获取网络数据在这里
-(void)getDataFromNet
{
    NSString *tmp_url =  [SwpTools swpToolGetInterfaceURL:@"mall"];
    NSDictionary *dict = @{
                           @"app_key":tmp_url,
                           @"page":[NSString stringWithFormat:@"%d",page],
                           @"u_id":[UserModel shareInstance].u_id
                           };
    [_myGiftTableview.mj_header beginRefreshing];
    [_myGiftTableview.mj_footer beginRefreshing];
    [SwpRequest swpPOST:tmp_url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [_myGiftTableview reloadData];

        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            if (page == 1) {
                [giftArray removeAllObjects];
            }
            NSArray *array = [resultObject[@"obj"] objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                myPointGiftInfo *info = [[myPointGiftInfo alloc] initWithDictionary:dic];
                [giftArray addObject:info];
            }
            //刷新列表

        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

   }

#pragma mark------tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"my_gift_cell";
    myPointGiftTableViewCell *cell=(myPointGiftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil)
    {
        cell = [[myPointGiftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
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

    myPointGiftInfo *info = [giftArray objectAtIndex:indexPath.row];
    [cell configureCell:info];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [giftArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tmp_view = [[UIView alloc] init];
    [tmp_view setBackgroundColor:UIColorFromRGB(0xf3f3f3)];
    //标题lable
    UILabel *titleLable = [[UILabel alloc] initForAutoLayout];
    [tmp_view addSubview:titleLable];
    [titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0f];
    [titleLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5.0f];
    [titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    titleLable.text = @"我的积分：";
    titleLable.font = [UIFont systemFontOfSize:14.0f];
    titleLable.textColor = UIColorFromRGB(singleTitle);
    //积分lable
    UILabel *pointLable = [[UILabel alloc] initForAutoLayout];
    [tmp_view addSubview:pointLable];
    [pointLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0f];
    [pointLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5.0f];
    [pointLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:titleLable withOffset:3.0f];
    [pointLable autoSetDimension:ALDimensionWidth toSize:140.0f];
    pointLable.text = [UserModel shareInstance].pay_point;
    pointLable.font = [UIFont systemFontOfSize:14.0f];
    pointLable.textColor = UIColorFromRGB(0xe38383);
    //兑换记录button
    UIButton *mallButton = [[UIButton alloc] initForAutoLayout];
    [tmp_view addSubview:mallButton];
    [mallButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [mallButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5.0f];
    [mallButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5.0f];
    [mallButton autoSetDimension:ALDimensionWidth toSize:80.0f];
    mallButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [mallButton setTitle:@"兑换记录" forState:UIControlStateNormal];
    [mallButton setTitle:@"兑换记录" forState:UIControlStateHighlighted];
    [mallButton setTitleColor:UIColorFromRGB(0x09b3cd) forState:UIControlStateNormal];
    [mallButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [mallButton setBackgroundColor:[UIColor clearColor]];
    [mallButton addTarget:self action:@selector(JumpAction:) forControlEvents:UIControlEventTouchUpInside];
    return tmp_view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    myPointGiftInfo *info = [giftArray objectAtIndex:indexPath.row];
    pintGIftDetailViewController *firVC = [[pintGIftDetailViewController alloc] init];
    [firVC setHiddenTabbar:YES];
    [firVC setNavBarTitle:@"礼品详情" withFont:14.0f];
    firVC.detailInfo = info;
    [self.navigationController pushViewController:firVC animated:YES];
}

#pragma mark------get UI
-(UITableView *)myGiftTableview
{
    if (!_myGiftTableview) {
        _myGiftTableview = [[UITableView alloc] initForAutoLayout];
        _myGiftTableview.delegate = self;
        _myGiftTableview.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_myGiftTableview];
        _myGiftTableview.mj_footer=[MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerBeginRefreshing)];
        _myGiftTableview.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerBeginRefreshing)];
        if ([_myGiftTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_myGiftTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([_myGiftTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_myGiftTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _myGiftTableview;
}

#pragma mark-------分页 刷新
-(void)headerBeginRefreshing
{
    page = 1;
    [self getDataFromNet];
}

-(void)footerBeginRefreshing
{
    page ++;
    [self getDataFromNet];
}

#pragma mark-----跳转积分兑换记录界面
-(void)JumpAction:(UIButton*)sender
{
    NSLog(@"jump action");
    ExchangeRecordViewController *firVC = [[ExchangeRecordViewController alloc] init];
    [firVC setHiddenTabbar:YES];
    [firVC setNavBarTitle:@"兑换记录" withFont:14.0f];
    [self.navigationController pushViewController:firVC animated:YES];
}


@end
