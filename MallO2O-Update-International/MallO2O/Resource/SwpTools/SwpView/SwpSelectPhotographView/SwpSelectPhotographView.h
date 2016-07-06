//
//  SwpSelectPhotographView.h
//  SMServerUser
//
//  Created by songweiping on 16/3/2.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SwpSelectPhotographView;

NS_ASSUME_NONNULL_BEGIN

/*! Click Cell Block And Click DeleteButton Block !*/
typedef void(^SwpSelectPhotographViewClickCellAtIndexPath)(SwpSelectPhotographView *swpSelectPhotographView, NSIndexPath *indexPath);
/*! Click Add Image Block !*/
typedef void(^SwpSelectPhotographViewClickAddImage)(SwpSelectPhotographView *swpSelectPhotographView, BOOL isPermitAdd);

/*! 协议 !*/
@protocol SwpSelectPhotographViewDelegate <NSObject>

@optional


/*!
 *  @author swp_song, 2016-03-04 17:45:20
 *
 *  @brief  swpSelectPhotographView:permitAddImage: ( swpSelectPhotographView 代理方法 点击 添加图片 调用 )
 *
 *  @param  swpSelectPhotographView
 *
 *  @param  isPermitAdd
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographView:(SwpSelectPhotographView *)swpSelectPhotographView permitAddImage:(BOOL)isPermitAdd;

/*!
 *  @author swp_song, 2016-03-04 17:46:27
 *
 *  @brief  swpSelectPhotographView:didSelectItemAtIndexPath:   ( swpSelectPhotographView 代理方法 点击 cell 调用 )
 *
 *  @param  swpSelectPhotographView
 *
 *  @param  indexPath
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographView:(SwpSelectPhotographView *)swpSelectPhotographView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/*!
 *  @author swp_song, 2016-03-04 17:47:18
 *
 *  @brief  swpSelectPhotographView:clickDeleteButtonIndexPath: ( swpSelectPhotographView 代理方法 点击 cell 中 删除 按钮 调用 )
 *
 *  @param  swpSelectPhotographView
 *
 *  @param  indexPath
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographView:(SwpSelectPhotographView *)swpSelectPhotographView clickDeleteButtonIndexPath:(NSIndexPath *)indexPath;

@end

@interface SwpSelectPhotographView : UICollectionView

/*!
 *  @author swp_song, 2016-03-04 17:28:16
 *
 *  @brief  swpSelectPhotograph     ( 快速 初始化 SwpSelectPhotographView  )
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
+ (instancetype)swpSelectPhotograph;

/*!
 *  @author swp_song, 2016-03-04 17:29:25
 *
 *  @brief  initSwpSelectPhotograph ( 初始化 SwpSelectPhotographView )
 *
 *  @return SwpSelectPhotographView
 *
 *  @since  1.0.1
 */
- (instancetype)initSwpSelectPhotograph;

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
+ (instancetype)swpSelectPhotographWithData:(NSArray<UIImage *> *)imageDataSource;

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
- (instancetype)initSwpSelectPhotographWithData:(NSArray<UIImage *> *)imageDataSource;

/*! SwpSelectPhotographView Delegate                    !*/
@property (nullable, nonatomic, weak) id<SwpSelectPhotographViewDelegate>swpSelectPhotographViewDelegate;

/*! SwpSelectPhotographView 数据源                      !*/
@property (nonatomic, copy  ) NSArray<UIImage *> *swpSelectImageDataSource;

/*! SwpSelectPhotographView Cell Sise                   !*/
@property (nonatomic, assign) CGSize  swpSelectPhotographCellSize;

/*! SwpSelectPhotographView 设置 添加 图片 最大 数量    !*/
@property (nonatomic, assign) CGFloat swpSelectPhotograpImagMaxQuantity;

/*! SwpSelectPhotographView 设置 cell 中 删除 按钮图片  !*/
@property (nullable, nonatomic, strong) UIImage *swpSelectPhotographCellDeleteButtonImage;

/*! SwpSelectPhotographView 设置 滑动 方向              !*/
@property (nonatomic, assign) UICollectionViewScrollDirection swpSelectPhotographScrollDirection;


/*!
 *  @author swp_song, 2016-03-04 17:41:40
 *
 *  @brief  setSwpSelectImageDataSource:    ( Override Setter 设置 数据源 刷新数据 )
 *
 *  @param  swpSelectImageDataSource
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectImageDataSource:(NSArray<UIImage *> *)swpSelectImageDataSource;

/*!
 *  @author swp_song, 2016-03-04 17:51:41
 *
 *  @brief  swpSelectPhotographViewClickAddImage:   ( 点击 添加 图片 回调 )
 *
 *  @param  swpSelectPhotographViewClickAddImage
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickAddImage:(SwpSelectPhotographViewClickAddImage)swpSelectPhotographViewClickAddImage;

/*!
 *  @author swp_song, 2016-03-04 17:53:40
 *
 *  @brief  swpSelectPhotographViewClickCell:   ( 点击 cell 回调 )
 *
 *  @param  swpSelectPhotographViewClickCell
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickCell:(SwpSelectPhotographViewClickCellAtIndexPath)swpSelectPhotographViewClickCell;

/*!
 *  @author swp_song, 2016-03-04 17:54:40
 *
 *  @brief  swpSelectPhotographViewClickDeleteButton:   (  点击 删除 按钮 回调  )
 *
 *  @param  swpSelectPhotographViewClickDeleteButton
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographViewClickDeleteButton:(SwpSelectPhotographViewClickCellAtIndexPath)swpSelectPhotographViewClickDeleteButton;

/*!
 *  @author swp_song, 2016-03-04 17:59:40
 *
 *  @brief  setSwpSelectPhotographScrollDirection:  ( 设置 滑动 方向 )
 *
 *  @param  swpSelectPhotographScrollDirection
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographScrollDirection:(UICollectionViewScrollDirection)swpSelectPhotographScrollDirection;

@end

NS_ASSUME_NONNULL_END
