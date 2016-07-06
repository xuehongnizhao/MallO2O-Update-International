//
//  SwpGuidePage.m
//  Swp_song
//
//  Created by songweiping on 15/8/13.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song    ( 引导页 控制器 )
//
//  @modification Time  --->    2015-12-21 17:11:18
//
//  @since              --->    1.0.7
//
//  @warning            --->    !!! < SwpGuidePage 内部实现使用的是 collectionView > !!!

#import "SwpGuidePage.h"

/*! ---------------------- View       ---------------------- !*/
#import "SwpGuideCell.h"                // 显示 SwpGuidePage cell
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpGuideModel.h"               // SwpGuidePage 数据模型
/*! ---------------------- Model      ---------------------- !*/

static NSString * const swpGuidePageCellID   = @"swpGuidePageCellID";
static NSString * const appVersion           = @"CFBundleVersion";

@interface SwpGuidePage () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate,SwpGuideCellDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示引导页 view         !*/
@property (nonatomic, strong)  UICollectionView           *swpGuidePageView;
/*! UICollectionView 瀑布流 !*/
@property (nonatomic, strong)  UICollectionViewFlowLayout *flowLayout;
/*! 显示分页 PageControl    !*/
@property (nonatomic, strong)  UIPageControl              *swpPageControl;
/*! 修改按钮的 block        !*/
@property (nonatomic,   copy)  SwpIntoAppButton           swpIntoAppButton;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 封装图片模型的数组 引导页的数据源      !*/
@property (nonatomic,   copy) NSArray                    *swpGuideModelArray;
/*! 记录cell 索引的 index                  !*/
@property (nonatomic,   copy) NSIndexPath                *indexPath;
/*! SwpGuidePageCloseBlock 关闭之后block   !*/
@property (nonatomic,   copy) SwpGuidePageCloseBlock     swpGuidePageCloseBlock;
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpGuidePage

#pragma mark - Lifecycle Methods
/*!
 *  @author swp_song
 *
 *  @brief  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingUI];
    [self settingData];
}

/*!
 *  @author swp_song
 *
 *  @brief  将要加载出视图 调用
 *
 *  @param  animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  视图 显示 窗口时 调用
 *
 *  @param  animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief 视图  即将消失、被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
}

/*!
 *  @author swp_song
 *
 *  @brief  视图已经消失、被覆盖或是隐藏时调用
 *
 *  @param  animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 *  @author swp_song
 *
 *  @brief  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - Setting Data Method
/*!
 *  @author swp_song
 *
 *  @brief  设置 初始化 数据
 */
- (void) settingData {
    self.swpGuideModelArray           = [self swpGuideDataDispose:self.swpGuidePageImageArray];
    self.swpPageControl.numberOfPages = self.swpGuideModelArray.count;
    [self.swpGuidePageView reloadData];
}

#pragma mark - Setting UI Methods
/*!
 *  @author swp_song
 *
 *  @brief  设置 UI 控件
 */
- (void) settingUI {
    [self setupUI];
    [self settingUIAutoLayout];
}

/*!
 *  @author swp_song
 *
 *  @brief  添加控件
 */
- (void) setupUI {
    [self.view addSubview:self.swpGuidePageView];
    [self.view addSubview:self.swpPageControl];
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    self.swpGuidePageView.frame  = self.view.bounds;
    self.swpPageControl.frame    = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 30);
}



#pragma mark - UICollectionView DataSource Methods
/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组个数 )
 *
 *  @param  collectionView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组中 cell显示的个数 )
 *
 *  @param  collectionView
 *
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.swpGuideModelArray.count;
}

/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组中cell显示的数据 | 样式 )
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SwpGuideCell *cell = [SwpGuideCell swpGuideCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath forCellWithReuseIdentifier:swpGuidePageCellID];

    self.indexPath        = indexPath;
    // 设置 数据模型
    cell.swpGuide         = self.swpGuideModelArray[indexPath.item];
    
    // 设置 按钮的样式
    [cell settingSwpIntoAppButtonFrame:^(UIButton *button) {
        if (self.swpIntoAppButton != nil) {
            self.swpIntoAppButton(button);
        }
    }];

    cell.delegate   = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate Delegate Methods
