//
//  RegistViewController.h
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface RegistViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *telNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
- (IBAction)codeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
- (IBAction)registButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *registTextView;

@property (copy ,nonatomic) NSString *regType;
@property (copy ,nonatomic) NSString *thirdID;
@property (copy ,nonatomic) NSString *naviTitle;

@end
