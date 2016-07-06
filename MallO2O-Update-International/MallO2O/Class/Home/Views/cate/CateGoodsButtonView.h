//
//  CateGoodsButtonView.h
//  MallO2O
//
//  Created by zhiyuan gao on 15/11/18.
//  Copyright © 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CateGoodsButtonViewDelegate <NSObject>

- (void)touchButtonAtIndex:(NSInteger)index;

@end

@interface CateGoodsButtonView : UIView

@property (copy ,nonatomic) NSArray *buttonTextArray;

@property (assign ,nonatomic) id<CateGoodsButtonViewDelegate>delegate;

@end
