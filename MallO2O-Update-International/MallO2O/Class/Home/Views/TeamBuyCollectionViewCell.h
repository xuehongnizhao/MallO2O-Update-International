//
//  TeamBuyCollectionViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/20.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondModel;

@interface TeamBuyCollectionViewCell : UICollectionViewCell

@property (copy ,nonatomic) SecondModel *model;

+ (instancetype)secondGoodsCollection:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellID;

@end
