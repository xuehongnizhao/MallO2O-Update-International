//
//  AddAdrsInforViewController.h
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"
#import <CoreLocation/CLLocationManager.h>

@class AddressControlModel;

@interface AddAdrsInforViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *naviTitle;

@property (strong ,nonatomic) AddressControlModel *addressModel;

@property (copy ,nonatomic) NSString *textFieldString;

@property (nonatomic) CLLocationCoordinate2D locationCoor;

@property (copy ,nonatomic) NSString *editLatitude;

@property (copy ,nonatomic) NSString *editLongitude;

@property (copy ,nonatomic) NSString *searchString;

@property (nonatomic) BOOL isEditStatus;

@end
