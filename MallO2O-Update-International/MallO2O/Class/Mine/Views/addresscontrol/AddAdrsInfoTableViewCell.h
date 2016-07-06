//
//  AddAdrsInfoTableViewCell.h
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAdrsModel.h"

#import "AddAdrsCellView.h"

@interface AddAdrsInfoTableViewCell : UITableViewCell

+ (instancetype)addAdrsCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellId;

@property (strong ,nonatomic) AddAdrsModel *addAdrsModel;

@property (strong ,nonatomic) AddAdrsModel *addAdrsInfoModel;

@property (nonatomic) BOOL isEditModel;

@property (strong ,nonatomic) AddAdrsCellView *cellView;;

@end