/*!
 *  @author swp_song
 *
 *  @brief  collectionView Delegate ( collectionView 代理方法 设置 collectionView  每个cell的宽高 )
 *
 *  @param  collectionView
 *
 *  @param  collectionViewLayout
 *
 *  @param  indexPath
 *
 *  @return CGSize
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - ScrollView Delegate Methods
/*!
 *  @author swp_song
 *
 *  @brief  scrollView Delegate ( scrollView 代理方法 开始拖动时候调用 < 计算分页 >  )
 *
 *  @param  scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 精确分页
    
    int page = 0;
    
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        page = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
    } else {
        page = (scrollView.contentOffset.y + scrollView.frame.size.height * 0.5) / scrollView.frame.size.height;
    }
    
    self.swpPageControl.currentPage = page;
}
/*!
 *  @author swp_song
 *
 *  @brief  scrollView Delegate ( scrollView 代理方法 停止拖动时调用  )
 *
 *  @param  scrollView
 *
 *  @param  decelerate
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 判断 是否 开启滑动手势
    if (self.isSwpGuidePageOpenSlidingGesture) {
        if (!decelerate) {
            [self checkImageLast:self.indexPath.item arrayIndex:self.swpGuideModelArray.count - 1 returnYES:^{
                [self swpGuidePageDismissAnimated:YES completion:^{
                    
                }];
            } returnNO:^{
                
            }];
        }
    }
}


#pragma mark - Setting SwpGuidePage Property Public Methods
/*!
 *  @author swp_song, 2015-12-21 15:04:55
 *
 *  @brief  swpGuidePage ( 快速 初始化 )
 *
 *  @return SwpGuidePage
 *
 *  @since  1.0.7
 */
+ (instancetype) swpGuidePage {
    return [[self alloc] init];
}


/*!
 *  @author swp_song, 2015-12-21 15:29:03
 *
 *  @brief  swpSettingIntoAppButton ( 设置 按钮 样式 )
 *
 *  @param  swpIntoAppButton
 *
 *  @since  1.0.7
 */
- (void) swpGuidePageSettingIntoAppButton:(SwpIntoAppButton)swpIntoAppButton {
    self.swpIntoAppButton = swpIntoAppButton;
}


/*!
 *  @author swp_song, 2015-12-21 15:29:21
 *
 *  @brief  screenHeightscale ( 默认宽高比 计算按钮 在屏幕上 Y 值的 比例   )
 *
 *  @return CGFloat
 *
 *  @since  1.0.7
 */
- (CGFloat)swpGuideScreenHeightscale {
    return 0.8;
}

/*!
 *  @author swp_song, 2015-12-21 15:38:53
 *
 *  @brief  setSwpGuidePageScrollDirection ( 设置 swpGuidePage 横向 或 纵向 滚动 )
 *
 *  @param  swpGuidePageScrollDirection
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageScrollDirection:(UICollectionViewScrollDirection)swpGuidePageScrollDirection {
    _swpGuidePageScrollDirection = swpGuidePageScrollDirection;
    self.flowLayout.scrollDirection = _swpGuidePageScrollDirection;
}

/*!
 *  @author swp_song, 15-12-21 15:12:26
 *
 *  @brief  setSwpGuidePageControlHidden    ( 设置 swpGuidePage 是否隐藏分页控件 default NO )
 *
 *  @param  swpGuidePageControlHidden       ( YES 是隐藏 NO 不隐藏 )
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageControlHidden:(BOOL)swpGuidePageControlHidden {
    _swpGuidePageControlHidden = swpGuidePageControlHidden;
    self.swpPageControl.hidden = _swpGuidePageControlHidden;
}

/*!
 *  @author swp_song, 2015-12-21 15:50:30
 *
 *  @brief  setSwpGuidePageOpenSlidingGesture ( 设置 swpGuidePage 滑动手势 默认是 NO 不开启  )
 *
 *  @param  swpGuidePageOpenSlidingGesture    ( NO 不开启 YES 是开启 )
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageOpenSlidingGesture:(BOOL)swpGuidePageOpenSlidingGesture {
    _swpGuidePageOpenSlidingGesture = swpGuidePageOpenSlidingGesture;
}

/*!
 *  @author swp_song, 2015-12-21 15:53:20
 *
 *  @brief  setSwpGuidePageNumberOfPagesColor  ( 设置 swpGuidePage 分页控件 总页数的颜色 )
 *
 *  @param  swpGuidePageNumberOfPagesColor
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageNumberOfPagesColor:(UIColor *)swpGuidePageNumberOfPagesColor {
    _swpGuidePageNumberOfPagesColor            = swpGuidePageNumberOfPagesColor;
    self.swpPageControl.pageIndicatorTintColor = _swpGuidePageNumberOfPagesColor;
}

/*!
 *  @author swp_song, 2015-12-21 15:57:14
 *
 *  @brief  setSwpGuidePageCurrentPageColor ( 设置 swpGuidePage 分页控件 当前页数的颜色 )
 *
 *  @param  swpGuidePageCurrentPageColor
 *
 *  @since  1.0.7
 */
