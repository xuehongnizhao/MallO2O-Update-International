//
//  PersonInfoTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/1/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "PersonInfoTableViewCell.h"
#import "PersonInfoView.h"

@implementation PersonInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personInfoCell"];
    if (!cell) {
        cell = [[PersonInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setArray:(NSArray *)array{
    _array = array;
    while ([[self.contentView subviews] lastObject] != nil) {
        [(UIView*)[[self.contentView subviews] lastObject]  removeFromSuperview];
        //删除并进行重新分配
    }
    [self initUI];
}

- (void)initUI{
    for (int i = 0; i < _array.count; i ++) {
        PersonInfoView *view = [[PersonInfoView alloc] initForAutoLayout];
        [self.contentView addSubview:view];
        if (i > 0) {
            UIView *xian = [[UIView alloc] initForAutoLayout];
            [self.contentView addSubview:xian];
            [xian autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH/3 * i, 0, 0) excludingEdge:ALEdgeRight];
            [xian autoSetDimension:ALDimensionWidth toSize:0.6];
            xian.backgroundColor = UIColorFromRGB(0xe3e3e3);
        }
        [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 3 * i, 0, 0) excludingEdge:ALEdgeRight];
        [view autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/3];
        view.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:gesture];
        view.dic = _array[i];
    }
}

- (void)getIndex:(PersonInfoBlock)block{
    _block = block;
}

- (void)clickView:(UITapGestureRecognizer *)gesture{
    if ([self block]) {
        self.block(gesture.view.tag);
    }
}

@end
