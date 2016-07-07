//
//  ExchangeRecordViewController.m
//  cityo2o
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "ExchangeRecordViewController.h"
#import "recordInfo.h"
#import "recordTableViewCell.h"
#import "ExchangeRecordDetailViewController.h"
#import "UIViewController+XHLoadingNavigationItemTitle.h"
@interface ExchangeRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *recordArray;
}
@property (strong,nonatomic)UITableView *recordTableview;
@end

@implementation ExchangeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setUI];
    [self getDataFromNet];
    self.title = @"兑换记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark----tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"my_gift_cell";
    recordTableViewCell *cell=(recordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil)
    {
        cell = [[recordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
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
    recordInfo *info =[recordArray objectAtIndex:indexPath.row];
    [cell configureCell:info];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recordArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    recordInfo *info =[recordArray objectAtIndex:indexPath.row];
    ExchangeRecordDetailViewController *firVC = [[ExchangeRecordDetailViewController alloc] init];
    [firVC setNavBarTitle:@"兑换记录" withFont:14.0f];
    [firVC setHiddenTabbar:YES];
    firVC.url = info.messge_url;
    [self.navigationController pushViewController:firVC animated:YES];
}

#pragma mark----set UI
-(void)setUI
{
    [self.view addSubview:self.recordTableview];
    [_recordTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_recordTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [_recordTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_recordTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self followScrollView:_recordTableview];
}

-(void)initData
{
    recordArray = [[NSMutableArray alloc] init];
}

#pragma mark-----获取网络数据
-(void)getDataFromNet
{
    NSString *tmp_url = [SwpTools swpToolGetInterfaceURL:@"mall_list"];
    NSDictionary *dict = @{
                           @"app_key":tmp_url,
                           @"u_id":[UserModel shareInstance].u_id
                           };
    [self startAnimationTitle];
    [SwpRequest swpPOST:tmp_url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            NSArray *myArray = resultObject[@"obj"];
            for (NSDictionary *dic in myArray) {
                recordInfo *info = [[recordInfo alloc] initWithDictionary:dic];
                [recordArray addObject:info];
            }
            [self.recordTableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }
        [self stopAnimationTitle];

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

}

#pragma mark-----get UI
-(UITableView *)recordTableview
{
    if (!_recordTableview) {
        _recordTableview = [[UITableView alloc] initForAutoLayout];
        _recordTableview.delegate = self;
        _recordTableview.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_recordTableview];
        if ([_recordTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_recordTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        if ([_recordTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_recordTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _recordTableview;
}

@end
