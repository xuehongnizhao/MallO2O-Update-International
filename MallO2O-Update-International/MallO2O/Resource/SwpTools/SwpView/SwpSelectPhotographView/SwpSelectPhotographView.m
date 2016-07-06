//
//  SwpSelectPhotographView.m
//  SMServerUser
//
//  Created by songweiping on 16/3/2.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpSelectPhotographView.h"

/*! ---------------------- View       ---------------------- !*/
#import "SwpSelectPhotographCell.h"         //  显示 图片 cell
/*! ---------------------- View       ---------------------- !*/

static NSString * const kSwpSelectPhotographViewCellID = @"kSwpSelectPhotographViewCell";

@interface SwpSelectPhotographView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, SwpSelectPhotographCellDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示用户选择照片view 布局     !*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 图片 数据源 !*/
@property (nonatomic, copy  ) NSArray *imageArray;
/*! 点击 添加图片 回调        !*/
@property (nonatomic, copy, setter = swpSelectPhotographViewClickAddImage:) SwpSelectPhotographViewClickAddImage swpSelectPhotographViewClickAddImage;
/*! 点击 添加图片 回调        !*/
@property (nonatomic, copy, setter = swpSelectPhotographViewClickCell:) SwpSelectPhotographViewClickCellAtIndexPath swpSelectPhotographViewClickCell;
/*! 点击 点击删除按钮回调     !*/
@property (nonatomic, copy, setter = swpSelectPhotographViewClickDeleteButton:) SwpSelectPhotographViewClickCellAtIndexPath swpSelectPhotographViewClickDeleteButton;
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpSelectPhotographView

/*!
 *  @author swp_song, 2016-03-04 17:28:16
 *
 *  @brief  swpSelectPhotograph     ( 快速 初始化 SwpSelectPhotographView  )
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
+ (instancetype)swpSelectPhotograph {
    return [[SwpSelectPhotographView alloc] initSwpSelectPhotograph];
}

/*!
 *  @author swp_song, 2016-03-04 17:29:25
 *
 *  @brief  initSwpSelectPhotograph ( 初始化 SwpSelectPhotographView )
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
- (instancetype)initSwpSelectPhotograph {
    SwpSelectPhotographView *swpSelectPhotographView = [[SwpSelectPhotographView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [swpSelectPhotographView settingSwpSelectPhotographViewProperty:nil];
    return swpSelectPhotographView;
}

/*!
 *  @author swp_song, 2016-03-04 17:30:15
 *
 *  @brief  swpSelectPhotographWithData:    ( 快速 初始化 SwpSelectPhotographView 根据 数据源 )
 *
 *  @param  imageDataSource
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
+ (instancetype)swpSelectPhotographWithData:(NSArray<UIImage *> *)imageDataSource {
    return [[SwpSelectPhotographView alloc] initSwpSelectPhotographWithData:imageDataSource];
}

/*!
 *  @author swp_song, 2016-03-04 17:31:37
 *
 *  @brief  initSwpSelectPhotographWithData:    ( 初始化 SwpSelectPhotographView 根据 数据源 )
 *
 *  @param  imageDataSource
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
- (instancetype)initSwpSelectPhotographWithData:(NSArray<UIImage *> *)imageDataSource {
    SwpSelectPhotographView *swpSelectPhotographView = [[SwpSelectPhotographView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [swpSelectPhotographView settingSwpSelectPhotographViewProperty:imageDataSource];
    return swpSelectPhotographView;
}


/*!
 *  @author swp_song
 *
 *  @brief  initWithFrame:collectionViewLayout: ( Override )
 *
 *  @param  frame
 *
 *  @param  layout
 *
 *  @return SwpSelectPhotographView
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
    }
    return self;
}

/*!
 *  @author swp_song, 2016-03-04 17:34:56
 *
 *  @brief  settingSwpSelectPhotographViewProperty: ( 设置 SwpSelectPhotographView 公用 属性 )
 *
 *  @param  imageDataSource
 *
 *  @since  1.0.1
 */
- (void)settingSwpSelectPhotographViewProperty:(NSArray<UIImage *> *)imageDataSource {
    self.swpSelectPhotograpImagMaxQuantity = 0;
    self.imageArray      = imageDataSource == nil ? [NSArray array] : imageDataSource;
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource      = self;
    self.delegate        = self;
    [self registerClass:[SwpSelectPhotographCell class] forCellWithReuseIdentifier:kSwpSelectPhotographViewCellID];
    [self reloadData];
}


#pragma mark - UICollectionView DataSoure Methods
/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组个数 )
 *
 *  @param  collectionView
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
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
    
    SwpSelectPhotographCell *cell              = [SwpSelectPhotographCell swpSelectPhotographCellWithCollectionView:collectionView cellIdentifier:kSwpSelectPhotographViewCellID cellForItemAtIndexPath:indexPath];
    cell.swpSelectPhotographDeleteButtonImage  = self.swpSelectPhotographCellDeleteButtonImage;
    cell.delegate                              = self;
    cell.swpSelectPhotographDeleteButtonHidden = indexPath.row == self.imageArray.count - 1 ? YES : NO;
    cell.swpSelectPhotographImage              = self.imageArray[indexPath.row];
    [self swpSelectPhotographCellClickDeleteButton:cell];
    return cell;
}

#pragma mark - UICollectionView Delegate Methods
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (CGSizeEqualToSize(self.swpSelectPhotographCellSize, CGSizeMake(0, 0))) {
        return CGSizeMake(self.frame.size.height, self.frame.size.height);
    }
    
    return self.swpSelectPhotographCellSize;
}

