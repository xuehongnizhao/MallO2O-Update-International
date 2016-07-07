//
//  ShopActivityViewController.m
//  CardLeap
//
//  Created by mac on 15/2/4.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "ShopActivityViewController.h"
#import "AcitvityTableViewCell.h"
#import "activityInfo.h"

@interface ShopActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *activityArray;
}
@property (strong,nonatomic)UITableView *shopActivityTableview;
@end

@implementation ShopActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setUI];
    [self getData];
}


#pragma mark-----init data
-(void)initData
{
    activityArray = [[NSMutableArray alloc] init ];
}

#pragma mark-----get data
-(void)getData
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"activity_shop"];
    NSDictionary *dict = @{
                           @"app_key":url,
                           @"shop_id":self.shop_id
                           };
    [SwpRequest swpPOST:url parameters:dict isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            [SVProgressHUD dismiss];
            NSArray *arr = resultObject[@"obj"];
            for (NSDictionary *dic in arr) {
                activityInfo *info = [[activityInfo alloc] initWithDictionary:dic];
                [activityArray addObject:info];
            }
            [self.shopActivityTableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }

        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            
        }];

}

#pragma mark-----set UI
-(void)setUI
{
    [self.view addSubview:self.shopActivityTableview];
    [_shopActivityTableview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_shopActivityTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [_shopActivityTableview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [_shopActivityTableview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
}

#pragma mark-----get UI
-(UITableView *)shopActivityTableview
{
    if (!_shopActivityTableview) {
        _shopActivityTableview = [[UITableView alloc] initForAutoLayout];
        _shopActivityTableview.delegate = self;
        _shopActivityTableview.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_shopActivityTableview];
        if ([_shopActivityTableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_shopActivityTableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        if ([_shopActivityTableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_shopActivityTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _shopActivityTableview;
}
#pragma mark-----tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"干嘛的-----");
    activityInfo *info = [activityArray objectAtIndex:indexPath.row];
    ZQFunctionWebController *firVC = [[ZQFunctionWebController alloc] init];
    [firVC setHiddenTabbar:YES];
    [firVC setNavBarTitle:info.activity_name withFont:14.0f];
//    [firVC.navigationItem setTitle:info.activity_name];
    firVC.url = info.message_url;
    [self.navigationController pushViewController:firVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier=@"shop_activity_cell";
    AcitvityTableViewCell *cell=(AcitvityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil)
    {
        cell = [[AcitvityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject]removeFromSuperview];
    }
    activityInfo *info = [activityArray objectAtIndex:indexPath.row];
    [cell confirgureCell:info];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [activityArray count];
}



@end
