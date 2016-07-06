//
//  NaviSearchView.h
//  MallO2O
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NaviSearchViewDelegate <NSObject>

- (void)clickNaviSearchView;

@end

@interface NaviSearchView : UIView

@property (strong ,nonatomic) NSString *textLabelString;

@property (copy ,nonatomic) UIColor *textColor;

@property (copy ,nonatomic) UIColor *backGroudColor;

@property (nonatomic) NSInteger cornerRadius;

@property (copy ,nonatomic) NSString *shopCarImageName;

@property (assign ,nonatomic) CGSize imageSize;

@property (copy ,nonatomic) UIColor *textLabelColor;

@property (assign ,nonatomic) id<NaviSearchViewDelegate>delegate;

@end
