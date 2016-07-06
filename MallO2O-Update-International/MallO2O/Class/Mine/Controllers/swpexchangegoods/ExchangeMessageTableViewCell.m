
//
//  ExchangeMessageTableViewCell.m
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ExchangeMessageTableViewCell.h"

#import "ExchangeModel.h"

#define LABEL_TEXT_SIZE 14.0

@interface ExchangeMessageTableViewCell ()

@property (strong, nonatomic) UILabel *exchangeTitleView;


@property (assign, nonatomic, getter = isShowBorderWidth) BOOL showBorderWidth;

@end

@implementation ExchangeMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype) exchangeMessageCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString              *cellID = @"exchangeMessageTCell";
    ExchangeMessageTableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[ExchangeMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
 
    self.exchangeTitleView.text = self.exchange.exchangeTitle;
    self.exchangeDescView.text  = [self.exchange.exchangeDesc stringByAppendingString:@"积分"];
}

- (void) settingUIAutoLayout {
    
    [self.exchangeTitleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 0) excludingEdge:ALEdgeRight];
    [self.exchangeTitleView autoSetDimension:ALDimensionWidth toSize:45];
    
    [self.exchangeDescView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 12.5) excludingEdge:ALEdgeLeft];
    [self.exchangeDescView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.exchangeTitleView withOffset:10];
    
}

- (UILabel *)exchangeTitleView {
    
    if (!_exchangeTitleView) {
        _exchangeTitleView = [[UILabel alloc] initForAutoLayout];
//        [SwpCommonMethod settingLabelProperty:_exchangeTitleView showBorderWidth:self.showBorderWidth fontSize:LABEL_TEXT_SIZE fontColor:UIColorFromRGB(0x606366)];
        _exchangeTitleView.textAlignment = NSTextAlignmentCenter;
    }
    return _exchangeTitleView;
}

- (UILabel *)exchangeDescView {
    
    if (!_exchangeDescView) {
        _exchangeDescView = [[UILabel alloc] initForAutoLayout];
//        [SwpCommonMethod settingLabelProperty:_exchangeDescView showBorderWidth:self.showBorderWidth fontSize:LABEL_TEXT_SIZE fontColor:UIColorFromRGB(0x606366)];
        _exchangeDescView.textAlignment = NSTextAlignmentRight;
    }
    return _exchangeDescView;
}





@end
