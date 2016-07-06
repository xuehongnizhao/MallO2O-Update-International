//
//  MapTableViewCell.h
//  MallO2O
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapButtonDelega <NSObject>

- (void)buttonClick:(UIButton *)button;

@end

@interface MapTableViewCell : UITableViewCell

+ (instancetype)mapTableViewCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellID;

@property (assign ,nonatomic) id<MapButtonDelega>delegate;

@end
