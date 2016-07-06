//
//  UIView+SwpExtension.h
//  Swp_song
//
//  Created by songweiping on 15/12/28.
//  Copyright © 2015年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SwpExtension)

/*! x值       !*/
@property (nonatomic, assign) CGFloat x;
/*! y值       !*/
@property (nonatomic, assign) CGFloat y;
/*! 中心x     !*/
@property (nonatomic, assign) CGFloat centerX;
/*! 中心y     !*/
@property (nonatomic, assign) CGFloat centerY;
/*! 宽度      !*/
@property (nonatomic, assign) CGFloat width;
/*! 高度      !*/
@property (nonatomic, assign) CGFloat height;
/*! 宽高      !*/
@property (nonatomic, assign) CGSize  size;
/*! 起点 x, y !*/
@property (nonatomic, assign) CGPoint origin;

@end
