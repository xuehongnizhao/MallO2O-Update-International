//
//  GroupSearchViewController.h
//  CardLeap
//
//  Created by mac on 15/2/11.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SEARCH_GROUP_POST ALL_URL(@"group_list")

/**
 *  该类为搜索类 拥有记忆历史输入功能还搜索帖子功能
 */
@interface GroupSearchViewController : BaseViewController
@property(nonatomic,copy) NSString *u_lng;
@property(nonatomic,copy) NSString *u_lat;
@end