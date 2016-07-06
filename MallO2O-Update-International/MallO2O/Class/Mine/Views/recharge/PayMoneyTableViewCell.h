//
//  PayMoneyTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMoneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *getMoneyLabel;

@end
