//
//  SwpSelectPhotographCell.m
//  SMServerUser
//
//  Created by songweiping on 16/3/4.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpSelectPhotographCell.h"


static CGFloat const kSwpSelectPhotographDeleteButtonHeight = 20;

@interface SwpSelectPhotographCell ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示 图片 view !*/
@property (nonatomic, strong) UIImageView *swpSelectPhotographView;
/*! 点击 删除 按钮 !*/
@property (nonatomic, strong) UIButton    *swpSelectPhotographDeleteButton;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 记录cell 索引       !*/
@property (nonatomic, strong) NSIndexPath *indexPath;
/*! 点击删除按钮 回调   !*/
@property (nonatomic, copy  ) SwpSelectPhotographCellClickDeleteButton swpSelectPhotographCellClickDeleteButton;
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpSelectPhotographCell


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
+ (instancetype)swpSelectPhotographCellWithCollectionView:(UICollectionView *)collectionView cellIdentifier:(NSString *)identifier cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SwpSelectPhotographCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.indexPath                = indexPath;
    return cell;
}


/*!
 *  @author swp_song, 2016-03-04 18:08:51
 *
 *  @brief  initWithFrame:frame:    ( Override )
 *
 *  @param  frame
 *
 *  @return SwpSelectPhotographCell
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
     
        [self setUpUI];
    }
    
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  layoutSubviews  ( Override )
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.swpSelectPhotographView.frame         = self.contentView.bounds;
    self.swpSelectPhotographDeleteButton.frame = CGRectMake(CGRectGetMaxX(self.swpSelectPhotographView.frame) - kSwpSelectPhotographDeleteButtonHeight - 5, 5, kSwpSelectPhotographDeleteButtonHeight , kSwpSelectPhotographDeleteButtonHeight);
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 )
 */
- (void) setUpUI {
    [self.contentView addSubview:self.swpSelectPhotographView];
    [self.contentView addSubview:self.swpSelectPhotographDeleteButton];
}

/*!
 *  @author swp_song
 *
 *  @brief  clickButton:    ( 按钮 绑定方法 )
 *
 *  @param  button
 *
 *  @since  1.0.1
 */
- (void)clickButton:(UIButton *)button {
    
    if (self.swpSelectPhotographCellClickDeleteButton) self.swpSelectPhotographCellClickDeleteButton(self, _indexPath);
    
    if ([self.delegate respondsToSelector:@selector(swpSelectPhotographCell:clickDeleteButtonIndexPath:)]) {
        [self.delegate swpSelectPhotographCell:self clickDeleteButtonIndexPath:_indexPath];
    }
}

#pragma mark - Public Methods

/*!
 *  @author swp_song, 2016-03-04 18:13:36
 *
 *  @brief  setSwpSelectPhotographDeleteButtonImage:    ( Override Setter 设置 cell 删除按钮 显示图片 )
 *
 *  @param  swpSelectPhotographDeleteButtonImage
 */
- (void)setSwpSelectPhotographDeleteButtonImage:(UIImage *)swpSelectPhotographDeleteButtonImage {
    
    _swpSelectPhotographDeleteButtonImage = swpSelectPhotographDeleteButtonImage;
    [self.swpSelectPhotographDeleteButton setImage:_swpSelectPhotographDeleteButtonImage forState:UIControlStateNormal];
    [self.swpSelectPhotographDeleteButton setImage:_swpSelectPhotographDeleteButtonImage forState:UIControlStateHighlighted];
}

/*!
 *  @author swp_song, 2016-03-04 18:14:55
 *
 *  @brief  setSwpSelectPhotographImage:    ( Override Setter 设置 cell 显示图片 )
 *
 *  @param  swpSelectPhotographImage
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographImage:(UIImage *)swpSelectPhotographImage {
    _swpSelectPhotographImage          = swpSelectPhotographImage;
    self.swpSelectPhotographView.image = _swpSelectPhotographImage;
}

/*!
 *  @author swp_song, 16-03-04 18:03:26
 *
 *  @brief  setSwpSelectPhotographDeleteButtonHidden:   ( Override Setter 设置 cell 删除按钮 隐藏 )
 *
 *  @param  swpSelectPhotographDeleteButtonHidden
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographDeleteButtonHidden:(BOOL)swpSelectPhotographDeleteButtonHidden {

    _swpSelectPhotographDeleteButtonHidden      = swpSelectPhotographDeleteButtonHidden;
    self.swpSelectPhotographDeleteButton.hidden = _swpSelectPhotographDeleteButtonHidden;
}

/*!
 *  @author swp_song, 2016-03-04 18:19:59
 *
 *  @brief  setSwpSelectPhotographCellClickDeleteButton:    ( 点击 删除anni )
 *
 *  @param  swpSelectPhotographCellClickDeleteButton
 *
 *  @since  1.0.1
 */
- (void)setSwpSelectPhotographCellClickDeleteButton:(SwpSelectPhotographCellClickDeleteButton)swpSelectPhotographCellClickDeleteButton {
    _swpSelectPhotographCellClickDeleteButton = swpSelectPhotographCellClickDeleteButton;
}

#pragma mark - Init UI Methods
- (UIImageView *)swpSelectPhotographView {
    
    return !_swpSelectPhotographView ? _swpSelectPhotographView = ({
        UIImageView *imageView = [UIImageView new];
        imageView;
    }) : _swpSelectPhotographView;
}

- (UIButton *)swpSelectPhotographDeleteButton {
    
    return !_swpSelectPhotographDeleteButton ? _swpSelectPhotographDeleteButton = ({
        UIButton *button = [UIButton new];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    }) : _swpSelectPhotographDeleteButton;
}

- (void)dealloc {
    
}



@end
