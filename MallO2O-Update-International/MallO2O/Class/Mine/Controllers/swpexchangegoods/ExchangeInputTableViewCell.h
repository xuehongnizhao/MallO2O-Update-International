//
//  ExchangeInputTableViewCell.h
//  TourBottle
//
//  Created by songweiping on 15/5/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeInputTableViewCell;
@class ExchangeModel;

@protocol ExchangeInputTableViewCellDelegate <NSObject>


//Called to the delegate whenever the text in the rightTextField is changed
- (void)textFieldCell:(ExchangeInputTableViewCell *)cell updateTextLabelAtIndexPath:(NSIndexPath *)indexPath string:(NSString *)value;

@optional
/**
 *  取出 cell 中textField 中的数据(用户输入)
 *
 *  @param cell   对应的cell
 *  @param text   用户输入的数据
 */
- (void) userEditInfoTableViewCellTextFieldDidEndEditing:(ExchangeInputTableViewCell *)cell textTextFieldTag:(NSInteger )index text:(NSString *)text;

//Called to the delegate whenever return is hit when a user is typing into the rightTextField of an ELCTextFieldCell
- (BOOL)textFieldCell:(ExchangeInputTableViewCell *)inCell shouldReturnForIndexPath:(NSIndexPath*)indexPath withValue:(NSString *)value;
- (BOOL)textFieldShouldBeginEditing :(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing   :(UITextField *)textField;
- (void)textFieldDidBeginEditing    :(UITextField *)textField;
- (void)textFieldDidEndEditing      :(UITextField *)textField;

@end


@interface ExchangeInputTableViewCell : UITableViewCell


+ (instancetype) exchangeInputCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) UITextField *exchangeDescView;
@property (strong, nonatomic) NSIndexPath   *indexPath;
@property (strong, nonatomic) ExchangeModel *exchange;
@property (assign, nonatomic) id<ExchangeInputTableViewCellDelegate> delegate;

@end