/*!
 *  @author swp_song
 *
 *  @brief  collectionView Delegate ( collectionView 代理方法 点击每个cell调用 )
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SwpSelectPhotographCell *cell = (SwpSelectPhotographCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.isSwpSelectPhotographDeleteButtonHidden) {
        
        BOOL isPermitAdd = NO;
        
        // 判断 限制 图片 个数
        if (self.swpSelectPhotograpImagMaxQuantity != 0) {
            isPermitAdd = self.imageArray.count > self.swpSelectPhotograpImagMaxQuantity ? YES : NO;
        }
        
        if (self.swpSelectPhotographViewClickAddImage) self.swpSelectPhotographViewClickAddImage(self, isPermitAdd);
        if ([self.swpSelectPhotographViewDelegate respondsToSelector:@selector(swpSelectPhotographView:permitAddImage:)]) {
            [self.swpSelectPhotographViewDelegate swpSelectPhotographView:self permitAddImage:isPermitAdd];
        }
        return;
    }
    
    if (self.swpSelectPhotographViewDelegate) self.swpSelectPhotographViewClickCell(self, indexPath);
    
    if ([self.swpSelectPhotographViewDelegate respondsToSelector:@selector(swpSelectPhotographView:didSelectItemAtIndexPath:)]) {
        [self.swpSelectPhotographViewDelegate swpSelectPhotographView:self didSelectItemAtIndexPath:indexPath];
    }
    
 }


#pragma mark - SwpSelectPhotographCell Delegate Methods
/*!
 *  @author swp_song, 2016-03-04 17:39:42
 *
 *  @brief  swpSelectPhotographCell:clickDeleteButtonIndexPath: ( swpSelectPhotographCell 代理 方法 点击 删除 按钮调用 )
 *
 *  @param  swpSelectPhotographCell
 *
 *  @param  indexPath
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographCell:(SwpSelectPhotographCell *)swpSelectPhotographCell clickDeleteButtonIndexPath:(NSIndexPath *)indexPath {
    if ([self.swpSelectPhotographViewDelegate respondsToSelector:@selector(swpSelectPhotographView:clickDeleteButtonIndexPath:)]) {
        [self.swpSelectPhotographViewDelegate swpSelectPhotographView:self clickDeleteButtonIndexPath:indexPath];
    }
}

/*!
 *  @author swp_song, 2016-03-04 17:39:05
 *
 *  @brief  swpSelectPhotographCellClickDeleteButton:   ( swpSelectPhotographCell 点击 删除 按钮 回调 )
 *
 *  @param  swpSelectPhotographCell
 */
- (void)swpSelectPhotographCellClickDeleteButton:(SwpSelectPhotographCell *)swpSelectPhotographCell {
    __weak __typeof(self) vc = self;
    [swpSelectPhotographCell setSwpSelectPhotographCellClickDeleteButton:^(SwpSelectPhotographCell * _Nonnull swpSelectPhotographCell, NSIndexPath * _Nonnull indexPath) {
        if (vc.swpSelectPhotographViewClickDeleteButton) vc.swpSelectPhotographViewClickDeleteButton(vc, indexPath);
    }];
}

#pragma mark - Public Methods
/*!
 *  @author swp_song, 2016-03-04 17:41:40
 *
 *  @brief  setSwpSelectImageDataSource:    ( Override Setter 设置 数据源 刷新数据 )
 *
 *  @param  swpSelectImageDataSource
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectImageDataSource:(NSArray<UIImage *> *)swpSelectImageDataSource {
    _swpSelectImageDataSource = swpSelectImageDataSource;
    self.imageArray           = _swpSelectImageDataSource;
    [self reloadData];
}


/*!
 *  @author swp_song, 2016-03-04 17:51:41
 *
 *  @brief  swpSelectPhotographViewClickAddImage:   ( 点击 添加 图片 回调 )
 *
 *  @param  swpSelectPhotographViewClickAddImage
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickAddImage:(SwpSelectPhotographViewClickAddImage)swpSelectPhotographViewClickAddImage {
    _swpSelectPhotographViewClickAddImage = swpSelectPhotographViewClickAddImage;
}

/*!
 *  @author swp_song, 2016-03-04 17:53:40
 *
 *  @brief  swpSelectPhotographViewClickCell:   ( 点击 cell 回调 )
 *
 *  @param  swpSelectPhotographViewClickCell
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickCell:(SwpSelectPhotographViewClickCellAtIndexPath)swpSelectPhotographViewClickCell {
    _swpSelectPhotographViewClickCell = swpSelectPhotographViewClickCell;
}


/*!
 *  @author swp_song, 2016-03-04 17:54:40
 *
 *  @brief  swpSelectPhotographViewClickDeleteButton:   (  点击 删除 按钮 回调  )
 *
 *  @param  swpSelectPhotographViewClickDeleteButton
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickDeleteButton:(SwpSelectPhotographViewClickCellAtIndexPath)swpSelectPhotographViewClickDeleteButton {
    _swpSelectPhotographViewClickDeleteButton = swpSelectPhotographViewClickDeleteButton;
}

/*!
 *  @author swp_song, 2016-03-04 17:59:40
 *
 *  @brief  setSwpSelectPhotographScrollDirection:  ( 设置 滑动 方向 )
 *
 *  @param  swpSelectPhotographScrollDirection
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographScrollDirection:(UICollectionViewScrollDirection)swpSelectPhotographScrollDirection {
    _swpSelectPhotographScrollDirection = swpSelectPhotographScrollDirection;
    self.flowLayout.scrollDirection     = _swpSelectPhotographScrollDirection;
}

#pragma mark - Init UI Methods
- (UICollectionViewFlowLayout *)flowLayout {
    
    return !_flowLayout ? _flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing          = 15;
        flowLayout.minimumInteritemSpacing     = 0;
        flowLayout;
    }) : _flowLayout;
}

- (void)dealloc {
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
