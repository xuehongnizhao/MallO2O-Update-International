//
//  InputMarkMessageViewController.m
//  MallO2O
//
//  Created by mac on 15/6/19.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "InputMarkMessageViewController.h"
#import "PushOrderViewController.h"
#import "SwpTextView.h"

@interface InputMarkMessageViewController ()<UITextViewDelegate>


@property (strong ,nonatomic) UIButton *commitButton;
@property (nonatomic, strong) SwpTextView *swpTextView;

@end

@implementation InputMarkMessageViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"inputMarkNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.commitButton];
    [self.view addSubview:self.swpTextView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.swpTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [self.swpTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [self.swpTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.swpTextView autoSetDimension:ALDimensionHeight toSize:200];
  
    
    [_commitButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.swpTextView withOffset:20];
    [_commitButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_commitButton autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH-40];
    [_commitButton autoSetDimension:ALDimensionHeight toSize:35];
    [_commitButton addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
    _commitButton.layer.cornerRadius = 4;
    _commitButton.layer.masksToBounds = YES;
    [_commitButton setTitle:NSLocalizedString(@"inputMarkNotesCommitButtonTitle", nil) forState:UIControlStateNormal];
    _commitButton.backgroundColor = UIColorFromRGB(0x63b7c8);
}

/**
 点击提交按钮
 */
- (void)clickCommitButton{
    PushOrderViewController *pushVC;
    NSArray *vcArray = self.navigationController.viewControllers;
    for (MallO2OBaseViewController *baseVC in vcArray) {
        if ([baseVC isKindOfClass:[PushOrderViewController class]]) {
            pushVC = (PushOrderViewController *)baseVC;
            if (![self.swpTextView.swpTextViewText isEqualToString:NSLocalizedString(@"inputMarkNotesPlaceholder", nil)] && self.swpTextView.swpTextViewText != nil && ![self.swpTextView.swpTextViewText isEqualToString:@""]) {
                pushVC.markString = self.swpTextView.swpTextViewText;
            }else{
                pushVC.markString = @"";
            }
        }
    }
    [self.navigationController popToViewController:pushVC animated:YES];
}


#pragma mark 初始化控件


- (UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initForAutoLayout];
    }
    return _commitButton;
}

- (SwpTextView *)swpTextView {
    
    return !_swpTextView ? _swpTextView = ({
        SwpTextView *swpTextView           = [SwpTextView new];
        swpTextView.layer.cornerRadius     = 5;
        swpTextView.layer.masksToBounds    = YES;
        swpTextView.layer.borderWidth      = 0.6;
        swpTextView.font                   = [UIFont systemFontOfSize:15];

        swpTextView.layer.borderColor      = [UIColorFromRGB(0xe3e3e3) CGColor];
        swpTextView.swpTextViewPlaceholder = NSLocalizedString(@"inputMarkNotesPlaceholder", nil);
        swpTextView;
    }) : _swpTextView;
}

@end
