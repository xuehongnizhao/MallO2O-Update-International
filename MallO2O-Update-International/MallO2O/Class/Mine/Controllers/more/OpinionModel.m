//
//  OpinionModel.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OpinionModel.h"

@implementation OpinionModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        if ([dic[@"feed_desc"] isKindOfClass:[NSNull class]]) {
            _opinionText = @"暂无评论";
        }else{
            _opinionText   = dic[@"feed_desc"];
        }
        _opinionStatus = dic[@"is_return"];
        _opinionTime   = dic[@"add_time" ];
        _opinionWebUrl = dic[@"message_url"];
    }
    return self;
}

@end
