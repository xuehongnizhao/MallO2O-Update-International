//
//  CateGoodsViewController.m
//  MallO2O
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateGoodsViewController.h"
#import "MXPullDownMenu.h"
#import "cateInfo.h"
#import "MiaoTableViewCell.h"
#import "SecondModel.h"//秒杀模型  很多地方复用这个模型
#import "SelectTypeViewController.h"//筛选控制器
#import <MJRefresh.h>
#import "GoodsWebViewController.h"//商品详情web页
#import "CateGoodsButtonView.h"//排序按钮
#import "HomeCateCollectionViewCell.h"//cell
#import "NaviSearchView.h"//导航栏搜索视图
#import "CateViewController.h"
#import "SearchHisViewController.h"//搜索控制器

@interface CateGoodsViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CateGoodsButtonViewDelegate ,NaviSearchViewDelegate>

//-------------添加控件----------------------
@property (strong ,nonatomic) MXPullDownMenu *menu;
@property (strong ,nonatomic) UICollectionView *cateCollectionView; //九宫格

@property (strong ,nonatomic) CateGoodsButtonView *buttonView;

@property (strong ,nonatomic) NaviSearchView *searchView;

//-------------关于分类----------------------
//存储分类的数组
@property (strong, nonatomic) NSArray *sortArray;
//存储销量的数组
@property (strong, nonatomic) NSArray *saleArray;
//存储好评的数组
@property (strong, nonatomic) NSArray *assessArray;

//-------------创建列表----------------------
@property (strong ,nonatomic) UITableView *cateListTabelView;//列表  与九宫格切换

@property (strong ,nonatomic) NSString *getCateName;

@end

@implementation CateGoodsViewController{
    //-------------模型数组----------------------
    NSMutableArray *modelArray;
    NSString *cate_order;
    int page;
    BOOL hidderIdentifier;
    BOOL rightButtonClick;
    UIButton *rightBtn;
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
    [_cateListTabelView.mj_header beginRefreshing];
    [_cateCollectionView.mj_header beginRefreshing];
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
    self.searchView.hidden = NO;
    if (self.identifier != nil) {
        [self.cateCollectionView.mj_header beginRefreshing];
        [self.cateListTabelView.mj_header beginRefreshing];
    }
}

/**
 *  视图即将消失时调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated{
    self.searchView.hidden = YES;
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    hidderIdentifier = YES;
//    [self getDataFromUrl];
    cate_order      = [[NSString alloc] init];
    modelArray      = [[NSMutableArray alloc] init];
    _sortArray      = [NSArray array];
    _saleArray      = [NSArray array];
    _assessArray    = [NSArray array];
    [self addArray];
}

/**
 *  添加排序数组
 */
- (void)addArray{
    cateInfo *assessInf = [[cateInfo alloc] init];
    assessInf.cate_name = NSLocalizedString(@"cateGoodsPraise", nil);
    assessInf.cate_id = @"score";
    assessInf.son = [NSMutableArray array];
    self.saleArray = @[assessInf];
    
    
    cateInfo *saleInfo = [[cateInfo alloc] init];
    saleInfo.cate_name = NSLocalizedString(@"cateGoodsSalesVolume", nil);
    saleInfo.cate_id = @"num";
    saleInfo.son = [NSMutableArray array];
    self.assessArray = @[saleInfo];
    

    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = @"排序";
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    cateInfo *info = [[cateInfo alloc] init];
    info.cate_name = @"价格高排序";
    info.cate_id = @"h_price";
    info.son = [[NSMutableArray alloc] init];
    
    cateInfo *info1 = [[cateInfo alloc] init];
    info1.cate_name = @"价格低排序";
    info1.cate_id = @"d_price";
    info1.son = [[NSMutableArray alloc] init];
    self.sortArray = @[info0, info, info1];
//    [_assessArray addObjectsFromArray:@[info0,info,info1]];
}

/**
 *  获取网络数据  判断是否是经过筛选过的获取数据
 */
