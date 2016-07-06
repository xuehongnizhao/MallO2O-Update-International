//
//  TheSearchBox.h
//  ZhongWeiAliance
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//
//  中位 -----> 搜索框View


#import <UIKit/UIKit.h>

@protocol SearchBoxDelegate <NSObject>

@required
/**
 *  开始搜索
 *
 *  @param string 搜索文字
 */
- (void) SearchWithString:(NSString *)string;
@optional
/**
 *  取消搜索
 */
- (void) ClearSearch;
@end



@interface TheSearchBox : UIView

/** 提示文字 */
@property (nonatomic, strong) NSString * tips;//搜索车牌号
/** 搜索放大镜图标 */
@property (nonatomic, strong) UIImage  * searchImage;
/** 搜索代理 */
@property (nonatomic, strong) id<SearchBoxDelegate> searchDelegate;
@end
