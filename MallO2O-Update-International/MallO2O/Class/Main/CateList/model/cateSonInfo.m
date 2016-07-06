//
//  cateSonInfo.m
//  CardLeap
//
//  Created by lin on 12/26/14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "cateSonInfo.h"

@implementation cateSonInfo
@synthesize cate_son_name = _cate_son_name;
@synthesize cate_son_id = _cate_son_id;

-(id)initWithDictionary :(NSDictionary*)dic
{
    if (!self) {
        self = [[cateSonInfo alloc] init];
    }
    _cate_son_id =  [NSString stringWithFormat:@"%@",dic[@"cate_id"]];
    _cate_son_name =  [NSString stringWithFormat:@"%@",dic[@"cate_name"]];
    if (_cate_son_name == nil ||  [_cate_son_name isEqualToString:@"(null)"] || _cate_son_name.length == 0) {
        _cate_son_id =  [NSString stringWithFormat:@"%@",dic[@"district_id"]];
        _cate_son_name =  [NSString stringWithFormat:@"%@",dic[@"district_name"]];
        if (_cate_son_name==nil || [_cate_son_name isEqualToString:@"(null)"] || _cate_son_name.length == 0) {
            _cate_son_name = [NSString stringWithFormat:@"%@",dic[@"shop_cate_name"]];
            _cate_son_id = [NSString stringWithFormat:@"%@",dic[@"shop_cate_id"]];
        }
    }
    return self;
}
@end