- (void)getDataFromUrl{
    //判断是否经过筛选
    //如果没有经过筛选 则访问的是所有数据
    //如果经过筛选  访问的是根据筛选条件而返回的数据
    if (_identifier ==nil || [_identifier isEqualToString:@""]) {
        if (cate_order == nil || [cate_order isEqualToString:@""]) {
            cate_order = @"1";
        }
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"product_list_list"];
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"cate_id" : _cate_id,
                              @"order" : cate_order,
                              @"page"   : [NSString stringWithFormat:@"%d",page],
                              @"type" : @"2",
                              @"like" : @"0",
                              @"like_spe" : @"0",
                              @"d_price" : @"0",
                              @"h_price" : @"0",
                              @"city_id" : GetUserDefault(City_ID)
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            modelArray = [self arrayWithDicArray:resultObject[@"obj"]];
            //                [SVProgressHUD showSuccessWithStatus:param[@"message"]];
            NSArray *dataArray = resultObject[@"obj"];
            //                [SVProgressHUD showSuccessWithStatus:param[@"message"]];
            if (dataArray.count == 0) {
                [self.cateListTabelView.mj_footer setState:MJRefreshStateNoMoreData];
                [self.cateCollectionView.mj_footer setState:MJRefreshStateNoMoreData];
            }
            [self.cateListTabelView reloadData];
            [self.cateCollectionView reloadData];
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }else{
        if (cate_order == nil || [cate_order isEqualToString:@""]) {
            cate_order = @"1";
        }
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"product_list_list"];
        if (_like_speString == nil || [_like_speString isEqualToString:@""]) {
            _like_speString = @"0";
        }
        if (_likeString == nil || [_likeString isEqualToString:@""]) {
            _likeString = @"0";
        }
        if (_d_price == nil || [_d_price isEqualToString:@""]) {
            _d_price = @"0";
        }
        if (_h_price == nil || [_h_price isEqualToString:@""]) {
            _h_price = @"0";
        }
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"cate_id" : _cate_id,
                              @"order" : cate_order,
                              @"page"   : [NSString stringWithFormat:@"%d",page],
                              @"type" : @"2",
                              @"like" : _likeString,
                              @"like_spe" : _like_speString,
                              @"d_price" : _d_price,
                              @"h_price" : _h_price,
                              @"city_id" : GetUserDefault(City_ID)
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            modelArray = [self arrayWithDicArray:resultObject[@"obj"]];
            
            [self.cateListTabelView reloadData];
            [self.cateCollectionView reloadData];

        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }
}
/**
 *  网络数据转模型数组
 *
 *  @param param 网络数据
 *
 *  @return 模型数组
 */
- (NSMutableArray *)arrayWithDicArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = modelArray;
    }
    for (NSDictionary *dic in param) {
        SecondModel *model = [[SecondModel alloc] arrayWithDic:dic];
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
//    [self addCateList];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self addNaviRightButton];
    [self setBackButton];
    
    [self.navigationController.navigationBar addSubview:self.searchView];
    
}

/**
 * 添加导航栏右侧的按钮
 */
- (void)addNaviRightButton{
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(10, 0, 44, 44);
//    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBtn setImage:[UIImage imageNamed:@"collection_list_sel"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"collection_list_sel"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(selectGood) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

/**
 * 导航栏右侧按钮的点击事件
 */
- (void)selectGood{
    [UIView animateWithDuration:0.5 animations:^{
        if (!hidderIdentifier) {
            self.cateCollectionView.alpha = 1;
            self.cateListTabelView.alpha = 0;
            [rightBtn setImage:[UIImage imageNamed:@"collection_list_sel"] forState:UIControlStateNormal];
            [rightBtn setImage:[UIImage imageNamed:@"collection_list_sel"] forState:UIControlStateHighlighted];
        }else{
            self.cateCollectionView.alpha = 0;
            self.cateListTabelView.alpha = 1;
            [rightBtn setImage:[UIImage imageNamed:@"list_collection_sel"] forState:UIControlStateNormal];
            [rightBtn setImage:[UIImage imageNamed:@"list_collection_sel"] forState:UIControlStateHighlighted];
        }
    }];
    hidderIdentifier = !hidderIdentifier;
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.cateCollectionView];
    [self.view addSubview:self.buttonView];
    
    _cateListTabelView = [[UITableView alloc] initForAutoLayout];
    _cateListTabelView.delegate = self;
    _cateListTabelView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_cateListTabelView];
    [self swpPublicToolSettingTableViewRefreshing:self.cateListTabelView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
    [self.view addSubview:_cateListTabelView];
    self.cateCollectionView.alpha = 1;
    self.cateListTabelView.alpha = 0;
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [self.cateListTabelView.mj_footer setState:MJRefreshStateIdle];
    [self.cateCollectionView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFromUrl];
    [_cateListTabelView.mj_header endRefreshing];
    [self.cateCollectionView.mj_header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getDataFromUrl];
    [_cateListTabelView.mj_footer endRefreshing];
    [_cateCollectionView.mj_footer endRefreshing];
}

