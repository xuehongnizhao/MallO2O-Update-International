//
//  MapShopTurnView.h
//  MallO2O
//
//  Created by mac on 9/21/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

//#import <BaiduMapAPI/BMapKit.h>
#import "HomeListModel.h"
#import <BaiduMapAPI_Map/BMKOverlayView.h>

@protocol MapShopTurnViewDelegate <NSObject>

- (void)clickMapShopToTurnView:(NSInteger)index;

@end

@interface MapShopTurnView : BMKOverlayView

@property (copy ,nonatomic) HomeListModel *model;

@property (strong ,nonatomic) id<MapShopTurnViewDelegate>delegate;

@end
