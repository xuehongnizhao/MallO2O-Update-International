//
//  MessageModel.m
//  MallO2O
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _message_addtime = dic[@"add_time"];
        _message_content = dic[@"little_content"];
        _message_name = dic[@"message_name"];
        _message_url = dic[@"message_url"];
    }
    return self;
}

@end
