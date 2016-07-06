//
//  SwpBannerViewCell.h
//  Swp_song
//
//  Created by songweiping on 15/8/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  @author             --->    swp_song
//
//  @modification Time  --->    2015-12-09 16:32:07
//
//  @since              --->    1.0.7

#import <UIKit/UIKit.h>

@interface SwpBannerViewCell : UICollectionViewCell

/*! 显示图片的名称     !*/
@property (nonatomic, copy  ) NSString *imageName;
/*! 是否 加载 远程 url !*/
@property (nonatomic, assign, getter=isLoadNetworkImage) BOOL loadNetworkImage;

/*!
 *  @author swp_song, 2015-12-09 16:19:35
 *
 *  @brief  Override setImageName
 *
 *  @param imageName
 *
 *  @since  1.0.7
 */
- (void)setImageName:(NSString *)imageName;

@end
