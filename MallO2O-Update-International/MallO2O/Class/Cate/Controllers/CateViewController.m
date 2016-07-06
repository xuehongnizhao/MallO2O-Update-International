//
//  CateViewController.m
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateViewController.h"
#import "CateTableViewCell.h"
#import "TabCateModel.h"
#import "CateCollectionViewCell.h"
#import <MJRefresh.h>
#import "CateGoodsViewController.h"
#import "NaviSearchView.h"
#import "SearchHisViewController.h"
#import "CateHeaderCollectionReusableView.h"

@interface CateViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NaviSearchViewDelegate>

@property (strong ,nonatomic) UITableView *cateTableView;//列表UI

@property (strong ,nonatomic) UICollectionView *cateCollectionView;//九宫格UI

@property (strong ,nonatomic) NaviSearchView *searchView;//搜索视图

@end

@implementation CateViewController{
    NSMutableArray *tableViewArray;//列表数据数组
    NSString *cate_id;//分类ID
    NSMutableArray *collectionArray;//九宫格的数据数组
    NSMutableArray *collectionHeaderArray;//列表头部的数组
    int page;//分页
    NSInteger selectIndexPath;//选择的列表index
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.identifier != nil) {
        [self setBackButton];
    }
    [self initData];
    [self initUI];
    [SVProgressHUD showWithStatus:@"加载中..."];
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

    
    if (_searchView) {
        _searchView.hidden = NO;
    }
}

/**
 *  视图即将出现时调用
 *
 *  @param animated
 */
- (void) viewWillDisappear:(BOOL)animated{
    _searchView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.identifier != nil) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }else{
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    collectionArray = [[NSMutableArray alloc] init];
    collectionHeaderArray = [NSMutableArray array];
    cate_id = [[NSString alloc] init];
    [self getDataFromUrl];
}

