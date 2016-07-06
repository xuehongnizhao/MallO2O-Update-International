//
//  CateCollectionViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateCollectionViewCell.h"
#import "CateCollectionModel.h"

@interface CateCollectionViewCell : UICollectionViewCell

+ (instancetype)cellOfCollectionView:(UICollectionView *)collectionView cellForRowAtIndex:(NSIndexPath *)index;

@property (strong ,nonatomic) CateCollectionModel *model;

@end
