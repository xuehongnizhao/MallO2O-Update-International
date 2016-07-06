//
//  SwpGuideCell.m
//  Swp_song
//
//  Created by songweiping on 15/8/13.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SwpGuideCell.h"

/*! ---------------------- Model      ---------------------- !*/
#import "SwpGuideModel.h"               // SwpGuidePage 数据模型
/*! ---------------------- Model      ---------------------- !*/

@interface SwpGuideCell ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示 引导页图片view */
@property (nonatomic, strong) UIImageView *swpGuideImageView;
/*! 显示 进入 app 按钮  */
@property (nonatomic, strong) UIButton    *swpIntoAppButton;
/*! ---------------------- UI   Property  ---------------------- !*/

@end

@implementation SwpGuideCell

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
+ (instancetype) swpGuideCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath forCellWithReuseIdentifier:(NSString *)cellID {
    
    SwpGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}

/*!
 *  @author swp_song, 2015-12-21 16:32:44
 *
 *  @brief  Override initWithFrame
 *
 *  @param  frame
 *
 *  @since  1.0.7
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

/*!
 *  @author swp_song, 2015-12-21 16:33:45
 *
 *  @brief  Override    layoutSubviews
 *
 *  @since  1.0.7
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.swpGuideImageView.frame = self.bounds;
}

/*!
 *  @author swp_song, 2015-12-21 16:34:48
 *
 *  @brief  添加控件
 *
 *  @since  1.0.7
 */
- (void) setupUI {
    [self.contentView addSubview:self.swpGuideImageView];
//    [self.contentView addSubview:self.swpIntoAppButton];
}

/*!
 *  @author swp_song, 2015-12-21 16:36:56
 *
 *  @brief  settingButtonDefineFrame ( 设置 控件 frame )
 *
 *  @since  1.0.7
 */
- (void) settingButtonDefineFrame {
    _swpIntoAppButton.userInteractionEnabled = YES;
    CGFloat  buttonH    = 35;
    
    CGFloat  buttonX    = [[UIScreen mainScreen] bounds].size.width * 0.5;
    
    CGFloat  buttonY    = [[UIScreen mainScreen] bounds].size.height * 0.8 + buttonH;
    
    _swpIntoAppButton.center = CGPointMake(buttonX, buttonY);
    
    _swpIntoAppButton.bounds = (CGRect){CGPointZero, CGSizeMake(200, buttonH)};
    
}


/*!
 *  @author swp_song, 2015-12-21 16:37:41
 *
 *  @brief  setSwpGuide ( 重写数据 模型 set 方法 设置数据 )
 *
 *  @param  swpGuide
 *
 *  @since  1.0.7
 */
- (void)setSwpGuide:(SwpGuideModel *)swpGuide {
    _swpGuide = swpGuide;
    [self settingData];
    [self settingButtonDefineFrame];
}

/*!
 *  @author swp_song, 2015-12-21 16:38:07
 *
 *  @brief  settingData ( 设置 数据 )
 *
 *  @since  1.0.7
 */
- (void) settingData {
    
    self.swpGuideImageView.image = [UIImage imageNamed:self.swpGuide.swpGuideImageName];
    self.swpIntoAppButton.hidden = self.swpGuide.swpGuideIndex == self.swpGuide.swpGuideCount - 1 ? NO : YES;
}



#pragma mark - Setting SwpGuideCell Property Methods

/*!
 *  @author swp_song, 15-12-21 16:12:25
 *
 *  @brief settingSwpIntoAppButtonFrame ( 设置 点击进入 App 按钮 )
 *
 *  @param  button
 *
 *  @since  1.0.7
 */
- (void) settingSwpIntoAppButtonFrame:(void(^)(UIButton *button))button {
    button(self.swpIntoAppButton);
}

/*!
 *  @author swp_song, 2015-12-21 16:40:14
 *
 *  @brief  setSwpIntoAppButtonHidden  ( 隐藏 进入 App 按钮 )
 *
 *  @param  swpIntoAppButtonHidden
 *
 *  @since  1.0.7
 */
- (void)setSwpIntoAppButtonHidden:(BOOL)swpIntoAppButtonHidden {
    _swpIntoAppButtonHidden      = swpIntoAppButtonHidden;
    self.swpIntoAppButton.hidden = _swpIntoAppButtonHidden;
}




#pragma mark - DidButton & swpGuideCell Delegate - Methods
/*!
 *  @author swp_song, 2015-12-21 16:41:14
 *
 *  @brief  didButton ( 按钮的点击事件 )
 *
 *  @param  button
 *
 *  @since  1.0.7
 */
- (void) didButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(swpGuideCell:didButtin:)]) {
        [self.delegate swpGuideCell:self didButtin:button];
    }
}

#pragma mark - Common Methods
/*!
 *  @author swp_song, 2015-12-21 16:42:47
 *
 *  @brief  settingButton   ( 快速 设置按钮的 公用属性 )
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
- (void) settingButton:(UIButton *)button setBackgroundColor:(UIColor *)backgroundColor setTitle:(NSString *)title setTitleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize {
    button.backgroundColor     = backgroundColor;
    button.layer.cornerRadius  = 3;
    button.layer.masksToBounds = YES;
    button.titleLabel.font     = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchDown];
}



#pragma mark - Init UI Methods
- (UIButton *)swpIntoAppButton {
    
    if (!_swpIntoAppButton) {
        
        _swpIntoAppButton = [[UIButton alloc] init];
        _swpIntoAppButton.backgroundColor = [UIColor redColor];
         [self settingButton:_swpIntoAppButton setBackgroundColor:[UIColor whiteColor] setTitle:@"点击进入" setTitleColor:[UIColor blackColor] titleFontSize:15];
    }
    return _swpIntoAppButton;
}

- (UIImageView *)swpGuideImageView {
    
    if (!_swpGuideImageView) {
        
        _swpGuideImageView = [[UIImageView alloc] init];
        
        _swpGuideImageView.userInteractionEnabled = YES;
    }
    return _swpGuideImageView;
}

@end
