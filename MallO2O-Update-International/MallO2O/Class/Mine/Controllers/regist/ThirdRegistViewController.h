//
//  ThirdRegistViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface ThirdRegistViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UIView *textViews;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
- (IBAction)registButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registButton;

@property (copy ,nonatomic) NSString *regType;
@property (copy ,nonatomic) NSString *thirdID;
@property (copy ,nonatomic) NSString *naviTitle;

@end
