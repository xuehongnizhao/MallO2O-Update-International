//
//  MineCateTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MineCateTableViewCell.h"
#import "MineHeaderView.h"

@interface MineCateTableViewCell ()<MineHeaderViewDelegate>

@property (nonatomic ,strong) MineHeaderView *headerView;

@end

@implementation MineCateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self initUI];
    }
    return self;
}

- (void)initUI{
    NSArray *imgArray = _dic[@"img"];
    NSArray *textArray = _dic[@"text"];
    int index = [_dic[@"index"] intValue];
    for (int i = 0; i < [textArray count]; i ++) {
        MineHeaderView *headerView = [[MineHeaderView alloc] initForAutoLayout];
        [self.contentView addSubview:headerView];
        headerView.tag = 10 * index + i;
        
        headerView.delegate =self;
        headerView.imgView.image = [UIImage imageNamed:imgArray[i]];
        headerView.typeLabel.text = textArray[i];
        [headerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [headerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:i*SCREEN_WIDTH / textArray.count];
        [headerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [headerView autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / textArray.count];
        //        headerView.layer.borderWidth = 1;
    }
}

- (void)getIndex:(MineCateTabCellBlock )block{
    _block = block;
}

- (void)selectView:(NSInteger)index{
    self.block(index);
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];
        //删除并进行重新分配
    }
    [self initUI];
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cateCell"];
    if (!cell) {
        cell = [[MineCateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cateCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
