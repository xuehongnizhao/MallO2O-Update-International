//
//  SearchHotGoodsCollectionViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/2/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SearchHotGoodsCollectionViewCell.h"

@interface SearchHotGoodsCollectionViewCell ()

@property (strong ,nonatomic) UILabel *label;

@end

@implementation SearchHotGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
    }
    return self;
}

+ (instancetype)cellOfCollectionView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath withCellId:(NSString *)cellIdentifier{
    SearchHotGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.label];
    [_label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _label.text = dataDic[@"name"];
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initForAutoLayout];
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = UIColorFromRGB(0x676767);
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
