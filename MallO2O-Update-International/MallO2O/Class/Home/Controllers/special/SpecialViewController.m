//
//  SpecialViewController.m
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

//专区页面（首页图片跳转）
#import "SpecialViewController.h"
#import "SpecialCollectionViewCell.h"
#import "SpecialModel.h"
//商品详情web页
#import "GoodsWebViewController.h"
#import <MJRefresh.h>

#define SpecialAppKey @"product_list"

@interface SpecialViewController ()<UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong ,nonatomic) SpecialModel *model;
//专题列表上部图片
@property (strong ,nonatomic) UIImageView *specialHeaderImgView;

@property (strong ,nonatomic) UICollectionView *specialCollecitonView;

@end

@implementation SpecialViewController{
    NSMutableArray *specialArray;
    int page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

/**
 视图即将出现
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}
/**
 视图已经出现 某些效果在viewwillappear里无法实现 在这里可以实现
 */
- (void)viewWillDisappear:(BOOL)animated{
//    [specialArray removeLastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 初始化控件
 */
- (void)initUI{
    [self setBackButton];
    [self addUI];
    [self setAutoLayout];
    [self setNavgationBar];
    [_specialCollecitonView.mj_header beginRefreshing];
}

/**
 设置页面标题
 */
- (void)setNavgationBar{
    [self setNavBarTitle:_navTitle withFont:NAV_TITLE_FONT_SIZE];
}

#pragma mark 添加控件
- (void)addUI{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.minimumInteritemSpacing =0;
    flowLayout.minimumLineSpacing = 3;
    _specialCollecitonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 * Balance_Heith) collectionViewLayout:flowLayout];
    
    /*
     fuck the 注册
     */
    [_specialCollecitonView registerClass:[SpecialCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    flowLayout.headerReferenceSize = CGSizeMake(320, 100 * Balance_Heith);
    [_specialCollecitonView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    _specialCollecitonView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    _specialCollecitonView.delegate = self;
    _specialCollecitonView.dataSource = self;
    [self addMJRefresh];
    [self.view addSubview:_specialCollecitonView];
    _specialHeaderImgView = [[UIImageView alloc] initForAutoLayout];
//    [self.view addSubview:_specialHeaderImgView];
}
/*
    为collectionview添加刷新和加载
 */
- (void)addMJRefresh{
    [self swpPublicToolSettingCollectionViewRefreshing:_specialCollecitonView target:self headerAction:@selector(headerRefereshingData) footerAction:@selector(footerRefereshingData)];
}

#pragma mark 上拉加载和下拉刷新
- (void)headerRefereshingData{
    page = 1;
    [self.specialCollecitonView.mj_footer setState:MJRefreshStateIdle];
    [self getDataFormUrl];
    [_specialCollecitonView.mj_header endRefreshing];
}

- (void)footerRefereshingData{
    page ++;
    [self getDataFormUrl];
    [_specialCollecitonView.mj_footer endRefreshing];
}

#pragma mark 设置自动布局
- (void)setAutoLayout{
    
}

#pragma mark 获取网络数据
- (void)getDataFormUrl{
    NSString *appKey = [SwpTools swpToolGetInterfaceURL:@"product_list"];
    NSLog(@"%@%d",_specialId,page);
    NSDictionary *dic = @{
                          @"app_key" : appKey,
                          @"page" : [NSString stringWithFormat:@"%d",page],
                          @"special_id" : _specialId
                          };
    
    [self swpPublicTooGetDataToServer:appKey parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        
        specialArray = [self specialArray:[[resultObject objectForKey:@"obj"] objectForKey:@"product_list"]];
        NSArray *array = resultObject[@"obj"][@"product_list"];
        if (array.count == 0) {
            [_specialCollecitonView.mj_footer setState:MJRefreshStateNoMoreData];
        }
        NSLog(@"%@",specialArray);
        [self.specialCollecitonView reloadData];
        
        [_specialHeaderImgView sd_setImageWithURL:[NSURL URLWithString:[[resultObject objectForKey:@"obj"] objectForKey:@"img"]] placeholderImage:[UZCommonMethod setImageFromColor:[UIColor lightGrayColor] viewWidth:_specialHeaderImgView.frame.size.width viewHeight:_specialHeaderImgView.frame.size.height]];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/*
    数据转模型
 */
- (NSMutableArray *)specialArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    if (page != 1) {
        array = specialArray;
    }
    for (NSDictionary *dic in param) {
        SpecialModel *model = [[SpecialModel alloc] initWithDic:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark collectionview的代理方法和数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return specialArray.count;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(158.5 * Balance_Width, 196 * Balance_Heith);
}

/**
  每个item的上下左右间距
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4 * Balance_Heith, 0, 1, 0);
}

/**
 数据
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        [self.specialCollecitonView registerClass:[SpecialCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
        SpecialCollectionViewCell *cell = [SpecialCollectionViewCell cellOfCollectionView:collectionView cellForRoAtIndex:indexPath];
        cell.specialModel = specialArray[indexPath.row];
        return cell;
}

/**
 collection的头部
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [_specialCollecitonView
                                          dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                          withReuseIdentifier:@"head"
                                          forIndexPath:indexPath];
    _specialHeaderImgView = [[UIImageView alloc] initForAutoLayout];
    [view addSubview:_specialHeaderImgView];
    [_specialHeaderImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_specialHeaderImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_specialHeaderImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_specialHeaderImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
//    _specialHeaderImgView.backgroundColor = [UIColor lightGrayColor];
//    _specialHeaderImgView.layer.borderWidth = 1;
//    view.layer.borderWidth = 1;
    return view;
}

#pragma mark cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SpecialModel * model = specialArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.shopName = model.specialName;
    viewController.webViewUrl = model.webUrl;
    viewController.imageUrl = model.specialImg;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
