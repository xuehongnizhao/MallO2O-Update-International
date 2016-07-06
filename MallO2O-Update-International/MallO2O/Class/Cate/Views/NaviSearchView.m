//
//  NaviSearchView.m
//  MallO2O
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "NaviSearchView.h"

@interface NaviSearchView ()

@property (strong ,nonatomic) UILabel *textLable;

@property (strong ,nonatomic) UIImageView *searchImgView;

@end

@implementation NaviSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
        [self settingProperty];
        [self setViewGesture];
    }
    return self;
}

- (void)setViewGesture{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    [self addGestureRecognizer:gesture];
}

- (void)clickView{
    if ([self.delegate respondsToSelector:@selector(clickNaviSearchView)]) {
        [self.delegate clickNaviSearchView];
    }
}

- (void)addUI{
    [self addSubview:self.textLable];
    [self addSubview:self.searchImgView];
}

- (void)settingAutoLayout{
    [_textLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 40, 5, 0) excludingEdge:ALEdgeRight];
    [_textLable sizeToFit];
    
    [_searchImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
    [_searchImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_searchImgView autoSetDimension:ALDimensionWidth toSize:25];
    [_searchImgView autoSetDimension:ALDimensionHeight toSize:25];
}

- (void)settingProperty{
//    self.backGroudColor = [UIColor whiteColor];
    self.backgroundColor = SWPColor(204, 204, 204, 1);
    self.textLable.textColor = [UIColor blackColor];
    self.textLable.text = @"请输入商品名称";
    _textLable.font = [UIFont systemFontOfSize:13];
    _searchImgView.image = [UIImage imageNamed:@"search_no"];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
}

- (UILabel *)textLable{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initForAutoLayout];
        _textLable.layer.cornerRadius = 3;
        _textLable.layer.masksToBounds = YES;
    }
    return _textLable;
}

- (UIImageView *)searchImgView{
    if (!_searchImgView) {
        _searchImgView = [[UIImageView alloc] initForAutoLayout];
    }
    return _searchImgView;
}

- (void)setBackGroudColor:(UIColor *)backGroudColor{
     self.backgroundColor = backGroudColor;
}
- (void)setTextLabelString:(NSString *)textLabelString{
    self.textLable.text = textLabelString;
}
- (void)setTextColor:(UIColor *)textColor{
    self.textLable.textColor = textColor;
}

- (void)setCornerRadius:(NSInteger)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setShopCarImageName:(NSString *)shopCarImageName{
    self.searchImgView.image = [UIImage imageNamed:shopCarImageName];
}

- (void)setImageSize:(CGSize )imageSize{
    [_searchImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
    [_searchImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_searchImgView autoSetDimension:ALDimensionWidth toSize:imageSize.width];
    [_searchImgView autoSetDimension:ALDimensionHeight toSize:imageSize.height];
}

- (void)setTextLabelColor:(UIColor *)textLabelColor{
    self.textLable.backgroundColor = textLabelColor;
}

@end
