//
//  TeamBuyingViewController.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "TeamBuyingViewController.h"
#import "MXPullDownMenu.h"
#import "cateInfo.h"
#import <MJRefresh.h>
//#import "WebViewController.h"

/*++++++++++++大多数的tableview可以复用cell和model  样式相同+++++++++++++*/
#import "MiaoTableViewCell.h"
#import "ShopMapViewController.h"
#import "TeamBuyCollectionViewCell.h"//团购collectionviewcell
#import "SecondModel.h"//秒杀的模型  负用很多
#import "GoodsWebViewController.h"//商品详情web页
/*++++++++++++大多数的tableview可以复用cell  样式相同+++++++++++++*/

@interface TeamBuyingViewController ()<MXPullDownMenuDelegate,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (strong ,nonatomic) NSString *cate_id; //分类ID
@property (strong ,nonatomic) NSString *cate_order; //分类固定的类型
@property (strong ,nonatomic) UITableView *cateTabelView;
@property (strong ,nonatomic) UICollectionView *teamBuyCollectionView;

//-------------关于分类----------------------
@property (strong, nonatomic) NSMutableArray *cateArray;//存储分类的数组
@property (strong, nonatomic) NSMutableArray *sortArray;//存储排序的数组

@end

@implementation TeamBuyingViewController{
    NSMutableArray *cateListArray;
    int page;
    MXPullDownMenu *menu;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    [self getCateInfoFromUrl];
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
    page = 1;
    cateListArray = [[NSMutableArray alloc] init];
    _sortArray = [[NSMutableArray alloc] init];
    _cateArray = [[NSMutableArray alloc] init];
    [self addArray];
    [self getCateFromNet];
//    [self getCateInfoFromUrl];
}
/**
 *  添加分类数组
 */
- (void)addArray{
    [_sortArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = NSLocalizedString(@"teamBuyingSorting", nil);
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    cateInfo *info = [[cateInfo alloc] init];
    info.cate_name = NSLocalizedString(@"teamBuyingSales", nil);
    info.cate_id = @"sale";
    info.son = [[NSMutableArray alloc] init];
    cateInfo *info1 = [[cateInfo alloc] init];
    info1.cate_name = NSLocalizedString(@"teamBuyingTheLatestRelease", nil);
    info1.cate_id = @"time";
    info1.son = [[NSMutableArray alloc] init];
    cateInfo *info2 = [[cateInfo alloc] init];
    info2.cate_name = NSLocalizedString(@"teamBuyingHighestPrice", nil);
    info2.cate_id = @"h_price";
    info2.son = [[NSMutableArray alloc] init];
    cateInfo *info3 = [[cateInfo alloc] init];
    info3.cate_name = NSLocalizedString(@"teamBuyingTheLowestPrice", nil);
    info3.cate_id = @"d_price";
    info3.son = [[NSMutableArray alloc] init];
    [_sortArray addObjectsFromArray:@[info0,info,info1,info2,info3]];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    [_cateTabelView.mj_header beginRefreshing];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:self.nameTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self settingRightButton];
}


/**
 设置导航栏右侧按钮
 */
- (void)settingRightButton{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(mapView) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"near_shop_map_no"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"near_shop_map_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)mapView{
    ShopMapViewController *viewController = [[ShopMapViewController alloc] init];
    viewController.shopArray = cateListArray;
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    _cateTabelView = [[UITableView alloc] initForAutoLayout];
//    [self.view addSubview:_cateTabelView];
    [self.view addSubview:self.teamBuyCollectionView];
    _cateTabelView.delegate = self;
    _cateTabelView.dataSource = self;
    [UZCommonMethod hiddleExtendCellFromTableview:_cateTabelView];
    [self swpPublicToolSettingTableViewRefreshing:_cateTabelView target:self headerAction:@selector(headerRefreshingData) footerAction:@selector(footerRefreshingData)];
}

/**
 * 添加分类列表
 */
-(void)addCateList
{
    if (menu != nil) {
        [menu removeFromSuperview];
    }
    NSArray *testArray;
    testArray = @[ _cateArray,_sortArray ];
    NSLog(@"%@",testArray);
    menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    CGRect rect = [[UIScreen mainScreen] bounds];
    menu.frame = CGRectMake(0, 0, rect.size.width, 37 * Balance_Heith);
    menu.layer.borderWidth = 0.5;
    menu.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    [self.view addSubview:menu];
    if (self.cate_name!=nil && self.cate_name.length > 0) {
        //设置标题
        [menu setCateTitle:self.cate_name];
    }
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    [_cateTabelView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(33 * Balance_Heith, 0, 0, 0)];
}

