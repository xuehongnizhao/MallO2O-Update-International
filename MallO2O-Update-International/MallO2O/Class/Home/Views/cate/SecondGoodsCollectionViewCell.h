//
//  SecondGoodsCollectionViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/19.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondModel;

@protocol SecondGoodsCollectionViewCellDelegate <NSObject>

- (void)clickCellButton:(NSInteger)index;

@end

@interface SecondGoodsCollectionViewCell : UICollectionViewCell

+ (instancetype)secondGoodsCollection:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellID;

@property (copy ,nonatomic) SecondModel *model;

@property (assign ,nonatomic) id<SecondGoodsCollectionViewCellDelegate>delegate;

@property (copy ,nonatomic) NSIndexPath *cellIndexPath;

@end
