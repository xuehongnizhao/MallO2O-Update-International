//
//  ShareView.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareViewBlock)(NSInteger shareNumber);

@interface ShareView : UIView

@property (copy ,nonatomic) NSArray *imageArray;

@property (copy ,nonatomic) NSArray *shareName;

@property (copy ,nonatomic) ShareViewBlock block;

- (void)clickShareImg:(ShareViewBlock)block;

@end
