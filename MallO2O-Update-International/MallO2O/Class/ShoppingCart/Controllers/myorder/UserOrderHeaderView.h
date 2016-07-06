//
//  UserOrderHeaderView.h
//  WeiBang
//
//  Created by songweipng on 15/3/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//
//  微榜 ----  订单列表筛选订单的view   ---- view

#import <UIKit/UIKit.h>


@class UserOrderHeaderView;


/** 协议 */
@protocol UserOrderHeaderViewDelegate <NSObject>

@optional
/**
 *  UserOrderHeaderView 代理方法 选中按钮的代理方法
 *
 *  @param userOrderHeaderView
 *  @param button               点击的按钮
 */
- (void) userOrderHeaderView:(UserOrderHeaderView *)userOrderHeaderView selectedButton:(UIButton *)button;

@end

@interface UserOrderHeaderView : UIView


/** 代理属性 */
@property (assign, nonatomic) id<UserOrderHeaderViewDelegate> delegate;

@end
