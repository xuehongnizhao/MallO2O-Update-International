//
//  UserModel.m
//  PersonInfo
//
//  Created by Sky on 14-8-9.
//  Copyright (c) 2014年 com.youdro. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(UserModel *)shareInstance
{
    static UserModel* user=nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        user =[[self alloc]init];
       
    });
    return user;
}

@end
