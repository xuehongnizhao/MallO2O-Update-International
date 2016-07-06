//
//  AddAdrsInfoTableViewCell.m
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "AddAdrsInfoTableViewCell.h"

@interface AddAdrsInfoTableViewCell ()

@end

@implementation AddAdrsInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)addAdrsCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellID:(NSString *)cellId{
    AddAdrsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[AddAdrsInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 1) {
        cell.cellView.inputTextField.userInteractionEnabled = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [UZCommonMethod hiddleExtendCellFromTableview:tableView];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.cellView];
}

- (void)settingAutoLayout{
    [_cellView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setAddAdrsModel:(AddAdrsModel *)addAdrsModel{
    _addAdrsModel = addAdrsModel;
    [self settingData];
}

- (void)setAddAdrsInfoModel:(AddAdrsModel *)addAdrsInfoModel{
    _addAdrsInfoModel = addAdrsInfoModel;
    if (addAdrsInfoModel != nil) {
        [self settingInfoData];
    }
}

- (void)settingInfoData{
    _cellView.nameLabel.text = _addAdrsInfoModel.nameString;
    _cellView.inputTextField.text = _addAdrsInfoModel.placeholderString;
}

- (void)settingData{
    _cellView.nameLabel.text = _addAdrsModel.nameString;
    _cellView.inputTextField.placeholder = _addAdrsModel.placeholderString;
}

- (AddAdrsCellView *)cellView{
    if (!_cellView) {
        _cellView = [[AddAdrsCellView alloc] initForAutoLayout];
    }
    return _cellView;
}

@end
