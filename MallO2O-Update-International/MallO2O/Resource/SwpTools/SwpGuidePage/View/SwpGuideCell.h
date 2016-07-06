//
//  SwpGuideCell.h
//  Swp_song
//
//  Created by songweiping on 15/8/13.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwpGuideModel;
@class SwpGuideCell;

@protocol SwpGuideCellDelegate <NSObject>

@optional

/*!
 *  @author swp_song, 15-12-21 16:12:11
 *
 *  @brief  swpGuideCell Delegate ( swpGuideCell 代理方法 点击时调用 )
 *
 *  @param  swpGuideCell
 *
 *  @param  button
 *
 *  @since  1.0.7
 */
- (void)swpGuideCell:(SwpGuideCell *)swpGuideCell didButtin:(UIButton *)button;

@end

@interface SwpGuideCell : UICollectionViewCell

/*!
 *  @author swp_song, 2015-12-21 16:30:51
 *
 *  @brief  swpGuideCellWithCollectionView ( 快速创建一个 引导页 显示的cell )
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 *
 *  @param  cellID
 *
 *  @return SwpGuideCell
 *
 *  @since  1.0.7
 */
+ (instancetype) swpGuideCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath forCellWithReuseIdentifier:(NSString *)cellID;


/*! SwpGuideCell    代理属性   !*/
@property (assign, nonatomic) id<SwpGuideCellDelegate> delegate;
/*! SwpGuideModel   数据模型   !*/
@property (strong, nonatomic) SwpGuideModel *swpGuide;
/*! 隐藏 进入 App 按钮         !*/
@property (assign, nonatomic, getter=isSwpIntoAppButtonHidden) BOOL swpIntoAppButtonHidden;


/*!
 *  @author swp_song, 2015-12-21 16:37:41
 *
 *  @brief  setSwpGuide ( 重写数据 模型 set 方法 设置数据 )
 *
 *  @param  swpGuide
 *
 *  @since  1.0.7
 */
- (void)setSwpGuide:(SwpGuideModel *)swpGuide;

/*!
 *  @author swp_song, 15-12-21 16:12:25
 *
 *  @brief settingSwpIntoAppButtonFrame ( 设置 点击进入 App 按钮 )
 *
 *  @param  button
 *
 *  @since  1.0.7
 */
- (void) settingSwpIntoAppButtonFrame:(void(^)(UIButton *button))button;



/*!
 *  @author swp_song, 2015-12-21 16:40:14
 *
 *  @brief  setSwpIntoAppButtonHidden  ( 隐藏 进入 App 按钮 )
 *
 *  @param  swpIntoAppButtonHidden
 *
 *  @since  1.0.7
 */
- (void)setSwpIntoAppButtonHidden:(BOOL)swpIntoAppButtonHidden;





@end
