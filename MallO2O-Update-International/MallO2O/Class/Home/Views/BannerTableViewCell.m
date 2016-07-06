//
//  BannerTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "BannerTableViewCell.h"

@implementation BannerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark 重写cell的初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self setBannerViewImgArray:_bannerImgArray];
}

- (void)setBannerViewImgArray:(NSArray *)array{
    //移除上一个视图的iamgeview
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];  //删除并进行重新分配
    }
    
    CGRect rect   = [[UIScreen mainScreen] bounds];
    CGRect frame  = CGRectMake(0, 0, rect.size.width, self.contentView.frame.size.height);
    NSMutableArray *adImageArray = [NSMutableArray array];
    NSMutableArray *adNameArray  = [NSMutableArray array];
    
    for(int i=0; i<array.count; i++) {
        //添加图片数组
        UIImageView    *imageView = [[UIImageView alloc] init];
        _bannerModel = [[BannerImgModel alloc] init];
        self.bannerModel = array[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.bannerModel.bannerImgUrl] placeholderImage:nil];
        [adImageArray addObject:imageView];
    }
    self.bannerView  = [[AdBannerView alloc] initWithFrame:frame Delegate:self andImageViewArray:adImageArray andNameArray:adNameArray];
    [self.contentView addSubview:_bannerView];
}


#pragma mark 自定义方法
+ (instancetype)buttonCellWithHomeTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index{
    static NSString *identifier = @"BannerCell";
    BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

/**
 数据的set方法
 */
- (void)setBannerImgArray:(NSArray *)bannerImgArray{
    _bannerImgArray = bannerImgArray;
    [self addUI];
}

/**
 banner的点击事件 内部封存自己的委托
 */
- (void)adBannerView:(AdBannerView *)adBannerView itemIndex:(int)index{
    if ([self.delegate respondsToSelector:@selector(bannerTableViewCell:cellForRowAtIndex:)]) {
        [self.delegate bannerTableViewCell:self cellForRowAtIndex:index];
    }
}

@end
