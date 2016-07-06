//
//  TheSearchBox.m
//  ZhongWeiAliance
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//
//  中位 -----> 搜索框View

#import "TheSearchBox.h"

#define viewHeight  42  //搜索栏高度
#define TopSpacing  6   //顶部间距
#define LeftSpacing 12  //左侧间距
#define ButtonWitch 64  //按钮宽度

@interface TheSearchBox ()<UITextFieldDelegate>
/** 搜索输入栏 */
@property (nonatomic, strong) UITextField       * searchTextField;
/** 取消按钮 */
@property (nonatomic, strong) UIButton          * cancelButton;
@end


@implementation TheSearchBox

#pragma mark - 初始化
- (instancetype) init
{
    self = [super init];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化UI
/**
 *  初始化UI控件
 */
- (void) initUI
{
    [self addSubview:self.searchTextField];
    [self addSubview:self.cancelButton];
    self.searchTextField.delegate = self;
//    self.layer.borderWidth = 1;
}

/**
 *  设置frame
 */
- (void) layoutSubviews
{
    [super layoutSubviews];
    //    self.searchTextField.frame = CGRectMake(LeftSpacing, TopSpacing, self.frame.size.width - LeftSpacing*2.0, self.frame.size.height - TopSpacing*2.0);
    //    self.cancelButton.frame = CGRectMake(0, 0, 0, 0);
}
#pragma mark - Set方法
/**
 *  提示文字
 *
 *  @param tips
 */
- (void) setTips:(NSString *)tips
{
    _tips = tips;
    self.searchTextField.placeholder    =   self.tips;        //默认显示提示信息
}
/**
 *  左侧放大镜
 *
 *  @param searchImage
 */
- (void) setSearchImage:(UIImage *)searchImage
{
    _searchImage = searchImage;
    _searchTextField.leftView              =    [[UIImageView alloc] initWithImage:self.searchImage];
    _searchTextField.leftViewMode          =    UITextFieldViewModeAlways;
//    _searchTextField.leftView.frame = CGRectMake(20, 0, 20, 20);
    
}

#pragma mark - 搜索
#pragma mark 开始搜索
- (void) SearchStart:(NSString *) string
{
    if (self.searchDelegate != nil) {
        if ([self.searchDelegate respondsToSelector:@selector(SearchWithString:)]) {
            [self.searchDelegate SearchWithString:string];
        } else {
            [SVProgressHUD showErrorWithStatus:@"搜索框代理找不到“SearchWithString:”方法"];
        }
    }else
    {
        [SVProgressHUD showErrorWithStatus:@"搜索框找不到代理“searchDelegate”"];
    }
}
#pragma mark 取消搜索
/**
 *  取消搜索
 */
- (void) cancelSearch
{
    self.searchTextField.text = @"";
//    self.searchTextField.frame = CGRectMake(LeftSpacing, TopSpacing, self.frame.size.width - LeftSpacing*2.0, self.frame.size.height - TopSpacing*2.0);
    self.cancelButton.frame = CGRectMake(-1000, -1000, 0, 0);
    [self.searchTextField resignFirstResponder];//输入框放弃第一响应者
    if (self.searchDelegate != nil) {
        if ([self.searchDelegate respondsToSelector:@selector(ClearSearch)]) {
            [self.searchDelegate ClearSearch];
        } else {
            [SVProgressHUD showErrorWithStatus:@"搜索框代理找不到“ClearSearch”方法"];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"搜索框找不到代理“searchDelegate”"];
    }
}

#pragma mark - TextFieldDelegate
#pragma mark 开始输入
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        //        [self.cancelButton removeFromSuperview];
        //        [self.searchTextField removeFromSuperview];
        self.cancelButton.frame = CGRectMake(self.frame.size.width- ButtonWitch + 11, 0, ButtonWitch, self.frame.size.height);
//        self.searchTextField.frame = CGRectMake(LeftSpacing, TopSpacing, SCREEN_WIDTH - LeftSpacing - ButtonWitch, self.frame.size.height - TopSpacing*2.0);
        //        [self addSubview:self.cancelButton];
        //        [self addSubview:self.searchTextField];
    }];
    return YES;
}
#pragma mark 结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
//        self.searchTextField.frame = CGRectMake(LeftSpacing, TopSpacing, self.frame.size.width - LeftSpacing*2.0, self.frame.size.height - TopSpacing*2.0);
        self.cancelButton.frame = CGRectMake(-1000, -1000, 0, 0);
    }];
}
#pragma mark 响应键盘return事件
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self SearchStart:textField.text];
    NSLog(@"文字:%@",textField.text);
    return YES;
}

#pragma mark - 懒加载
/**
 *  搜索栏
 *
 *  @return return value description
 */
- (UITextField *) searchTextField {
    if (!_searchTextField) {
        _searchTextField                =   [[UITextField alloc]initWithFrame:CGRectMake(LeftSpacing, TopSpacing, self.frame.size.width - 55, self.frame.size.height - TopSpacing*2.0)];
        _searchTextField.adjustsFontSizeToFitWidth   =   YES;          //自适应一下
        //_searchTextField.keyboardType  =   UIKeyboardTypeNumberPad;//设置键盘类型（这里是数字）
        _searchTextField.clearsOnBeginEditing   =   YES;            //再次输入时 清除之前输入的东西。
        //_searchTextField.secureTextEntry        =   YES;          //隐藏文字
        _searchTextField.returnKeyType          =   UIReturnKeyGoogle;//return文字换成搜索
        _searchTextField.clearButtonMode        =   UITextFieldViewModeAlways;  //右侧小叉
        _searchTextField.borderStyle            =   UITextBorderStyleRoundedRect;//边框样式
        _searchTextField.backgroundColor = SWPColor(204, 204, 204, 1);
        
        _searchTextField.font  = [UIFont systemFontOfSize:14];
    }
    return _searchTextField;
}

/**
 *  取消按钮
 *
 *  @return return value description
 */
- (UIButton *) cancelButton
{
    if (!_cancelButton) {
        _cancelButton       =   [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor  =   [UIColor clearColor];
        _cancelButton.frame =   CGRectMake(-1000, -1000, 0, 0);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:SWPColor(85, 151, 233, 1) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
@end
