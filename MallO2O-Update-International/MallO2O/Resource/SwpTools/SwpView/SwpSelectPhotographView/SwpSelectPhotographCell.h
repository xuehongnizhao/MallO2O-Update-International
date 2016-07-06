//
//  SwpSelectPhotographCell.h
//  SMServerUser
//
//  Created by songweiping on 16/3/4.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SwpSelectPhotographCell;

NS_ASSUME_NONNULL_BEGIN


/*! Click Delete Button Block !*/
typedef void(^SwpSelectPhotographCellClickDeleteButton)(SwpSelectPhotographCell *swpSelectPhotographCell, NSIndexPath *indexPath);

/*! 协议 !*/
@protocol SwpSelectPhotographCellDelegate <NSObject>

@optional
/*!
 *  @author swp_song, 2016-03-04 18:10:37
 *
 *  @brief  swpSelectPhotographCell:clickDeleteButtonIndexPath: ( swpSelectPhotographCell 代理 方法 点击 删除 按钮 回调 )
 *
 *  @param  swpSelectPhotographCell
 *
 *  @param  indexPath
 *
 *  @since  1.0.1
 */
- (void)swpSelectPhotographCell:(SwpSelectPhotographCell *)swpSelectPhotographCell clickDeleteButtonIndexPath:(NSIndexPath *)indexPath;

@end

@interface SwpSelectPhotographCell : UICollectionViewCell

/*!
 *  @author swp_song, 2016-03-04 18:07:14
 *
 *  @brief  swpSelectPhotographCellWithCollectionView:cellIdentifier:cellForItemAtIndexPath:    ( 快速初始 SwpSelectPhotographCell  )
 *
 *  @param  collectionView
 *
 *  @param  identifier
 *
 *  @param  indexPath
 *
 *  @return SwpSelectPhotographCell
 *
 *  @since  1.0.1
 */
+ (instancetype)swpSelectPhotographCellWithCollectionView:(UICollectionView *)collectionView cellIdentifier:(NSString *)identifier cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/*! SwpSelectPhotographCell Delegate !*/
@property (nullable, nonatomic, weak  ) id<SwpSelectPhotographCellDelegate>delegate;

/*! 设置  SwpSelectPhotographCell 删除按钮显示图片 !*/
@property (nullable, nonatomic, strong) UIImage *swpSelectPhotographDeleteButtonImage;

/*! 设置  SwpSelectPhotographCell 显示图片         !*/
@property (nonatomic, strong) UIImage *swpSelectPhotographImage;
/*! 设置  SwpSelectPhotographCell 删除按钮隐藏     !*/
@property (nonatomic, assign, getter = isSwpSelectPhotographDeleteButtonHidden) BOOL swpSelectPhotographDeleteButtonHidden;

/*!
 *  @author swp_song, 2016-03-04 18:13:36
 *
 *  @brief  setSwpSelectPhotographDeleteButtonImage:    ( Override Setter 设置 cell 删除按钮 显示图片 )
 *
 *  @param  swpSelectPhotographDeleteButtonImage
 */
- (void)setSwpSelectPhotographDeleteButtonImage:(UIImage *)swpSelectPhotographDeleteButtonImage;

/*!
 *  @author swp_song, 2016-03-04 18:14:55
 *
 *  @brief  setSwpSelectPhotographImage:    ( Override Setter 设置 cell 显示图片 )
 *
 *  @param  swpSelectPhotographImage
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographImage:(UIImage *)swpSelectPhotographImage;

/*!
 *  @author swp_song, 2016-03-04 18:19:59
 *
 *  @brief  setSwpSelectPhotographCellClickDeleteButton:    ( 点击 删除anni )
 *
 *  @param  swpSelectPhotographCellClickDeleteButton
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographCellClickDeleteButton:(SwpSelectPhotographCellClickDeleteButton)swpSelectPhotographCellClickDeleteButton;



@end
NS_ASSUME_NONNULL_END
