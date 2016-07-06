//
//  AddAdrsModel.h
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddAdrsModel : NSObject

@property (copy ,nonatomic) NSString *nameString;

@property (copy ,nonatomic) NSString *placeholderString;

+ (instancetype)setModelData:(NSString *)typeStr andString:(NSString *)detailStr;

@end
