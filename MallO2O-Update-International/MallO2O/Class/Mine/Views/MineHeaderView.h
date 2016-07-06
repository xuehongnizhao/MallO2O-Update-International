//
//  MineHeaderView.h
//  MallO2O
//
//  Created by mac on 15/8/18.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeaderViewDelegate <NSObject>

- (void)selectView:(NSInteger)index;

@end

@interface MineHeaderView : UIView

@property (strong ,nonatomic) UIImageView *imgView;

@property (strong ,nonatomic) UILabel *typeLabel;

@property (assign ,nonatomic) id<MineHeaderViewDelegate>delegate;

@end
