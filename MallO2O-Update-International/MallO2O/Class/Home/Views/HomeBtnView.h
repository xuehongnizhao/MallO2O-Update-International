//
//  HomeBtnView.h
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBtnModel.h"

@interface HomeBtnView : UIView

@property (strong ,nonatomic) UIView *btnBackView;

@property (strong ,nonatomic) UIImageView *homeBtnImgView;

@property (strong ,nonatomic) UILabel *cateImgLabel;

@property (copy ,nonatomic) NSString *imgUrl;

@end
