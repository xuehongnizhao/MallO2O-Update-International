//
//  ExchangeInputTableViewCell.m
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ExchangeInputTableViewCell.h"
#import "ExchangeModel.h"

#define LABEL_TEXT_SIZE 14.0

@interface ExchangeInputTableViewCell ()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel     *exchangeTitleView;

@property (assign, nonatomic, getter = isShowBorderWidth) BOOL showBorderWidth;

@end

@implementation ExchangeInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) exchangeInputCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString            *cellID = @"exchangeInputCell";
    ExchangeInputTableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[ExchangeInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.showBorderWidth = NO;
        [self addUI];
        [self settingUIAutoLayout];
    }
    return self;
}

- (void) addUI {
    
    [self.contentView addSubview:self.exchangeTitleView];
    [self.contentView addSubview:self.exchangeDescView];
}


- (void)setExchange:(ExchangeModel *)exchange {
    
    _exchange = exchange;
    [self settingData];
}

- (void) settingData {
    self.exchangeTitleView.text       = self.exchange.exchangeTitle;
    self.exchangeDescView.placeholder = self.exchange.exchangePlaceholder;
    
    if (self.indexPath.row == 1) {
        self.exchangeDescView.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void) settingUIAutoLayout {
    
    [self.exchangeTitleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 0) excludingEdge:ALEdgeRight];
    [self.exchangeTitleView autoSetDimension:ALDimensionWidth toSize:45];
    
    [self.exchangeDescView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 12.5) excludingEdge:ALEdgeLeft];
    [self.exchangeDescView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.exchangeTitleView withOffset:10];
    
}

#pragma mark - delegate
- (void)textFieldEditChanged:(UITextField *)textField {
    if ([textField.placeholder isEqualToString:@"请输入电话"]) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldCell:updateTextLabelAtIndexPath:string:)]) {
        [_delegate textFieldCell:self updateTextLabelAtIndexPath:_indexPath string:nil];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:(UITextField *)textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if([self.delegate  respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:(UITextField *)textField];
    }
    NSString *textString = textField.text;
    if([self.delegate  respondsToSelector:@selector(textFieldCell:updateTextLabelAtIndexPath:string:)]) {
        [self.delegate textFieldCell:self updateTextLabelAtIndexPath:_indexPath string:textString];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [self.delegate textFieldDidBeginEditing:(UITextField *)textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:(UITextField*)textField];
    }
}



- (UILabel *)exchangeTitleView {
    
    if (!_exchangeTitleView) {
        _exchangeTitleView = [[UILabel alloc] initForAutoLayout];
//        [UZCommonMethod settingLabelProperty:_exchangeTitleView showBorderWidth:self.showBorderWidth fontSize:LABEL_TEXT_SIZE fontColor:UIColorFromRGB(0x606366)];
        _exchangeTitleView.textAlignment = NSTextAlignmentCenter;
        
    }
    return _exchangeTitleView;
}

- (UITextField *)exchangeDescView {
    
    if (!_exchangeDescView) {
        _exchangeDescView = [[UITextField alloc] initForAutoLayout];
        [_exchangeDescView addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _exchangeDescView.font = SYSTEM_FONT_SIZE(LABEL_TEXT_SIZE);
        _exchangeDescView.delegate = self;
    }
    return _exchangeDescView;
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if ([textField.placeholder isEqualToString:@"请输入电话"]) {
        NSCharacterSet*cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
    }
    return YES;
}


@end
