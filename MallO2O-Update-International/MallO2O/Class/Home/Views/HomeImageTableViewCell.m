//
//  HomeImageTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "HomeImageTableViewCell.h"

@implementation HomeImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark 自定义的cell方法
+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index{
    static NSString *identifier = @"ImgCell";
    HomeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

#pragma mark cell的初始化方法重写
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

/**
 给cell内添加图片
 */
- (void)addUI{
    
    //移除上一个视图的iamgeview
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];
        //删除并进行重新分配
    }
    
    _firImgView = [[UIImageView alloc] initForAutoLayout];
    _firImgView.tag = 1;
    [self.contentView addSubview:_firImgView];
    
    _secImgView = [[UIImageView alloc] initForAutoLayout];
    _secImgView.tag = 2;
    [self.contentView addSubview:_secImgView];
    
    _thirtImgView = [[UIImageView alloc] initForAutoLayout];
    _thirtImgView.tag = 3;
    [self.contentView addSubview:_thirtImgView];
    
    _firGrayView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:_firGrayView];
    
    _secGrayView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:_secGrayView];
    
    _thirGrayView = [[UIView alloc] initForAutoLayout];
    [self.contentView addSubview:_thirGrayView];
    
    NSArray *array = @[_firImgView,_secImgView,_thirtImgView];
    
    for (UIImageView *image in array) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg:)];
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:gesture];
    }

    for (int i = 0; i < _array.count; i ++) {
         _imgModel = _array[i];
        switch (i) {
            case 0:
                [_firImgView sd_setImageWithURL:[NSURL URLWithString:_imgModel.imgUrl]];
                break;
            case 1:
                [_secImgView sd_setImageWithURL:[NSURL URLWithString:_imgModel.imgUrl]];
                break;
            case 2:
                [_thirtImgView sd_setImageWithURL:[NSURL URLWithString:_imgModel.imgUrl]];
                break;
            default:
                break;
        }
    }
    [self setAutoLayout];
}

/**
 控件自动布局
 */
- (void)setAutoLayout{
    [_firImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [_firImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_firImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [_firImgView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2 - 16];
    
    [_secImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
//    [_secImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
//    [_secImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_secImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_secImgView autoSetDimension:ALDimensionHeight toSize:(SCREEN_WIDTH/2 - 16) / 2];
//    [_secImgView autoSetDimension:ALDimensionHeight toSize:80 * Balance_Heith - 16];
    [_secImgView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2 - 16];
    
    [_thirtImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
//    [_thirtImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [_thirtImgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
//    [_thirtImgView autoSetDimension:ALDimensionHeight toSize:80 * Balance_Heith - 16];
    [_thirtImgView autoSetDimension:ALDimensionHeight toSize:(SCREEN_WIDTH/2 - 16) / 2];
    [_thirtImgView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2 - 16];
    
    [_firGrayView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_firGrayView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_firGrayView autoSetDimension:ALDimensionWidth toSize:0.3f];
    [_firGrayView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SCREEN_WIDTH/2];
    _firGrayView.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    [_secGrayView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80 * Balance_Heith];
    [_secGrayView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_secGrayView autoSetDimension:ALDimensionHeight toSize:0.5f];
    [_secGrayView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_firGrayView withOffset:0];
    _secGrayView.backgroundColor = UIColorFromRGB(0xe1e1e1);
}

/**
 数据的set方法
 */
- (void)setArray:(NSMutableArray *)array{
    _array = array;
    
    [self addUI];
}

/**
 点击图片的方法 内部封存委托
 */
- (void)clickImg:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(homeImageTableViewCell:withIndex:)]) {
        [self.delegate homeImageTableViewCell:self withIndex:gesture.view.tag];
    }
}

@end
