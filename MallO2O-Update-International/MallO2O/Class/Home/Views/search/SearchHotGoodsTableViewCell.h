//
//  SearchHotGoodsTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/2/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHotCell)(NSDictionary *cateDic);
@interface SearchHotGoodsTableViewCell : UITableViewCell

@property (copy ,nonatomic) NSArray *dataArray;

@property (strong ,nonatomic) ClickHotCell block;

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withCellId:(NSString *)cellIdentifier;

- (void)clickCell:(ClickHotCell)block;

@end
