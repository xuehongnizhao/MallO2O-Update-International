//
//  CateHeaderCollectionReusableView.h
//  MallO2O
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateHeaderCollectionReusableView : UICollectionReusableView

@property (strong ,nonatomic) UILabel *lable;

@property (copy ,nonatomic) NSString *titleLabelString;

+ (instancetype)viewInCollection:(UICollectionView *)collection reuserIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath;

@end