#pragma mark 上拉加载和下拉刷新
/**
 *  下拉刷新
 */
- (void)headerRefreshingData{
    page = 1;
    [_cateTabelView.mj_footer setState:MJRefreshStateIdle];
    [self getCateInfoFromUrl];
    [_cateTabelView.mj_header endRefreshing];
}

/**
 *  上拉加载
 */
- (void)footerRefreshingData{
    page ++;
    [self getCateInfoFromUrl];
    [_cateTabelView.mj_footer endRefreshing];
}

#pragma mark 获取网络数据
-(void)getCateFromNet
{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"cate_list"];
    NSDictionary *dic = @{
                          @"app_key":url,
                          @"city_id" : GetUserDefault(City_ID),
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        //------------解析------------
        NSDictionary *dict = (NSDictionary*)resultObject;
        [self parseCateDic:dict];
        [self addCateList];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

#pragma mark 获取分类商家数据列表
- (void)getCateInfoFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"group_list"];
    if (_cate_id == nil || [_cate_id isEqualToString:@""]) {
        _cate_id = @"0";
    }
    if (_cate_order == nil || [_cate_order isEqualToString:@""]) {
        _cate_order = @" ";
    }
    NSDictionary *dic = @{
                          @"page" : [NSString stringWithFormat:@"%d",page],
                          @"app_key" : url,
                          @"cate_id" : _cate_id,
                          @"order" : _cate_order,
                          @"city_id" : GetUserDefault(City_ID),
                          };
    NSLog(@"%@",_cate_id);
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        
        cateListArray = [self setModelArrayFromParam:resultObject[@"obj"]];
        if ([(NSMutableArray *)resultObject[@"obj"] count] == 0) {
            [_cateTabelView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [_cateTabelView reloadData];
        [_teamBuyCollectionView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/*++++++++++++++++
 数据转模型
 +++++++++++++++++*/
- (NSMutableArray *)setModelArrayFromParam:(NSMutableArray *)paray{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = cateListArray;
    }
    for (NSDictionary *dic in paray) {
        SecondModel *model = [[SecondModel alloc] arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark-----解析商家分类
-(void)parseCateDic :(NSDictionary*)dic
{
    [_cateArray removeAllObjects];
    cateInfo *info0 = [[cateInfo alloc] init];
    info0.cate_name = NSLocalizedString(@"teamBuyingCateTitle", nil);
    info0.cate_id = @"0";
    info0.son = [[NSMutableArray alloc] init];
    [_cateArray addObject:info0];
    
    NSArray *cateArr = [dic objectForKey:@"obj"];
    for (NSDictionary *ele in cateArr) {
        cateInfo *info = [[cateInfo alloc] initWithDictinoary:ele];
        [_cateArray addObject:info];
    } 
}

#pragma mark 分类的代理方法
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row selectText:(NSString *)text{
    page = 1;
    switch (column) {
        case 0:
            _cate_id = text;
            NSLog(@"%@",text);
            break;
        case 1:
            _cate_order = text;
            NSLog(@"%@",text);
            break;
        default:
            break;
    }
    [self getCateInfoFromUrl];
}

#pragma mark tableview的代理方法和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cateListArray.count;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    [UZCommonMethod settingTableViewAllCellWire:_cateTabelView andTableViewCell:cell];
    cell.secondModel = cateListArray[indexPath.row];
    NSLog(@"%@",cell.secondModel.secondImgUrlText);
    return cell;
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.0f * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = cateListArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 设置collectionview  以下
- (UICollectionView *)teamBuyCollectionView{
    if (!_teamBuyCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing=3;
        _teamBuyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 37 * Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 37*Balance_Heith) collectionViewLayout:flowLayout];
        [_teamBuyCollectionView registerClass:[TeamBuyCollectionViewCell class] forCellWithReuseIdentifier:@"teamBuyCell"];
        _teamBuyCollectionView.delegate = self;
        _teamBuyCollectionView.dataSource = self;
//        _teamBuyCollectionView.layer.borderWidth = 1;
        _teamBuyCollectionView.showsVerticalScrollIndicator = NO;
        _teamBuyCollectionView.backgroundColor = UIColorFromRGB(0xf3f4f6);
    }
    return _teamBuyCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cateListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeamBuyCollectionViewCell *cell = [TeamBuyCollectionViewCell secondGoodsCollection:collectionView cellForRowAtIndexPath:indexPath cellID:@"teamBuyCell"];
    cell.model = cateListArray[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(158.5 * Balance_Width, 226 * Balance_Heith);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(4, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SecondModel *model = cateListArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.imageUrl = model.secondImgUrlText;
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondShopName;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
