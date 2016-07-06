//
//  PersonInfoView.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "PersonInfoView.h"

@interface PersonInfoView ()

@property (strong ,nonatomic) UILabel *detailLabel;

@property (strong ,nonatomic) UILabel *typeLabel;

@end

@implementation PersonInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.detailLabel];
    [_detailLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_detailLabel autoSetDimension:ALDimensionHeight toSize:35 * Balance_Heith];
    [self addSubview:self.typeLabel];
    [_typeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_typeLabel autoSetDimension:ALDimensionHeight toSize:30 * Balance_Heith];
}

- (void)setDic:(NSDictionary *)dic{
    [self initUI];
    _detailLabel.text = [NSString stringWithFormat:@"%d",[dic[@"detail"] intValue]];
    _typeLabel.text = dic[@"type"];
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initForAutoLayout];
        
        
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = UIColorFromRGB(0x777777);
    }
    return _typeLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initForAutoLayout];
        
        _detailLabel.text = _dic[@"detail"];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:22];
        _detailLabel.textColor = UIColorFromRGB(0x555555);
    }
    return _detailLabel;
}

//- (void)setDic:(NSDictionary *)dic{
//    _dic = dic;
//    [self initUI];
//}

@end
