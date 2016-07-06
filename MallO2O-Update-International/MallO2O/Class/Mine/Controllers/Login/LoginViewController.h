//
//  LoginViewController.h
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface LoginViewController : MallO2OBaseViewController
@property (weak, nonatomic) IBOutlet UIView *textFieldView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *forgetPass;
@property (weak, nonatomic) IBOutlet UIButton *rememberPass;

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)rememberPass:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *remImgButton;
@property (weak, nonatomic) IBOutlet UIButton *qqLogin;
- (IBAction)qqLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wxLogin;
- (IBAction)wxLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sinaLogin;
- (IBAction)sinaLogin:(id)sender;
- (IBAction)forgetLayer:(id)sender;

@property (weak ,nonatomic) NSString *identifier;
- (void)thirdID:(NSString *)thirdId reg:(NSString *)regType;

@end