#pragma mark 获取网络数据
/**
 *  获取tableview的数据
 */
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"class_zero_cate"];
    NSDictionary *dic = @{
                          @"app_key" : url
                          };
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
        NSMutableArray *tArray = [NSMutableArray array];
        tArray = resultObject[@"obj"];
        cate_id = [tArray[0] objectForKey:@"cat_id"];
        [self getCollectionViewDataFromUrl];
        [_cateTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
  数据转换成模型数组
 */
- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        TabCateModel *model = [TabCateModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

/**
 *  获取九宫格的数据
 */
-(void)getCollectionViewDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"class_one_cate"];
    if (cate_id == nil || cate_id.length == 0) {
        cate_id = @"0";
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"cat_id"  : cate_id,
                          @"page"    : [NSString stringWithFormat:@"%d",page]
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        collectionArray = [self collectionArrayWithParam:resultObject[@"obj"]];
        collectionHeaderArray = [self collectionArrayWithHeaderParam:resultObject[@"obj"]];
        if ([(NSMutableArray *)resultObject[@"obj"] count] == 0) {
            [_cateCollectionView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [_cateCollectionView reloadData];
//        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        [SVProgressHUD dismiss];
       
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 九宫格cell数据转换成模型数组
 */
- (NSMutableArray *)collectionArrayWithHeaderParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = collectionHeaderArray;
    }
    for (NSDictionary *dic in param) {
        CateCollectionModel *model = [CateCollectionModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}
/**
 九宫格的头部数据数组
 */
- (NSMutableArray *)collectionArrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = collectionArray;
    }
    for (int i = 0;i < param.count ; i ++ ) {
        [array addObject:[self sonArrayWithParam:[param[i] objectForKey:@"son"]]];
    }
    return array;
}

/**
 *  数组转模型
 *
 *  @param param 网络数据
 *
 *  @return 返回的是模型数组
 */
- (NSMutableArray *)sonArrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        CateCollectionModel *model = [CateCollectionModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

/**
 返回首页
 */
- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index{
    self.rdv_tabBarController.selectedIndex = index;
    if (index == 0) {
        SetUserDefault(@"返回首页", @"back_home_view");
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
//    [self setNavBarTitle:@"分类" withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    _cateTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_cateTableView];
    _cateTableView.delegate = self;
    _cateTableView.dataSource = self;
//    _cateTableView.layer.borderWidth = 0.5;
    _cateTableView.backgroundColor = UIColorFromRGB(0xf3f4f6);
    self.cateTableView.showsVerticalScrollIndicator = NO;
    [UZCommonMethod hiddleExtendCellFromTableview:_cateTableView];
    [self.navigationController.navigationBar addSubview:self.searchView];
    [self addCollectionView];
    self.view.backgroundColor = UIColorFromRGB(0xf3f4f6);
}

/**
 *  add collectionview
 */
- (void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 6;
    float width = SCREEN_HEIGHT - 113;
    if (self.identifier != nil) {
        width = SCREEN_HEIGHT - 20;
    }
    _cateCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(85 * Balance_Width, 0, 230 * Balance_Width, width) collectionViewLayout:flowLayout];
    [_cateCollectionView registerClass:[CateCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_cateCollectionView registerClass:[CateHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"title"];
    _cateCollectionView.delegate = self;
    _cateCollectionView.dataSource = self;
    _cateCollectionView.backgroundColor = UIColorFromRGB(0xf3f4f6);
    
    [self swpPublicToolSettingCollectionViewRefreshing:_cateCollectionView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];

    
    [self.view addSubview:_cateCollectionView];
    _cateCollectionView.showsVerticalScrollIndicator = NO;
}

#pragma mark 上啦加载和下拉刷新
- (void)footerRefreshingData{
    page ++;
    [self getCollectionViewDataFromUrl];
    [_cateCollectionView.mj_footer endRefreshing];
}

- (void)headerRefreshingData{
    page = 1;
    if (tableViewArray.count == 0) {
        [self getDataFromUrl];
    }
    [_cateCollectionView.mj_footer setState:MJRefreshStateIdle];
    [self getCollectionViewDataFromUrl];
    [_cateCollectionView.mj_header endRefreshing];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    float width = 49;
    if (self.identifier != nil) {
        width = 0;
    }
    [_cateTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_cateTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_cateTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:width];
    [_cateTableView autoSetDimension:ALDimensionWidth toSize:80 * Balance_Width];
//    _cateCollectionView.layer.borderWidth = 0.6;
//    _cateCollectionView.layer.borderColor = UIColorFromRGB(0xe3e3e3).CGColor;
}

#pragma mark tableview数据源方法和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CateTableViewCell *cell = [CateTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CateTableViewCell *cell1 = (CateTableViewCell *)cell;
    cell1.selectIndex = indexPath.row;
    [cell1 selectIndex:selectIndexPath];
    cell1.model = [tableViewArray objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TabCateModel *model = [tableViewArray objectAtIndex:indexPath.row];
    [_cateCollectionView.mj_footer setState:MJRefreshStateIdle];
    selectIndexPath = indexPath.row;
    [_cateTableView reloadData];
    cate_id = model.cate_id;
    page = 1;
//    [self getCollectionViewDataFromUrl];
    [self.cateCollectionView.mj_header beginRefreshing];
}

#pragma mark collectionview数据源方法和代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return collectionHeaderArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = [collectionArray objectAtIndex:section];
    
    return array.count;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(74 * Balance_Width, 92 * Balance_Heith);
}

//每个item的边距 上左下右
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CateCollectionViewCell *cell = [CateCollectionViewCell cellOfCollectionView:collectionView cellForRowAtIndex:indexPath];
    cell.model = collectionArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CateCollectionModel *model = collectionArray[indexPath.section][indexPath.row];
    NSLog(@"%@",collectionArray);
    CateGoodsViewController *viewController = [[CateGoodsViewController alloc] init];
    NSLog(@"%@",model.goodsId);
    viewController.cate_id = model.goodsId;
    viewController.cate_name = model.goodsName;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CateHeaderCollectionReusableView *view = [CateHeaderCollectionReusableView viewInCollection:_cateCollectionView reuserIdentifier:@"title" atIndexPath:indexPath];
    if (collectionHeaderArray.count > 0) {
        CateCollectionModel *cateModel = [collectionHeaderArray objectAtIndex:indexPath.section];
        view.titleLabelString = cateModel.goodsName;
    }
    return view;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH - 80 * Balance_Width, 45);
}

#pragma mark 导航栏搜索条的委托
- (void)clickNaviSearchView{
    SearchHisViewController *viewController = [[SearchHisViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
  懒加载
 */
- (NaviSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[NaviSearchView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 125 * Balance_Width, 8, 250 * Balance_Width, 30)];
        _searchView.delegate         = self;
        _searchView.textLabelString  = NSLocalizedString(@"cateSearchBarPlaceholder", nil);
        _searchView.textColor        = [UIColor grayColor];
//        _searchView.backGroudColor   = UIColorFromRGB(0xe87379);
        _searchView.backgroundColor = SWPColor(204, 204, 204, 1);
        _searchView.shopCarImageName = @"gray_shopcar";
        _searchView.cornerRadius     = 4;
//        _searchView.layer.borderWidth = 0.5;
        _searchView.imageSize        = CGSizeMake(15, 15);
//        _searchView.backGroudColor   = UIColorFromRGB(0xffffff);
    }
    return _searchView;
}

@end
