//
//  SwpGuideModel.h
//  Swp_song
//
//  Created by songweiping on 15/8/13.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwpGuideModel : NSObject

/*! swpGuide引导页 图片          !*/
@property (copy  , nonatomic) NSString  *swpGuideImageName;
/*! swpGuide引导页 cell索引      !*/
@property (assign, nonatomic) NSInteger swpGuideIndex;
/*! swpGuide引导页 图片数组长度  !*/
@property (assign, nonatomic) NSInteger swpGuideCount;

@end
