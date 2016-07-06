//
//  CateHeaderCollectionReusableView.m
//  MallO2O
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateHeaderCollectionReusableView.h"

@implementation CateHeaderCollectionReusableView

+ (instancetype)viewInCollection:(UICollectionView *)collection reuserIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath{
    CateHeaderCollectionReusableView *view = [collection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    return view;
}

- (void)setTitleLabelString:(NSString *)titleLabelString{
    [self addUI];
    self.lable.text = titleLabelString;
}

- (void)addUI{
    [self addSubview:self.lable];
    [_lable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 2*Balance_Width, 0, 0)];
}

- (UILabel *)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] initForAutoLayout];
        _lable.font = [UIFont systemFontOfSize:15];
        _lable.textColor = UIColorFromRGB(0x1e1f21);
    }
    return _lable;
}

@end
