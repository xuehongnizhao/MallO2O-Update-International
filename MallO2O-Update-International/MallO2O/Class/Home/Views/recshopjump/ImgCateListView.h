//
//  ImgCateListView.h
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgCateListView : UIView

@property (copy ,nonatomic) NSString *imgUrl;

@property (copy ,nonatomic) NSString *shopNameText;

@property (copy ,nonatomic) NSString *shopAddressText;
/** 距离 */
@property (nonatomic, strong) NSString *distance;

@end
