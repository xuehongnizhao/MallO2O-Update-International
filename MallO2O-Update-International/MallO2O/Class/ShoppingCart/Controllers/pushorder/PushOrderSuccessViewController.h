//
//  PushOrderSuccessViewController.h
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface PushOrderSuccessViewController : MallO2OBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *seeOrder;
- (IBAction)seeOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backMainView;
- (IBAction)backMainView:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pushSuccessMoney;

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *totalMoney;

@end
