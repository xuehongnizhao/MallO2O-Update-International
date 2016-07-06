//
//  SpecialCollectionViewCell.h
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialCollectionViewCell.h"
#import "SpecialModel.h"

@interface SpecialCollectionViewCell : UICollectionViewCell

@property (strong ,nonatomic) UIImageView *specialImgView;

@property (strong ,nonatomic) UILabel *specialPriceLabel;

@property (strong ,nonatomic) UILabel *specialOldPriceLabel;

@property (strong ,nonatomic) UILabel *specialNameLabel;

@property (strong ,nonatomic) SpecialModel *specialModel;

+ (instancetype)cellOfCollectionView:(UICollectionView *)collection cellForRoAtIndex:(NSIndexPath *)index;

@end
