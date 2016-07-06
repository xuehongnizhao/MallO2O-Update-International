//
//  MapTableViewCell.m
//  MallO2O
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MapTableViewCell.h"

@interface MapTableViewCell ()

/** 定位按钮 */
@property (nonatomic, strong) UIButton *positioningBtn;
/** 定位图片 */
@property (nonatomic, strong) UIImageView *positioningImg;



@end

@implementation MapTableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addUI];
        [self AutoLayout];
        
    }
    return self;
}


+ (instancetype)mapTableViewCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellID{
    static NSString *mapCell = @"mapCell";
    MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapCell];
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    if (!cell) {
        cell = [[MapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mapCell];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.positioningBtn.hidden = NO;
            cell.positioningImg.hidden = NO;
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (void)AutoLayout{
    [self.positioningBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.positioningBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.positioningBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];
    [self.positioningBtn autoSetDimension:ALDimensionWidth toSize:60];
    
    
    [self.positioningImg autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.positioningBtn withOffset:- 3];
    [self.positioningImg autoSetDimension:ALDimensionWidth toSize:12];
    [self.positioningImg autoSetDimension:ALDimensionHeight toSize:12];
    [self.positioningImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
}

- (void)addUI{
    [self.contentView addSubview:self.positioningBtn];
    [self.contentView addSubview:self.positioningImg];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)mapClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(buttonClick:)]) {
        [self.delegate buttonClick:button];
    }

}


- (UIButton *)positioningBtn{
    if (!_positioningBtn) {
        _positioningBtn = [[UIButton alloc] initForAutoLayout];
        [_positioningBtn setTitle:@"重新定位" forState:UIControlStateNormal];
        [_positioningBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _positioningBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _positioningBtn.hidden = YES;
        [_positioningBtn addTarget:self action:@selector(mapClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _positioningBtn;
}


- (UIImageView *)positioningImg{
    if (!_positioningImg) {
        _positioningImg = [[UIImageView alloc] initForAutoLayout];
        [_positioningImg setImage:[UIImage imageNamed:@"location"]];
        _positioningImg.hidden = YES;
        
    }
    return _positioningImg;
}

@end
