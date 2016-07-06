//
//  HomeImageUpTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeImgModel.h"

@class HomeImageUpTableViewCell;

@protocol HomeImageUpTableViewCellDelegate <NSObject>

- (void) homeImageUpTableViewCell:(HomeImageUpTableViewCell *)cell withIndex:(NSInteger)index;

@end

@interface HomeImageUpTableViewCell : UITableViewCell

@property (strong ,nonatomic) UIImageView *firImgView;

@property (strong ,nonatomic) UIImageView *secImgView;

@property (strong ,nonatomic) UIImageView *thirtImgView;

//==================添加图片之间的线//
@property (strong ,nonatomic) UIView *firGrayView;

@property (strong ,nonatomic) UIView *secGrayView;

@property (strong ,nonatomic) UIView *thirGrayView;
//添加图片之间的线==================//

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index;

@property (strong ,nonatomic) HomeImgModel *imgModel;

@property (strong ,nonatomic) NSMutableArray *array;

@property (assign ,nonatomic) id <HomeImageUpTableViewCellDelegate>delegate;

@end
