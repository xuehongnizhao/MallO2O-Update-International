//
//  CateJumpViewController.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateJumpViewController.h"//抢购控制器
#import "MiaoTableViewCell.h"//抢购的cell视图
#import "SecondModel.h"//秒杀模型   很多地方复用
#import "GoodsWebViewController.h"//商品详情页
#import <MJRefresh.h>
#import "SecondGoodsCollectionViewCell.h"//秒杀九宫格cell

@interface CateJumpViewController ()<UITableViewDataSource ,UITableViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout ,SecondGoodsCollectionViewCellDelegate>

@property (strong ,nonatomic) UITableView *secondTableView;

@property (strong ,nonatomic) UICollectionView *secondCollectionView;

@property (strong ,nonatomic) NSMutableArray *secondListArray;//模型数组

@end

@implementation CateJumpViewController{
    int page;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    [self initUI];
    [self setBackButton];
    [self getDataFromUrl];
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
    _secondListArray = [[NSMutableArray alloc] init];
//    [self getDataFromUrl];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    [_secondTableView.mj_header beginRefreshing];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:self.nameTitle withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    _secondTableView = [[UITableView alloc] initForAutoLayout];
    [UZCommonMethod hiddleExtendCellFromTableview:_secondTableView];
    _secondTableView.dataSource = self;
    _secondTableView.delegate = self;
//    [self.view addSubview:_secondTableView];
    [self.view addSubview:self.secondCollectionView];
    [self initData];
    [self swpPublicToolSettingTableViewRefreshing:_secondTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [_secondTableView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_secondTableView.mj_header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_secondTableView.mj_footer endRefreshing];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    [_secondTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark 从网络获取数据
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"spike_list"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"page"      : [NSString stringWithFormat:@"%d",page],
                          @"city_id" : GetUserDefault(City_ID)
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        if ([(NSMutableArray *)resultObject[@"obj"] count] == 0) {
            [_secondTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        _secondListArray = [self arrayWithUrlDataArray:resultObject[@"obj"]];
        [self.secondCollectionView reloadData];
        [self.secondTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        
    }];
    
}

/**
 数据转成模型数组
 */
- (NSMutableArray *)arrayWithUrlDataArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = _secondListArray;
    }
    for (NSDictionary *dic in param) {
        SecondModel *model = [SecondModel initWithModel:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark 设置tableView的代理方法和tableView的数据源
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewP{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _secondListArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    NSLog(@"%@",_secondListArray);
    [UZCommonMethod settingTableViewAllCellWire:_secondTableView andTableViewCell:cell];
    cell.secondModel = _secondListArray[indexPath.row];
    cell.secondImgView.layer.borderWidth = 0;
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = _secondListArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
    tableview的懒加载
 */
- (UITableView *)secondTableView{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initForAutoLayout];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
//        [_secondTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshingData)];
//        [_secondTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingData)];
    }
    return _secondTableView;
}

#pragma mark - collection的试图   以下
- (UICollectionView *)secondCollectionView{
    if (!_secondCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.minimumLineSpacing = 3;
        _secondCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        [_secondCollectionView registerClass:[SecondGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"secondCollectionCell"];
        _secondCollectionView.delegate = self;
        _secondCollectionView.dataSource = self;
        _secondCollectionView.backgroundColor = UIColorFromRGB(0xf3f4f6);
    }
    return _secondCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _secondListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SecondGoodsCollectionViewCell *cell = [SecondGoodsCollectionViewCell secondGoodsCollection:collectionView cellForRowAtIndexPath:indexPath cellID:@"secondCollectionCell"];
    cell.delegate = self;
    cell.model = _secondListArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(158.5 * Balance_Width, 238 * Balance_Heith);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = _secondListArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clickCellButton:(NSInteger)index{
    NSLog(@"%d",(int)index);
}

@end
