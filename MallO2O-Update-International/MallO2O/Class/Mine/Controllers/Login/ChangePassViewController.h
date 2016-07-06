//
//  ChangePassViewController.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface ChangePassViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *inputNewPass;
@property (weak, nonatomic) IBOutlet UITextField *surPassword;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
- (IBAction)changeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *passBackView;

@end
