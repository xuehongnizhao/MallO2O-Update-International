//
//  CateGoodsButtonView.m
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/18.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import "CateGoodsButtonView.h"

@interface CateGoodsButtonView ()

@end

@implementation CateGoodsButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setButtonTextArray:(NSArray *)buttonTextArray{
    _buttonTextArray = buttonTextArray;
}

- (void)layoutSubviews{
    for (int i = 0; i < _buttonTextArray.count; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/_buttonTextArray.count * i, 0, SCREEN_WIDTH / _buttonTextArray.count, self.frame.size.height)];
        [button setTitle:_buttonTextArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13 * Balance_Heith];
        button.tag = i;
        [button setTitleColor:UIColorFromRGB(0x828282) forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:UIColorFromRGB(0xeb4c62) forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    for (int i = 1; i < _buttonTextArray.count; i ++) {
        UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/_buttonTextArray.count * i, 8, 0.6, self.frame.size.height - 16)];
        xian.backgroundColor = UIColorFromRGB(0xe2e2e2);
        [self addSubview:xian];
    }
    UIView *downXian = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.8, SCREEN_WIDTH, 0.8)];
    downXian.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [self addSubview:downXian];
}

- (void)clickButtonAtIndex:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(touchButtonAtIndex:)]) {
        [self.delegate touchButtonAtIndex:button.tag];
    }
    for (UIButton *allButton in self.subviews) {
        if ([allButton isKindOfClass:[UIButton class]]) {
            if (button.tag != 3) {
                if (allButton.tag == button.tag) {
                    [button setTitleColor:UIColorFromRGB(0xeb4c62) forState:UIControlStateNormal];
                }else
                    [allButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            }
        }
    }
}

@end
