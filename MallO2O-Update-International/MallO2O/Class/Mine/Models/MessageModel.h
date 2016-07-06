//
//  MessageModel.h
//  MallO2O
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (copy ,nonatomic) NSString *message_name;

@property (copy ,nonatomic) NSString *message_content;

@property (copy ,nonatomic) NSString *message_url;

@property (copy ,nonatomic) NSString *message_addtime;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
