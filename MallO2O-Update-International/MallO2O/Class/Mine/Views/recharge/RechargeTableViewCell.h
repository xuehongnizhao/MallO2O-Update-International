//
//  RechargeTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/20.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RechargeModel;

@interface RechargeTableViewCell : UITableViewCell

+ (instancetype)rechargeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)identifier;

- (void)selectImage:(BOOL)selecImage;

@property (copy ,nonatomic) RechargeModel *model;

@end
