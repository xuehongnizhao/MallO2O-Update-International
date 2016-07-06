//
//  PointNumTableViewCell.m
//  MallO2O
//
//  Created by mac on 15/6/18.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PointNumTableViewCell.h"

#define NUMBERS @"0123456789"

@interface PointNumTableViewCell ()<UITextFieldDelegate>

@property (strong ,nonatomic) UILabel *label;

@property (strong ,nonatomic) UILabel *totalPointLabel;

@property (strong ,nonatomic) UITextField *inputPointTextField;

@end

@implementation PointNumTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndex:(NSIndexPath *)index{
    static NSString *identifier = @"pointChangeCell";
    PointNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PointNumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectIndex = index;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.totalPointLabel];
    [self.contentView addSubview:self.inputPointTextField];
}

- (void)settingAutoLayout{
    [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_label autoSetDimension:ALDimensionWidth toSize:200];
    _label.textColor = UIColorFromRGB(0x838383);
    _label.text = @"积分抵现";
    _label.font = [UIFont systemFontOfSize:15];
    
    [_totalPointLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_inputPointTextField withOffset:-4];
    [_totalPointLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_totalPointLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_totalPointLabel autoSetDimension:ALDimensionWidth toSize:150];
    _totalPointLabel.font = [UIFont systemFontOfSize:15];
    _totalPointLabel.textAlignment = NSTextAlignmentRight;
    
    [_inputPointTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_inputPointTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7];
    [_inputPointTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7];
    [_inputPointTextField autoSetDimension:ALDimensionWidth toSize:50];
    _inputPointTextField.delegate = self;
    [_inputPointTextField addTarget:self action:@selector(inputPoint) forControlEvents:UIControlEventEditingChanged];
    _inputPointTextField.layer.cornerRadius = 3;
    _inputPointTextField.layer.masksToBounds = YES;
    _inputPointTextField.textAlignment = NSTextAlignmentCenter;
    _inputPointTextField.layer.borderWidth = 1;
    _inputPointTextField.font = [UIFont systemFontOfSize:15];
    _inputPointTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)inputPoint{
    if ([self.delegate respondsToSelector:@selector(textString:atIndexPath:inTextField:)]) {
        [self.delegate textString:_inputPointTextField.text atIndexPath:_selectIndex inTextField:self.inputPointTextField];
    }
}

- (void)setPointString:(NSString *)pointString{
    _totalPointLabel.text = pointString;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入数字"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    return YES;
}

#pragma mark 初始化控件
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initForAutoLayout];
    }
    return _label;
}

- (UILabel *)totalPointLabel{
    if (!_totalPointLabel) {
        _totalPointLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalPointLabel;
}

- (UITextField *)inputPointTextField{
    if (!_inputPointTextField) {
        _inputPointTextField = [[UITextField alloc] initForAutoLayout];
        _inputPointTextField.restorationIdentifier = @"0-9";
    }
    return _inputPointTextField;
}

@end
