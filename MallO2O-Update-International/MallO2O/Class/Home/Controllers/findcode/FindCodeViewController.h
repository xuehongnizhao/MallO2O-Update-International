//
//  FindCodeViewController.h
//  MallO2O
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@protocol FindCodeViewControllerDelegate <NSObject>

- (void)getFindCodeFVCCodeNum:(NSString *)string;

@end

@interface FindCodeViewController : MallO2OBaseViewController

@property (assign ,nonatomic) id<FindCodeViewControllerDelegate>delegate;

@end
