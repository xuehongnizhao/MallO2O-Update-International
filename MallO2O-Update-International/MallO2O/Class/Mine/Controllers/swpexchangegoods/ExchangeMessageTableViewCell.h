//
//  ExchangeMessageTableViewCell.h
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeModel;

@interface ExchangeMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *exchangeDescView;


+ (instancetype) exchangeMessageCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSIndexPath   *indexPath;
@property (strong, nonatomic) ExchangeModel *exchange;


@end
