//
//  SearchHotGoodsCollectionViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/2/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHotGoodsCollectionViewCell : UICollectionViewCell

@property (copy ,nonatomic) NSString *string;

@property (copy ,nonatomic) NSDictionary *dataDic;

+ (instancetype)cellOfCollectionView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath withCellId:(NSString *)cellIdentifier;

@end
