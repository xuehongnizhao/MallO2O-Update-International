//
//  CateCollectionViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateCollectionViewCell.h"

@interface CateCollectionViewCell ()

@property (strong ,nonatomic) UIImageView *imageView;

@property (strong ,nonatomic) UILabel *nameLabel;

@end

@implementation CateCollectionViewCell

+ (instancetype)cellOfCollectionView:(UICollectionView *)collectionView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"cell";
    CateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:index];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addUI];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.6;
        self.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    }
    return self;
}

/**
 添加控件
 */
- (void)addUI{
    _imageView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_imageView];
//    _imageView.layer.borderWidth = 1;
    
    _nameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.backgroundColor = [UIColor whiteColor];
//    _nameLabel.layer.borderWidth = 1;
    
    [self settingAutoLayout];
}
/**
 自动布局
 */
- (void)settingAutoLayout{
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [_imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:_imageView];
    
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:2];
    [_nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:2];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = UIColorFromRGB(0x333333);
//    self.layer.borderWidth = 1;
}

- (void)setModel:(CateCollectionModel *)model{
    _model = model;
    [self setData];
}

- (void)setData{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = _model.goodsName;
}

@end
