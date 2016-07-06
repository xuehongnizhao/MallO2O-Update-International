//
//  ForgetPassViewController.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface ForgetPassViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
- (IBAction)getCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *forgetView;

@end
