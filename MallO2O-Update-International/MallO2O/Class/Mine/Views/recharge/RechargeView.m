//
//  RechargeView.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "RechargeView.h"

@interface RechargeView ()

@property (strong ,nonatomic) UIImageView *sureImageView;

@property (strong ,nonatomic) UILabel *readingLabel;

@property (strong ,nonatomic) UILabel *xieyiLabel;

@property (strong ,nonatomic) UILabel *warningThing;

@property (strong ,nonatomic) UILabel *firstLabel;

@property (strong ,nonatomic) UILabel *secLabel;

@property (strong ,nonatomic) UILabel *thirLabel;

@property (strong ,nonatomic) UILabel *fourLabel;

@end

@implementation RechargeView{
    BOOL isSelectImage;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.sureImageView];
    [self addSubview:self.readingLabel];
    [self addSubview:self.xieyiLabel];
    [self addSubview:self.warningThing];
    [self addSubview:self.firstLabel];
    [self addSubview:self.secLabel];
    [self addSubview:self.thirLabel];
    [self addSubview:self.fourLabel];
}

- (void)settingAutoLayout{
    [_sureImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_sureImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_sureImageView autoSetDimension:ALDimensionHeight toSize:20];
    [_sureImageView autoSetDimension:ALDimensionWidth toSize:20];
    
    [_readingLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_sureImageView withOffset:10];
    [_readingLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_readingLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_readingLabel autoSetDimension:ALDimensionWidth toSize:75];
    
    [_xieyiLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_readingLabel withOffset:-10];
    [_xieyiLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_xieyiLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_xieyiLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    [_warningThing autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_sureImageView withOffset:15];
    [_warningThing autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_warningThing autoSetDimension:ALDimensionHeight toSize:20];
    [_warningThing autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    [_firstLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_warningThing withOffset:10];
    [_firstLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_firstLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_firstLabel autoSetDimension:ALDimensionHeight toSize:20l];
    
    [_secLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_firstLabel withOffset:5];
    [_secLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_secLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_secLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    [_thirLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_secLabel withOffset:5];
    [_thirLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_thirLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_thirLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    [_fourLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_thirLabel withOffset:5];
    [_fourLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_fourLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_fourLabel autoSetDimension:ALDimensionHeight toSize:20];
}

- (void)clickXieYi{
    NSLog(@"点击了协议  不知道是跳转还是干什么");
    if ([self.delegate respondsToSelector:@selector(clickXieYi)]) {
        [self.delegate clickXieYi];
    }
}

- (void)clickImage{
    isSelectImage = !isSelectImage;
    if (isSelectImage) {
        _sureImageView.image = [UIImage imageNamed:@"address_sel"];
    }else{
        _sureImageView.image = [UIImage imageNamed:@"address_no"];
    }
    if ([self.delegate respondsToSelector:@selector(imageIsSelect:)]) {
        [self.delegate imageIsSelect:isSelectImage];
    }
}

- (void)setIsExist:(BOOL)isExist{
    if (isExist) {
        _sureImageView.image = [UIImage imageNamed:@"address_sel"];
    }
}

- (UIImageView *)sureImageView{
    if (!_sureImageView) {
        _sureImageView = [[UIImageView alloc] initForAutoLayout];
        _sureImageView.image = [UIImage imageNamed:@"address_no"];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        _sureImageView.userInteractionEnabled = YES;
        [_sureImageView addGestureRecognizer:gesture];
    }
    return _sureImageView;
}

- (UILabel *)readingLabel{
    if (!_readingLabel) {
        _readingLabel = [[UILabel alloc] initForAutoLayout];
        _readingLabel.font = [UIFont systemFontOfSize:16];
        _readingLabel.textColor = UIColorFromRGB(0x656668);
        _readingLabel.text = @"我已阅读";
    }
    return _readingLabel;
}

- (UILabel *)xieyiLabel{
    if (!_xieyiLabel) {
        _xieyiLabel = [[UILabel alloc] initForAutoLayout];
        _xieyiLabel.font = [UIFont systemFontOfSize:16];
        _xieyiLabel.textColor = UIColorFromRGB(0x409ce5);
        _xieyiLabel.text = @"《xx平台充值服务协议》";
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXieYi)];
        _xieyiLabel.userInteractionEnabled = YES;
        [_xieyiLabel addGestureRecognizer:gesture];
    }
    return _xieyiLabel;
}

- (UILabel *)warningThing{
    if (!_warningThing) {
        _warningThing = [[UILabel alloc] initForAutoLayout];
        _warningThing.font = [UIFont systemFontOfSize:16];
        _warningThing.textColor = UIColorFromRGB(0x3f3f3f);
        _warningThing.text = @"注意事项";
    }
    return _warningThing;
}

- (UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] initForAutoLayout];
        _firstLabel.font = [UIFont systemFontOfSize:14];
        [self setTextColor:_firstLabel];
        _firstLabel.text = @"1、请选择正规渠道购买中公网校充值卡";
    }
    return _firstLabel;
}

- (UILabel *)secLabel{
    if (!_secLabel) {
        _secLabel = [[UILabel alloc] initForAutoLayout];
        _secLabel.font = [UIFont systemFontOfSize:14];
        [self setTextColor:_secLabel];
        _secLabel.text = @"2、充值卡成功后，如遇无法正常购买课程";
    }
    return _secLabel;
}

- (UILabel *)thirLabel{
    if (!_thirLabel) {
        _thirLabel = [[UILabel alloc] initForAutoLayout];
        _thirLabel.font = [UIFont systemFontOfSize:14];
        [self setTextColor:_thirLabel];
    }
    return _thirLabel;
}

- (UILabel *)fourLabel{
    if (!_fourLabel) {
        _fourLabel = [[UILabel alloc] initForAutoLayout];
        _fourLabel.font = [UIFont systemFontOfSize:14];
        [self setTextColor:_fourLabel];
    }
    return _fourLabel;
}

- (void)setTextColor:(UILabel *)lagebl{
    lagebl.textColor = UIColorFromRGB(0x878787);
}

@end
