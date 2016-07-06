//
//  SelectView.m
//  MallO2O
//
//  Created by mac on 15/6/8.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SelectView.h"

@interface SelectView ()

@property (strong ,nonatomic) UILabel *typeTitleLabel;

@end

@implementation SelectView

#pragma mark 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addUI];
        [self setAutoLayout];
        self.backgroundColor = UIColorFromRGB(0xe44b50);
    }
    return self;
}

#pragma mark 添加控件
- (void)addUI{
    _tableView = [[UITableView alloc] initForAutoLayout];
    [self addSubview:_tableView];
    
    _typeTitleLabel = [[UILabel alloc] initForAutoLayout];
    [self addSubview:_typeTitleLabel];
    
    _backButton = [[UIButton alloc] initForAutoLayout];
    [self addSubview:_backButton];
}

#pragma mark 设置自动布局
- (void)setAutoLayout{
    [_typeTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_typeTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_typeTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_typeTitleLabel autoSetDimension:ALDimensionHeight toSize:40 * Balance_Heith];
//    _typeTitleLabel.layer.borderWidth = 1;
    _typeTitleLabel.textAlignment = NSTextAlignmentCenter;
    _typeTitleLabel.backgroundColor = [UIColor whiteColor];
    
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_typeTitleLabel withOffset:1];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:35 * Balance_Heith];
//    _tableView.layer.borderWidth = 1;
    
    [_backButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tableView withOffset:0];
    [_backButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_backButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_backButton autoSetDimension:ALDimensionHeight toSize:35 * Balance_Heith];
}

#pragma mark 设置控件的属性
- (void)setUIProperty{
    _typeTitleLabel.font = [UIFont systemFontOfSize:16];
}

#pragma mark 重写数据set方法
- (void)setArray:(NSArray *)array{
    _array = array;
}

- (void)setString:(NSString *)string{
    _typeTitleLabel.text = string;
}

@end
