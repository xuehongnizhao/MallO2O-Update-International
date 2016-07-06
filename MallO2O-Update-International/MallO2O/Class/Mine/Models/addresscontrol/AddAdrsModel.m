//
//  AddAdrsModel.m
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "AddAdrsModel.h"

@implementation AddAdrsModel

- (instancetype)init{
    if (self = [super init]) {
        _nameString = nil;
        _placeholderString = nil;
    }
    return self;
}

+ (instancetype)setModelData:(NSString *)typeStr andString:(NSString *)detailStr{
    AddAdrsModel *model = [[AddAdrsModel alloc] init];
    model.nameString = typeStr;
    model.placeholderString = detailStr;
    return model;
}

@end
