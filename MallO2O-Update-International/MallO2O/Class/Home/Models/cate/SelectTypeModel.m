//
//  SelectTypeModel.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SelectTypeModel.h"
#import "SelectSonModel.h"

@implementation SelectTypeModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _gcateSpecName = dic[@"gcate_spec_name"];
        _allText = NSLocalizedString(@"selectTypeAllTitle", nil);
        _sonArray = [[NSMutableArray alloc] init];
        //cate id
        _sonArray = [self arrayWithArray:dic[@"son"]];
    }
    return self;
}

- (NSMutableArray *)arrayWithArray:(NSMutableArray *)array{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        SelectSonModel *model = [SelectSonModel arrayWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
