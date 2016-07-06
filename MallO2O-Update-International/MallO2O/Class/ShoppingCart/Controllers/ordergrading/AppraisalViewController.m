//
//  AppraisalViewController.m
//  MallO2O
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AppraisalViewController.h"
#import "RatingBar.h"
#import "MyOrderViewController.h"
#import <MJRefresh.h>

@interface AppraisalViewController ()<RatingBarDelegate>

@property (strong ,nonatomic) RatingBar *ratingBar;

@property (strong ,nonatomic) UILabel *pointLabel;

@property (strong ,nonatomic) UILabel *graddingLabel;

@property (strong ,nonatomic) UITextView *inputTextView;

@end

@implementation AppraisalViewController{
    NSInteger starPosition;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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

- (void)pushDataToUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"comment_insert"];
    NSString *textString = _inputTextView.text;
    [SVProgressHUD showWithStatus:@"正在提交评价"];
    if (_inputTextView.text == nil || [_inputTextView.text isEqualToString:@""]) {
            textString = @" ";
    }
    if (starPosition == 0) {
        starPosition = 1;
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id" : [UserModel shareInstance].u_id,
                          @"star_level" : [NSString stringWithFormat:@"%d",(int)starPosition],
                          @"order_id" : _orderId,
                          @"goods_id" : _goods_id,
                          @"og_id"    : _og_id,
                          @"comment"  : textString
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        NSArray *array = self.navigationController.viewControllers;
        MyOrderViewController *viewController = array[1];
        [viewController.myOrderTableView.mj_header beginRefreshing];
        viewController.tishiString = resultObject[@"message"];
        [self.navigationController popToViewController:viewController animated:YES];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
//    [Base64Tool postSomethingToServe:url andParams:dic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        NSLog(@"%@",param);
//        if ([param[@"code"] integerValue] == 200) {
//            
//            NSArray *array = self.navigationController.viewControllers;
//            MyOrderViewController *viewController = array[1];
//            [viewController.myOrderTableView.header beginRefreshing];
//            viewController.tishiString = param[@"message"];
//            [self.navigationController popToViewController:viewController animated:YES];
////            [SVProgressHUD showSuccessWithStatus:param[@"message"]];
//        }else{
//            [SVProgressHUD showErrorWithStatus:param[@"message"]];
//        }
//    } andErrorBlock:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络异常"];
//    }];
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
    [self setNavBarTitle:@"评价商品" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self setRightButton];
}

- (void)setRightButton{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(commite) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"commit_v_sel"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"commit_v_sel"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)commite{
    [self pushDataToUrl];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.ratingBar];
    [self.view addSubview:self.graddingLabel];
    [self.view addSubview:self.pointLabel];
    [self.view addSubview:self.inputTextView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_pointLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_pointLabel autoSetDimension:ALDimensionHeight toSize:40];
    [_pointLabel sizeToFit];
    _pointLabel.font = [UIFont systemFontOfSize:17];
    _pointLabel.text = @"评分：";
    
    [_graddingLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pointLabel withOffset:10];
    [_graddingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_graddingLabel autoSetDimension:ALDimensionHeight toSize:40];
    [_graddingLabel sizeToFit];
    _graddingLabel.text = @"评价：";
    
    [_inputTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_pointLabel withOffset:20];
    [_inputTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_graddingLabel withOffset:3];
    [_inputTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_inputTextView autoSetDimension:ALDimensionHeight toSize:220];
    _inputTextView.layer.borderWidth = 0.6;
    _inputTextView.layer.borderColor = [UIColorFromRGB(0xb3b3b3) CGColor];
}

#pragma mark 星星委托
- (void)getRatingPosition:(NSInteger)starIndex{
    starPosition = starIndex;
    NSLog(@"%d",(int)starPosition);
}

#pragma mark 初始化
- (RatingBar *)ratingBar{
    if (!_ratingBar) {
        _ratingBar = [[RatingBar alloc] initWithFrame:CGRectMake(90, 15, 150, 30)];
        _ratingBar.starNumber = 1;
        _ratingBar.delegate = self;
    }
    return _ratingBar;
}

- (UILabel *)graddingLabel{
    if (!_graddingLabel) {
        _graddingLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _graddingLabel;
}

- (UILabel *)pointLabel{
    if (!_pointLabel) {
        _pointLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _pointLabel;
}

- (UITextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] initForAutoLayout];
    }
    return _inputTextView;
}

@end
