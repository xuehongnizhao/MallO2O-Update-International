//
//  RechargeSuccessViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface RechargeSuccessViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *payMoney;
- (IBAction)rechargeHistory:(id)sender;
- (IBAction)backToHome:(id)sender;

@property (copy ,nonatomic) NSString *payMoneyText;
@property (copy ,nonatomic) NSString *successType;

@end
