//
//  GroupReviewViewController.m
//  CardLeap
//
//  Created by mac on 15/2/3.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "GroupReviewViewController.h"
#import "TQStarRatingView.h"
@interface GroupReviewViewController ()<StarRatingViewDelegate,UITextViewDelegate>
{
    NSString *user_score;
    UILabel *placeHolder;
}
@property (strong, nonatomic) UITextView *userInput_T;
@property (strong, nonatomic) UIButton *rightButton;
@end

@implementation GroupReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    user_score = @"5.0";
}

#pragma mark---------set UI
-(void)setUI
{
    //评分lable
    UILabel *socreLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 35, 18)];
    socreLable.text = @"评分:";
    socreLable.textColor = [UIColor lightGrayColor];
    socreLable.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:socreLable];
    
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(60, 20, 130, 20) numberOfStar:5];
    //starRatingView.layer.borderWidth = 1;
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
    
    //评价lable
    UILabel *reviewLalbe = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 35, 18)] ;
    reviewLalbe.text = @"评价:";
    reviewLalbe.textColor = [UIColor lightGrayColor];
    reviewLalbe.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:reviewLalbe];
    
    [self.view addSubview:self.userInput_T];
    [_userInput_T autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:reviewLalbe withOffset:5.0f];
    [_userInput_T autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:socreLable withOffset:7.0f];
    [_userInput_T autoSetDimension:ALDimensionWidth toSize:200.0f];
    [_userInput_T autoSetDimension:ALDimensionHeight toSize:160.0f];
    
    placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 160, 20)];
    placeHolder.font = [UIFont systemFontOfSize:13.0f];
    placeHolder.textColor = [UIColor lightGrayColor];
    placeHolder.text = @"输入对商家的评价";
    [_userInput_T addSubview:placeHolder];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    user_score = [NSString stringWithFormat:@"%0.1f",score * 10 / 2.0 ];
    NSLog(@"您给的分数为%@",user_score);
}

#pragma mark----------get UI
-(UITextView *)userInput_T
{
    if (!_userInput_T) {
        _userInput_T = [[UITextView alloc] initForAutoLayout];
        _userInput_T.delegate = self;
        _userInput_T.layer.borderWidth = 1;
        _userInput_T.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _userInput_T;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        [_rightButton setImage:[UIImage imageNamed:@"eval_complete_no"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"eval_complete_sel"] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark------------action
-(void)finishAction:(UIButton*)sender
{
    //评价 之后跳转会评价列表页面
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"group_review");
    NSString *text = self.userInput_T.text;
#warning 12.10 取消评价必填文字的限制
    if (text == nil || [text isEqualToString:@""] == YES) {
        text = @" ";
    }
    NSDictionary *dict = @{
                           @"app_key":url,
                           @"u_id":[UserModel shareInstance].u_id,
                           @"session_key":[UserModel shareInstance].session_key,
                           @"score":user_score,
                           @"rev_text":text,
                           @"shop_id":self.info.shop_id,
                           @"group_id":self.info.group_id,
                           @"order_id":self.info.order_id
                           };
    [Base64Tool postSomethingToServe:url andParams:dict isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
        if ([param[@"code"] integerValue]==200) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate refreshAction];
        }else{
            [SVProgressHUD showErrorWithStatus:param[@"message"]];
        }
    } andErrorBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];

}
#warning 2016-02-29 15:43:52 修复提示文字不隐藏问题
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.text.length >0) {
        placeHolder.hidden = YES;
    }else{
        placeHolder.hidden = NO;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length>0) {
        placeHolder.hidden = YES;
    }else if (text.length==0){
        if (textView.text.length == 1) {
            placeHolder.hidden = NO;
        }
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end