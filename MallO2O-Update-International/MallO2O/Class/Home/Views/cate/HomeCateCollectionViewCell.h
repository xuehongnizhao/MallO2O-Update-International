//
//  HomeCateCollectionViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/17.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondModel;

@interface HomeCateCollectionViewCell : UICollectionViewCell

@property (copy ,nonatomic) SecondModel *model;

+ (instancetype)homeCateColleciontView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
