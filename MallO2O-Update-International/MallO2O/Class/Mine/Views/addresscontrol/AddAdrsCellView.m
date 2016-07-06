//
//  AddAdrsCellView.m
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "AddAdrsCellView.h"
#define NUMBERS @"0123456789"

@interface AddAdrsCellView ()<UITextFieldDelegate>

@end

@implementation AddAdrsCellView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.inputTextField];
    [self.inputTextField addSubview:self.markImageView];
}

- (void)settingAutoLayout{
    [self.nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 3) excludingEdge:ALEdgeRight];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:75];
    
    [self.inputTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 20) excludingEdge:ALEdgeLeft];
    [self.inputTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel withOffset:3];
    
    self.markImageView.image = [UIImage imageNamed:@"address_mark"];
    self.markImageView.hidden = YES;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initForAutoLayout];
        _inputTextField.font = [UIFont systemFontOfSize:13];
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (UIImageView *)markImageView{
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13.5*Balance_Heith, 11 * Balance_Width, 15 * Balance_Heith)];
    }
    return _markImageView;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if ([textField.placeholder isEqualToString:@"请输入联系人电话"]) {
        NSCharacterSet*cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
    }    
    return [textField textInputMode] != nil;
}

@end
