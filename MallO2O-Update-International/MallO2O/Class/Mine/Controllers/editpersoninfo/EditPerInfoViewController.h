//
//  EditPerInfoViewController.h
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"
#import "PerInfoModel.h"

@protocol EditPerInfoViewControllerDelegate <NSObject>

- (void)pushImgName:(NSString *)imgName;

@end

@interface EditPerInfoViewController : MallO2OBaseViewController

@end
