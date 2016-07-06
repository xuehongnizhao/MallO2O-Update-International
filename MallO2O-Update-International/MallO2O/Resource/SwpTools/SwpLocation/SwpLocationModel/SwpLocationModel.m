//
//  SwpLocationModel.m
//  Swp_song
//
//  Created by songweiping on 15/8/6.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SwpLocationModel.h"

@implementation SwpLocationModel


/*!
 *  重写初始化方法 赋 默认值
 *
 *  @return SwpLocationModel
 */
- (instancetype)init {
    
    if (self = [super init]) {
        self.name               = @"";
        self.country            = @"";
        self.administrativeArea = @"";
        self.locality           = @"";
        self.subLocality        = @"";
        self.thoroughfare       = @"";
        self.subThoroughfare    = @"";
    }
    return self;
}

@end