/**
 * 添加分类列表
 */
-(void)addCateList
{
    NSArray *testArray;
    testArray = @[_saleArray,_assessArray,_sortArray];
    NSLog(@"%@",testArray);
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    CGRect rect = [[UIScreen mainScreen] bounds];
    menu.frame = CGRectMake(0, 0, rect.size.width, 37 * Balance_Heith);
    menu.layer.borderWidth = 0.5;
    menu.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
    [self.view addSubview:menu];
    if (self.getCateName!=nil ) {
        //设置标题
        [menu setCateTitle:self.cate_name];
    }
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.buttonView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.buttonView autoSetDimension:ALDimensionHeight toSize:38 * Balance_Heith];
    _buttonView.buttonTextArray = @[NSLocalizedString(@"cateGoodsPraise", nil), NSLocalizedString(@"cateGoodsSalesVolume", nil), NSLocalizedString(@"cateGoodsPrice", nil), NSLocalizedString(@"cateGoodsScreen", nil)];
    
    [_cateListTabelView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(38 * Balance_Heith, 0, 0, 0)];
}

#pragma mark 添加分类下拉列表的点击事件
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row selectText:(NSString *)text{
    switch (column) {
        case 0:
            cate_order = text;
            break;
        case 1:
            cate_order = text;
            break;
        case 2:
            cate_order = text;
            break;
        default:
            break;
    }
    [self.cateListTabelView.mj_header beginRefreshing];
}

#pragma mark tableview的代理方法和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return modelArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    [UZCommonMethod settingTableViewAllCellWire:_cateListTabelView andTableViewCell:cell];
    cell.secondModel = modelArray[indexPath.row];
    NSLog(@"%@",modelArray);
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.5f * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = modelArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - colleciontview以下
- (UICollectionView *)cateCollectionView{
    if (!_cateCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 3;
        _cateCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 38 * Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 104) collectionViewLayout:flowLayout];

        [_cateCollectionView registerClass:[HomeCateCollectionViewCell class] forCellWithReuseIdentifier:@"collect"];
        _cateCollectionView.delegate = self;
        _cateCollectionView.backgroundColor = [UIColor whiteColor];
        _cateCollectionView.showsVerticalScrollIndicator = NO;
        [self swpPublicToolSettingCollectionViewRefreshing:_cateCollectionView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
        _cateCollectionView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _cateCollectionView.dataSource = self;
    }
    return _cateCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCateCollectionViewCell *cell = [HomeCateCollectionViewCell homeCateColleciontView:collectionView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = modelArray[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Balance_Width * 158.5, 218* Balance_Heith);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = modelArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 按钮视图  以下
- (CateGoodsButtonView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[CateGoodsButtonView alloc] initForAutoLayout];
        _buttonView.delegate = self;
    }
    return _buttonView;
}

- (void)touchButtonAtIndex:(NSInteger)index{
    if (index != 3) {
        cate_order = [NSString stringWithFormat:@"%d",(int)index + 1];
        [self getDataFromUrl];
    }
    if (index == 3) {
        SelectTypeViewController *viewController = [[SelectTypeViewController alloc] init];
        viewController.cate_id = self.cate_id;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/**
 懒加载
 */
- (NaviSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[NaviSearchView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100 * Balance_Width, 8, 200* Balance_Width, 30)];
        _searchView.delegate = self;
        _searchView.textLabelString = [NSString stringWithFormat:@"  %@  ", _cate_name];
        _searchView.shopCarImageName = @"gray_shopcar";
        if (_cate_name!= nil) {
            _searchView.textLabelColor = [UIColor lightGrayColor];
        }
        _searchView.cornerRadius = 4;
        _searchView.layer.borderWidth = 0.5;
        _searchView.imageSize = CGSizeMake(15, 15);
        _searchView.backGroudColor = UIColorFromRGB(0xffffff);
    }
    return _searchView;
}

#pragma mark 导航栏搜索条的委托
- (void)clickNaviSearchView{
    SearchHisViewController *viewController = [[SearchHisViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
