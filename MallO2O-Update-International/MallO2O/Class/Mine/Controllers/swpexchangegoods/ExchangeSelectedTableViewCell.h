//
//  ExchangeSelectedTableViewCell.h
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeSelectedTableViewCell;
@class ExchangeModel;


@protocol ExchangeSelectedTableViewCellDelegate <NSObject>

- (void)exchangeSelectedTableViewCell:(ExchangeSelectedTableViewCell *)exchangeSelectedTableViewCell cellForRowAtIndexPath:(NSIndexPath *)indexPath dataModel:(ExchangeModel *)exchange didAddAndSubtractButton:(UIButton *)button buttonIndex:(NSInteger)index;

@end


@interface ExchangeSelectedTableViewCell : UITableViewCell

+ (instancetype) exchangeSelectedCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) id<ExchangeSelectedTableViewCellDelegate> delegate;
@property (strong, nonatomic) ExchangeModel *exchange;

@end