- (void)setSwpGuidePageCurrentPageColor:(UIColor *)swpGuidePageCurrentPageColor {
    _swpGuidePageCurrentPageColor                     = swpGuidePageCurrentPageColor;
    self.swpPageControl.currentPageIndicatorTintColor = _swpGuidePageCurrentPageColor;
}

/*!
 *  @author swp_song, 2015-12-21 16:03:26
 *
 *  @brief  swpGuidePageCheckAppVersionIntoApp ( 判断 app 版本 是否 是最新版本 )
 *
 *  @param  intoApp
 *
 *  @param  intoSwpGuidePage
 *
 *  @since  1.0.7
 */
- (void) swpGuidePageCheckAppVersionIntoApp:(void(^)(void))intoApp intoSwpGuidePage:(void(^)(void))intoSwpGuidePage {
    
    // 取出 存储 UD 里的版本号
    NSUserDefaults *defaults          = [NSUserDefaults standardUserDefaults];
    NSString       *lastVersion       = [defaults stringForKey:appVersion];
    // 取出系统当前 版本号
    NSString       *systemVersion     = [NSBundle mainBundle].infoDictionary[appVersion];
    
    if ([systemVersion isEqualToString:lastVersion]) {
        intoApp();
    } else {
        // 存储 app 版本号
        [defaults setObject:systemVersion forKey:appVersion];
        [defaults synchronize];
        intoSwpGuidePage();
    }
}

/*!
 *  @author swp_song, 2015-12-21 16:05:43
 *
 *  @brief  swpGuidePageGetCenter   ( 计算出 按钮 在屏幕的 中心位置 )
 *
 *  @param  screenHeightscale       Y 值 屏幕 高度比例
 *
 *  @param  offset                  上下偏移量
 *
 *  @return CGPoint
 *
 *  @since  1.0.7
 */
- (CGPoint)swpGuidePageGetCenter:(CGFloat)screenHeightscale offset:(CGFloat)offset {
    CGFloat  buttonX    = self.view.frame.size.width  * 0.5;
    CGFloat  buttonY    = self.view.frame.size.height * screenHeightscale + offset;
    return CGPointMake(buttonX, buttonY);
}

/*!
 *  @author swp_song, 2015-12-21 16:09:40
 *
 *  @brief  swpGuidePageSettingButton  ( 快速 设置按钮的 公用属性 )
 *
 *  @param  button          需要设置的按钮
 *
 *  @param  backgroundColor 按钮的背景
 *
 *  @param  title           按钮的文字
 *
 *  @param  titleColor      文字的颜色
 *
 *  @param  fontSize        文字的大小
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageSettingButton:(UIButton *)button setBackgroundColor:(UIColor *)backgroundColor setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize {
    
    button.backgroundColor     = backgroundColor;
    button.layer.cornerRadius  = 3;
    button.layer.masksToBounds = YES;
    button.titleLabel.font     = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}

/*!
 *  @author swp_song, 2015-12-21 16:12:06
 *
 *  @brief  swpGuidePageShow    ( 显示  swpGuidePage 控制器, 没有判断版本号 )
 *
 *  @param  navigation
 *
 *  @param  animated
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageShow:(UINavigationController *)navigation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion {
    
    [navigation presentViewController:self animated:animated completion:^{
        if (completion) completion();
    }];
}



/*!
 *  @author swp_song, 2015-12-21 16:16:23
 *
 *  @brief  swpGuidePageClose   ( swpGuidePage 关闭之后回调 )
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageClose:(SwpGuidePageCloseBlock)completion {
    self.swpGuidePageCloseBlock = completion;
}

/*!
 *  @author swp_song, 2015-12-21 17:09:06
 *
 *  @brief  swpGuidePageCheckAppVersionShow  ( 显示  swpGuidePage 控制器, 判断版本号 )
 *
 *  @param  navigation
 *
 *  @param  animated
 *
 *  @param  completion
 *
 *  @since  1.0.7
 */
