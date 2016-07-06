//
//  SwpBannerViewCell.m
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

#import "SwpBannerViewCell.h"

/*! ---------------------- Tool       ---------------------- !*/
#import <UIImageView+WebCache.h>        // Sd Web Image
/*! ---------------------- Tool       ---------------------- !*/

@interface SwpBannerViewCell ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示 默认 图片轮播 的view !*/
@property (nonatomic, strong) UIImageView *imageView;
/*! ---------------------- UI   Property  ---------------------- !*/

@end

@implementation SwpBannerViewCell

/*!
 *  @author swp_song, 15-12-09 16:12:33
 *
 *  @brief  Override initWithFrame
 *
 *  @param  frame
 *
 *  @return SwpBannerViewCell
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}


/*!
 *  @author swp_song, 2015-12-09 16:16:34
 *
 *  @brief  Override layoutSubviews ( 设置控件的位置 )
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

/*!
 *  添加控件
 */

/*!
 *  @author swp_song, 2015-12-09 16:18:03
 *
 *  @brief  addUI ( 添加控件 )
 *
 *  @since  1.0.7
 */
- (void) addUI {
    [self.contentView addSubview:self.imageView];
}


/*!
 *  @author swp_song, 2015-12-09 16:19:35
 *
 *  @brief  Override setImageName
 *
 *  @param imageName
 *
 *  @since  1.0.7
 */
- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    [self settingData];
}

/*!
 *  @author swp_song, 2015-12-09 16:20:27
 *
 *  @brief  settingData ( 设置数据 )
 *
 *  @since  1.0.7
 */
- (void) settingData {
    
    if (self.isLoadNetworkImage) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageName] placeholderImage:nil];
    } else {
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
    
}

#pragma mark - Init UI Method
- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}


@end
