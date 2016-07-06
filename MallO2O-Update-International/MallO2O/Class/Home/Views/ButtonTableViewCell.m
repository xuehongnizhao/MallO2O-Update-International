//
//  ButtonTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ButtonTableViewCell.h"


@implementation ButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark 自定义方法
+ (instancetype)buttonCellWithHomeTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index{
    static NSString *identifier = @"ButtonCell";
    ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.layer.borderWidth = 0.6;
    cell.layer.borderColor = [UIColorFromRGB(0xd9d9d9) CGColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

#pragma mark 添加cell里的控件
- (void)addUI{
    //移除上一个视图的iamgeview
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];
        //删除并进行重新分配
    }
    
    for (int i = 0; i < _cateArray.count; i ++) {
        _buttonBackView = [[HomeBtnView alloc] initForAutoLayout];
        [self.contentView addSubview:_buttonBackView];
        _cateModel = _cateArray[i];
//        [_buttonBackView.homeBtnImgView sd_setImageWithURL:[NSURL URLWithString:_cateModel.cateImgUrl]];
        _buttonBackView.imgUrl = _cateModel.cateImgUrl;
        _buttonBackView.cateImgLabel.text = _cateModel.cateName;
        [self setAutoLayout:i];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        _buttonBackView.userInteractionEnabled = YES;
        [_buttonBackView addGestureRecognizer:gesture];
        [_buttonBackView setTag:i + 1];
    }
}

#pragma mark  自动布局
- (void)setAutoLayout:(int)i{
    if (i < 5) {
        /*
            第一层的view和image
         */
        [_buttonBackView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SCREEN_WIDTH/5*i];
        [_buttonBackView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [_buttonBackView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/5];
        [_buttonBackView autoSetDimension:ALDimensionHeight toSize:80.0f * Balance_Heith];
    }
    if (i >= 5) {
        /*
         第二层的view和image
         */
        [_buttonBackView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SCREEN_WIDTH/5*(i - 5)];
        [_buttonBackView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:71.75f * Balance_Heith];
        [_buttonBackView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/5];
        [_buttonBackView autoSetDimension:ALDimensionHeight toSize:80.0f * Balance_Heith];
    }
    NSLog(@"%d",i);
}

- (void)clickButton:(ButtonClickBlock)block{
    self.block = block;
}

/**
 数组的set方法 给控件赋值
 */
- (void)setCateArray:(NSMutableArray *)cateArray{
    _cateArray = cateArray;
    [self addUI];
}

- (void)  click:(UITapGestureRecognizer *)tag {
//    if ([self.delegate respondsToSelector:@selector(buttonTableViewCell:didViewIndex:)]) {
//        [self.delegate buttonTableViewCell:self didViewIndex:tag.view.tag];
//    }
//    __weak typeof(ButtonTableViewCell) *cell = self;
    if (self.block != nil) {
        self.block(self,tag.view.tag);
    }
}



@end