- (void)swpGuidePageCheckAppVersionShow:(UINavigationController *)navigation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion {
    
    [self swpGuidePageCheckAppVersionIntoApp:^{
        
    } intoSwpGuidePage:^{
        // 显示
        [self swpGuidePageShow:navigation animated:animated completion:^{
            
            if (completion) completion();
        }];
    }];
     
}


#pragma mark - Tool Methods
/*!
 *  @author swp_song, 2015-12-21 16:17:49
 *
 *  @brief  swpGuideCell    ( 按钮的点击事件 )
 *
 *  @param  swpGuideCell
 *
 *  @param  button
 *
 *  @since  1.0.7
 */
- (void)swpGuideCell:(SwpGuideCell *)swpGuideCell didButtin:(UIButton *)button {
    
    [self swpGuidePageDismissAnimated:YES completion:^{
        
    }];
}

/*!
 *  @author swp_song, 2015-12-21 16:21:23
 *
 *  @brief  checkImageLast      ( 验证 是否 是最后一张图片 )
 *
 *  @param arrayCount           数组的长度
 *
 *  @param index                图片的索引
 *
 *  @param yes                  是最后一张图
 *
 *  @param no                   不是最后一张图片
 *
 *  @since  1.0.7
 */
- (void) checkImageLast:(NSInteger)arrayCount arrayIndex:(NSInteger)index returnYES:(void(^)(void))yes returnNO:(void(^)(void))no{
    
    if (arrayCount == index) {
        yes();
    } else {
        no();
    }
}

/*!
 *  @author swp_song, 2015-12-21 16:22:36
 *
 *  @brief  swpGuidePageDismissAnimated     ( 关闭 swpGuidePage 控制器 )
 *
 *  @param  animated                        是否 使用动画效果
 *
 *  @param  completion                      关闭 之后的回调
 *
 *  @since  1.0.7
 */
- (void) swpGuidePageDismissAnimated:(BOOL)animated completion:(void(^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:^{
        if (self.swpGuidePageCloseBlock) self.swpGuidePageCloseBlock();
        completion();
    }];
}



#pragma mark - SwpGuide Data Dispose Method
/*!
 *  数据处理  (字典转模型)
 *
 *  @param  param
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *) swpGuideDataDispose:(NSArray *)param {
    
    NSMutableArray *array = [NSMutableArray array];
    
    int i = 0;
    for (NSString *string in param) {
        SwpGuideModel *swpGuide    = [[SwpGuideModel alloc] init];
        swpGuide.swpGuideImageName = string;
        swpGuide.swpGuideIndex     = i;
        swpGuide.swpGuideCount     = param.count;
        [array addObject:swpGuide];
        i++;
    }
    return array;
}


#pragma mark - Init UI Methods
- (UICollectionView *)swpGuidePageView {
    
    if (!_swpGuidePageView) {
        
        _swpGuidePageView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.flowLayout];
        [_swpGuidePageView registerClass:[SwpGuideCell class] forCellWithReuseIdentifier:swpGuidePageCellID];
        _swpGuidePageView.backgroundColor = [UIColor whiteColor];
        _swpGuidePageView.dataSource                     = self;
        _swpGuidePageView.delegate                       = self;
        _swpGuidePageView.pagingEnabled                  = YES;
        _swpGuidePageView.showsHorizontalScrollIndicator = NO;
        _swpGuidePageView.showsVerticalScrollIndicator   = NO;
        _swpGuidePageView.bounces                        = NO;

    }
    return _swpGuidePageView;
}

- (UIPageControl *)swpPageControl {
    
    if (!_swpPageControl) {
        _swpPageControl = [[UIPageControl alloc] init];
        _swpPageControl.enabled = NO;
    }
    return _swpPageControl;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 横向滚动
        _flowLayout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing      = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

#pragma mark - Init Data Methods
- (NSArray *)swpGuideModelArray {
    if (!_swpGuideModelArray) {
        _swpGuideModelArray = [NSArray array];
    }
    return _swpGuideModelArray;
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
