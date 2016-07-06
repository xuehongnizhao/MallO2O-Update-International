
//
//  ExchangeSelectedTableViewCell.m
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ExchangeSelectedTableViewCell.h"

#import "ExchangeModel.h"

#define LABEL_TEXT_SIZE 14.0

@interface ExchangeSelectedTableViewCell ()

@property (strong, nonatomic) UILabel   *titleView;
@property (strong, nonatomic) UIButton  *addShopView;
@property (strong, nonatomic) UIButton  *subtractShopView;
@property (strong, nonatomic) UILabel   *shopSumView;

@property (assign, nonatomic, getter = isShowBorderWidth) BOOL showBorderWidth;

@end

@implementation ExchangeSelectedTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) exchangeSelectedCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString               *cellID = @"exchangeSelectedCell";
    ExchangeSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[ExchangeSelectedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.addShopView];
    [self.contentView addSubview:self.shopSumView];
    [self.contentView addSubview:self.subtractShopView];
    
}


- (void)setExchange:(ExchangeModel *)exchange {
    
    _exchange = exchange;
    [self settingData];
}

- (void) settingData {
    
    self.titleView.text   = self.exchange.exchangeTitle;
    self.shopSumView.text = self.exchange.exchangeDesc;
}

- (void) settingUIAutoLayout {
    
    [self.titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 0) excludingEdge:ALEdgeRight];
    [self.titleView autoSetDimension:ALDimensionWidth toSize:45];
    
    [self.addShopView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 12.5) excludingEdge:ALEdgeLeft];
    [self.addShopView autoSetDimension:ALDimensionWidth toSize:24];
    
    [self.shopSumView autoPinEdge:ALEdgeTop     toEdge:ALEdgeTop ofView:self.addShopView];
    [self.shopSumView autoPinEdge:ALEdgeBottom  toEdge:ALEdgeBottom ofView:self.addShopView];
    [self.shopSumView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.addShopView withOffset:-6];
    [self.shopSumView autoSetDimension:ALDimensionWidth toSize:24];
    _shopSumView.layer.borderWidth = 0.6;
    _shopSumView.layer.borderColor = [UIColorFromRGB(0xe3e3e3) CGColor];
    
    [self.subtractShopView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.addShopView];
    [self.subtractShopView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.addShopView];
    [self.subtractShopView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.shopSumView withOffset:-6];
    [self.subtractShopView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.addShopView];
    
}

- (void) settingUIButtonProperty:(UIButton *)button buttonTag:(NSInteger)tag imageName:(NSString *)name {
    
//    button.layer.borderWidth = 1;
    button.tag             = tag;
    NSString *noImageName  = [NSString stringWithFormat:@"%@_no", name];
    NSString *selImageName = [NSString stringWithFormat:@"%@_sel", name];
    [button setImage:[UIImage imageNamed:noImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) didButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(exchangeSelectedTableViewCell:cellForRowAtIndexPath:dataModel:didAddAndSubtractButton:buttonIndex:)]) {
        [self.delegate exchangeSelectedTableViewCell:self cellForRowAtIndexPath:self.indexPath dataModel:self.exchange didAddAndSubtractButton:button buttonIndex:button.tag];
    }
}

- (UILabel *)titleView {
    
    if (!_titleView) {
        _titleView = [[UILabel alloc] initForAutoLayout];
//        [SwpCommonMethod settingLabelProperty:_titleView showBorderWidth:self.showBorderWidth fontSize:LABEL_TEXT_SIZE fontColor:UIColorFromRGB(0x606366)];
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleView;
}

- (UIButton *)addShopView {
    
    if (!_addShopView) {
        _addShopView  = [[UIButton alloc] initForAutoLayout];
        [self settingUIButtonProperty:_addShopView buttonTag:1 imageName:@"exchange_add"];
        
    }
    return _addShopView;
}

- (UILabel *)shopSumView {
    
    if (!_shopSumView) {
        _shopSumView = [[UILabel alloc] initForAutoLayout];
//        [SwpCommonMethod settingLabelProperty:_shopSumView showBorderWidth:YES fontSize:LABEL_TEXT_SIZE fontColor:UIColorFromRGB(0x606366)];
        _shopSumView.layer.borderColor = UIColorFromRGB(0xd1d1d1).CGColor;
        _shopSumView.textAlignment     = NSTextAlignmentCenter;
        
    }
    return _shopSumView;
}


- (UIButton *)subtractShopView {
    
    if (!_subtractShopView) {
        _subtractShopView  = [[UIButton alloc] initForAutoLayout];

        [self settingUIButtonProperty:_subtractShopView buttonTag:0 imageName:@"exchange_subtract"];
    }
    return _subtractShopView;
}


@end
