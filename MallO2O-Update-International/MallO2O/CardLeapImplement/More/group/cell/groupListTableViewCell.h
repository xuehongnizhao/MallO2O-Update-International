//
//  groupListTableViewCell.h
//  CardLeap
//
//  Created by mac on 15/1/23.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupInfo.h"

@interface groupListTableViewCell : UITableViewCell
-(void)confirgureCell:(groupInfo*)info;
@end