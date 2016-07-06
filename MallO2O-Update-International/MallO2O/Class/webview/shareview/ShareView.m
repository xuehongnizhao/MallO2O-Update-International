//
//  ShareView.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()<UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (strong ,nonatomic) UICollectionView *shareCollectionView;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)layoutSubviews{
    
}

- (void)addUI{
    [self addSubview:self.shareCollectionView];
}

- (UICollectionView *)shareCollectionView{
    if (!_shareCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/5) collectionViewLayout:flowLayout];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _shareCollectionView.delegate = self;
        _shareCollectionView.dataSource = self;
        _shareCollectionView.backgroundColor = [UIColor whiteColor];
        [_shareCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _shareCollectionView;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
    [cell.contentView addSubview:imageView];
    [imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 20, 30, 20)];
    imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    UILabel *shareTypeLabel = [[UILabel alloc] initForAutoLayout];
    [cell.contentView addSubview:shareTypeLabel];
    [shareTypeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:-5];
    [shareTypeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [shareTypeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [shareTypeLabel autoSetDimension:ALDimensionHeight toSize:25];
    shareTypeLabel.font = [UIFont systemFontOfSize:12];
    shareTypeLabel.textAlignment = NSTextAlignmentCenter;
    shareTypeLabel.text = _shareName[indexPath.row];
    cell.layer.borderColor = UIColorFromRGB(0xf3f3f3).CGColor;
    cell.layer.borderWidth = 0.7;
    shareTypeLabel.textColor = UIColorFromRGB(0x666666);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/5 , SCREEN_WIDTH/5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)clickShareImg:(ShareViewBlock)block{
    self.block = block;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(indexPath.row);
    }
}

@end
