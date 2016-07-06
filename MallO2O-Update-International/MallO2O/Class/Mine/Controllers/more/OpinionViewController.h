//
//  OpinionViewController.h
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface OpinionViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UITextView *opinionTextView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

- (IBAction)sureButton:(id)sender;

@end
