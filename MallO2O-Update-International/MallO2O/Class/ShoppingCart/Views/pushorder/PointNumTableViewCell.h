//
//  PointNumTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/18.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointNumTableViewCell.h"

@protocol PointNumTableViewCellDelegate <NSObject>

- (void)textString:(NSString *)text atIndexPath:(NSIndexPath *)index  inTextField:(UITextField *)textField;

@end

@interface PointNumTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index;

@property (assign ,nonatomic) id<PointNumTableViewCellDelegate>delegate;

@property (strong ,nonatomic) NSIndexPath *selectIndex;

@property (strong ,nonatomic) NSString *pointString;

@end
