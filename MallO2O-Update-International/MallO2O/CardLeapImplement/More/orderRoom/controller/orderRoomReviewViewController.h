//
//  orderRoomReviewViewController.h
//  CardLeap
//
//  Created by mac on 15/1/21.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol orderRoomRefreshDelegate <NSObject>
-(void)orderRoomRefreshAction;
@end

@interface orderRoomReviewViewController : BaseViewController
@property (assign,nonatomic)id<orderRoomRefreshDelegate> delegate;
@property (strong,nonatomic)NSString *shop_id;
@property (strong,nonatomic)NSString *hotel_id;
@end
