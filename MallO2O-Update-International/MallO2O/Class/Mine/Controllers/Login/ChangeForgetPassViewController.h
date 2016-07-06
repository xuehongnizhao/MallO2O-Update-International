//
//  ChangeForgetPassViewController.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface ChangeForgetPassViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *surePassText;
@property (weak, nonatomic) IBOutlet UIButton *surButton;
- (IBAction)sureButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *changeForgetView;

@end
