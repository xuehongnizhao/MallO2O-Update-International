//
//  RechargeView.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/21.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RechargeViewDelegate <NSObject>

- (void)imageIsSelect:(BOOL)isSelect;

- (void)clickXieYi;

@end

@interface RechargeView : UIView

@property (assign ,nonatomic) id<RechargeViewDelegate>delegate;
@property (nonatomic) BOOL isExist;

@end
