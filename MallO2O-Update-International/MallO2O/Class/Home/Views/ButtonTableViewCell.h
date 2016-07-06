//
//  ButtonTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBtnView.h"
#import "HomeBtnModel.h"

@class ButtonTableViewCell;

typedef void(^ButtonClickBlock)(ButtonTableViewCell *cell,NSInteger index);

@protocol ButtonTableViewCellDelegate <NSObject>

@optional

- (void) buttonTableViewCell:(ButtonTableViewCell *)buttonTableViewCell didViewIndex:(NSInteger) index;

@end
//@class HomeBtnModel;

@interface ButtonTableViewCell : UITableViewCell

@property (strong ,nonatomic) HomeBtnView *buttonBackView;

+ (instancetype)buttonCellWithHomeTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index;

@property (strong ,nonatomic) HomeBtnModel *cateModel;

@property (strong ,nonatomic) NSMutableArray *cateArray;

@property (assign, nonatomic) id<ButtonTableViewCellDelegate> delegate;

@property (strong, nonatomic) ButtonClickBlock block;

- (void)clickButton:(ButtonClickBlock)block;

@end
