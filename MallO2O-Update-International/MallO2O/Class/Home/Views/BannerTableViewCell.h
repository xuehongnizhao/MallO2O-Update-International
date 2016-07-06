//
//  BannerTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdBannerView.h"
#import "BannerImgModel.h"

@class BannerTableViewCell;

@protocol BannerTableViewCellDelegate <NSObject>

- (void)bannerTableViewCell:(BannerTableViewCell *)cell cellForRowAtIndex:(int)index;

@end

@interface BannerTableViewCell : UITableViewCell<AdBannerViewDelegate>

@property (strong ,nonatomic) AdBannerView *bannerView;

@property (strong ,nonatomic) NSArray *bannerImgArray;

@property (strong ,nonatomic) BannerImgModel *bannerModel;

@property (assign ,nonatomic) id<BannerTableViewCellDelegate>delegate;

+ (instancetype)buttonCellWithHomeTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index;

@end
