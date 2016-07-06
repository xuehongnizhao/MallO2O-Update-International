//
//  UserOrderHeaderView.m
//  WeiBang
//
//  Created by songweipng on 15/3/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "UserOrderHeaderView.h"

#define IMAGEVIEW_PADDING   10.0
#define PADDING             1.0
#define IMAGEVIEW_WIDTH     1.0
#define TIME                0.3
#define BUTTON_WIDTH (SCREEN_WIDTH - (PADDING * 2 + IMAGEVIEW_WIDTH) * 3) / 4.0

@interface UserOrderHeaderView ()

// ---------------------- UI 控件 ----------------------
/** 显示订单筛选全部按钮 */
@property (strong, nonatomic) UIButton *orderButton1;
/** 显示订单筛选已消费按钮 */
@property (strong, nonatomic) UIButton *orderButton2;
/** 显示订单筛选待消费按钮 */
@property (strong, nonatomic) UIButton *orderButton3;
/** 显示订单筛选已取消按钮 */
@property (strong, nonatomic) UIButton *orderButton4;
/** 设置选中按钮 */
@property (strong, nonatomic) UIButton *selectButton;

/** 按中的分割线 */
@property (strong, nonatomic) UIImageView *orderImageView1;
/** 按中的分割线 */
@property (strong, nonatomic) UIImageView *orderImageView2;
/** 按中的分割线 */
@property (strong, nonatomic) UIImageView *orderImageView3;
/** 按钮底部滑动的线 */
@property (strong, nonatomic) UIImageView *orderImageView4;


@end

@implementation UserOrderHeaderView


/**
 *  重写 自定义view色 frame 方法添加控件 和 设置控件的位置
 *
 *  @param  frame
 *
 *  @return UserOrderHeaderView
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingUIAutoLayout];
        
        // 默认选中第一个按钮
        [self clickButton:self.orderButton1];
    }
    return self;
}


/**
 *  添加控件
 */
- (void) addUI {
    
    [self addSubview:self.orderButton1];
    [self addSubview:self.orderButton2];
    [self addSubview:self.orderButton3];
    [self addSubview:self.orderButton4];
    [self addSubview:self.orderImageView1];
    [self addSubview:self.orderImageView2];
    [self addSubview:self.orderImageView3];
    [self addSubview:self.orderImageView4];
    
}


/**
 *  设置控件的 布局
 */
- (void) settingUIAutoLayout {
    
    [self.orderButton1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.orderButton1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.orderButton1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.orderButton1 autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2];
    
    

    [self.orderImageView1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:IMAGEVIEW_PADDING];
    [self.orderImageView1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:IMAGEVIEW_PADDING];
    [self.orderImageView1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.orderButton1 withOffset:PADDING];
    [self.orderImageView1 autoSetDimension:ALDimensionWidth toSize:IMAGEVIEW_WIDTH];
    
    
    [self.orderButton2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.orderButton2 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.orderButton2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.orderImageView1 withOffset:PADDING];
    [self.orderButton2 autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2];

    [self.orderImageView2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:IMAGEVIEW_PADDING];
    [self.orderImageView2 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:IMAGEVIEW_PADDING];
    [self.orderImageView2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.orderButton2 withOffset:PADDING];
    [self.orderImageView2 autoSetDimension:ALDimensionWidth toSize:IMAGEVIEW_WIDTH];
    

}



/**
 *  设置 按钮的一些 公共属性
 *
 *  @param button    需要设置的按钮
 *  @param title     按钮显示的文字
 *  @param buttonTag 绑定按钮的Tag值
 */
- (void) settingButtionProperty:(UIButton *)button setTitle:(NSString *)title buttonTag:(NSInteger)buttonTag {

    button.tag  = buttonTag;
//    button.layer.borderWidth = 1;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_SIZE(14);
    [button setTitleColor:Color(174, 174, 174, 255) forState:UIControlStateNormal];
    [button setTitleColor:Color(227, 72, 79, 25) forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

}

/**
 *  设置 imageView 的一些公共属性
 *
 *  @param imageView 需要的Image
 */
- (void) settingImageView:(UIImageView *)imageView {
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = Color(174, 174, 174, 255).CGColor;
}



/**
 *  按钮绑定时间
 *
 *  @param button
 */
- (void) clickButton:(UIButton *)button  {
    
    // 1.取消当前选中的按钮 的选中状态
    self.selectButton.selected = NO;
    
    // 2.设置点击的按钮 设置选中
    button.selected     = YES;
    
    // 3.选中按钮 赋值 给取消选中按钮
    self.selectButton   = button;
    
    
    // 点击调用代理方法
    if ([self.delegate respondsToSelector:@selector(userOrderHeaderView:selectedButton:)]) {
        [self.delegate userOrderHeaderView:self selectedButton:button];
    }
    
    
    // 计算移动的 imageView 的frame
    CGRect  rect        = self.orderImageView4.frame;
    CGFloat imageView4H = SCREEN_WIDTH / 2.0;
    rect.size.width     = imageView4H;
    if (button.tag == 0) {
        rect.origin.x = 0;
        [self settingImageViewAnimation:rect];
    }
    
    if (button.tag == 1) {
        rect.origin.x   = imageView4H;
        [self settingImageViewAnimation:rect];
    }
}

/**
 *  imageView 移动动画方法
 *
 *  @param rect 移动的frame
 */
- (void) settingImageViewAnimation:(CGRect)rect {

    [UIImageView animateWithDuration:TIME animations:^{
        self.orderImageView4.frame  = rect;
    }];
}


#pragma mark ----- UI控件初始化
- (UIButton *)orderButton1 {
    if (!_orderButton1) {
        _orderButton1 = [[UIButton alloc] initForAutoLayout];

        [self settingButtionProperty:_orderButton1 setTitle:@"全部" buttonTag:0];
    }
    return _orderButton1;
}


- (UIButton *)orderButton2 {
    if (!_orderButton2) {
        
        _orderButton2 = [[UIButton alloc] initForAutoLayout];
        [self settingButtionProperty:_orderButton2 setTitle:@"已消费" buttonTag:1];
    }
    return _orderButton2;
}

- (UIImageView *)orderImageView1 {
    
    if (!_orderImageView1) {
        _orderImageView1 = [[UIImageView alloc] initForAutoLayout];
        [self settingImageView:_orderImageView1];
    }
    return _orderImageView1;
}

- (UIImageView *)orderImageView2 {
    if (!_orderImageView2) {
        _orderImageView2 = [[UIImageView alloc] initForAutoLayout];
        [self settingImageView:_orderImageView2];
        
    }
    return _orderImageView2;
}

- (UIImageView *)orderImageView3 {
    if (!_orderImageView3) {
        _orderImageView3 = [[UIImageView alloc] initForAutoLayout];
        [self settingImageView:_orderImageView3];
    }
    return _orderImageView3;
}

- (UIImageView *)orderImageView4 {
    
    if (!_orderImageView4) {
        _orderImageView4 = [[UIImageView alloc] init];
        _orderImageView4.frame             = CGRectMake(0, 38, SCREEN_WIDTH/2, 2);
        _orderImageView4.layer.borderWidth = 1;
        _orderImageView4.layer.borderColor = Color(227, 72, 79, 25).CGColor;
    }
    return _orderImageView4;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
