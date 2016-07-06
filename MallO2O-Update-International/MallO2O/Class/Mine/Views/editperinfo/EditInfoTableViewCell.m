//
//  EditInfoTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "EditInfoTableViewCell.h"

@interface EditInfoTableViewCell ()<UITextFieldDelegate>



@property (strong ,nonatomic) UILabel *typeLabel;

@property (strong ,nonatomic) UITextField *infoTextField;

@end

@implementation EditInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index{
    static NSString *identifier = @"editInfoCell";
    EditInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EditInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 15);
    if (index.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = index;
    [cell addUI:index];
    return cell;
}

- (void)addUI:(NSIndexPath *)index{
    _headImgView = [[UIImageView alloc] initForAutoLayout];
    [self.contentView addSubview:_headImgView];
    
    _typeLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_typeLabel];
    
    _infoTextField = [[UITextField alloc] initForAutoLayout];
    [self.contentView addSubview:_infoTextField];
    
    [self settingAutoLayout:index];
}

- (void)settingAutoLayout:(NSIndexPath *)index{
    [_typeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_typeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_typeLabel autoSetDimension:ALDimensionWidth toSize:50];
    [_typeLabel autoSetDimension:ALDimensionHeight toSize:20];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    if (index.row == 0) {
        [_headImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [_headImgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_headImgView autoSetDimension:ALDimensionHeight toSize:35];
        [_headImgView autoSetDimension:ALDimensionWidth toSize:35];
        _headImgView.layer.cornerRadius = 35/2;
        _headImgView.layer.masksToBounds = YES;
    }else{
        if (index.row == 1) {
            _infoTextField.textColor = UIColorFromRGB(0x7c7c7c);
        }
        [_infoTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_typeLabel withOffset:15];
        [_infoTextField autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_infoTextField autoSetDimension:ALDimensionHeight toSize:30];
        [_infoTextField autoSetDimension:ALDimensionWidth toSize:200];
        if (index.row == 1) {
            _infoTextField.delegate = self;
            [_infoTextField addTarget:self action:@selector(textString:) forControlEvents:UIControlEventEditingChanged];
        }else{
            [_infoTextField setEnabled:NO];
        }
    }
}

- (void)setTypeText:(NSString *)typeText{
    _typeLabel.text = typeText;
}

- (void)textString:(UITextField *)textField{
//    if (textField.text.length > 6) {
//        textField.text = [textField.text substringToIndex:6];
//    }
    if ([self.delegate respondsToSelector:@selector(textFieldText:atIndepath:)]) {
        [self.delegate textFieldText:_infoTextField.text atIndepath:_indexPath];
    }
}

- (void)setUserName:(NSString *)userName{
    _infoTextField.text = userName;
}

- (void)setImgUrl:(NSString *)imgUrl{
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

- (void)setSexString:(NSString *)sexString{
    if ([sexString integerValue] == 1) {
        _infoTextField.text = NSLocalizedString(@"editPerInfoMan", nil);
    }else{
        _infoTextField.text = NSLocalizedString(@"editPerInfoWoman", nil);
    }
}

@end
