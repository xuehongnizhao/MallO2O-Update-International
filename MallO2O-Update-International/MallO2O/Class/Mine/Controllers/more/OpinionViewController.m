//
//  OpinionViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "OpinionViewController.h"
#import "OpinionTableViewCell.h"
#import "OpinionModel.h"
#import "OrderDetailViewController.h"
#import "MoreViewController.h"


@interface OpinionViewController ()<UITextViewDelegate>

@property (strong ,nonatomic) UILabel *textLabel;

@end

@implementation OpinionViewController{
    NSMutableArray *tableViewArray;
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
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    _opinionTextView.textColor = UIColorFromRGB(0x898989);
    _opinionTextView.text = NSLocalizedString(@"opinionPlaceholder", nil);
    _opinionTextView.delegate = self;
    [self.sureButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
    [self.sureButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateHighlighted];
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

- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in param) {
        OpinionModel *model = [OpinionModel arrayWithDic:dic];
        [array addObject:model];
    }
    return array;
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
    [self setNavBarTitle:NSLocalizedString(@"moreFeedback", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _opinionTextView.layer.cornerRadius  = 4;
    _opinionTextView.layer.masksToBounds = YES;
    _opinionTextView.layer.borderWidth = 0.6;
    _opinionTextView.layer.borderColor = [UIColorFromRGB(0x898989) CGColor];
    
    _sureButton.layer.cornerRadius = 4;
    _sureButton.layer.masksToBounds = YES;
    
    _textLabel = [[UILabel alloc] initForAutoLayout];
    [_opinionTextView addSubview:_textLabel];
    [_textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [_textLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3];
    [_textLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_textLabel autoSetDimension:ALDimensionWidth toSize:50];
    _textLabel.font = [UIFont systemFontOfSize:11];
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.text = NSLocalizedString(@"opinionTextMaxSize", nil);
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
        _opinionTextView.text = @"";
        _opinionTextView.textColor = [UIColor blackColor];
}

/**
    上传信息
 */
- (IBAction)sureButton:(id)sender {
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"feedback"];
    if ( ![_opinionTextView.text isEqualToString:@""] && _opinionTextView.text != nil && ![_opinionTextView.text isEqualToString:NSLocalizedString(@"opinionPlaceholder", nil)]) {
        NSDictionary *dic = @{
                              @"app_key" : url,
//                              @"u_id"    : GetUserDefault(U_ID),
                              @"u_id"    : [UserModel shareInstance].u_id,
                              @"feed_desc" : _opinionTextView.text
                              };
        
        [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
            NSArray *VCArray = self.navigationController.viewControllers;
            MoreViewController *viewController = VCArray[1];
            viewController.opinionMessage = resultObject[@"message"];
            [self.navigationController popToViewController:viewController animated:YES];
            
        } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"opinionPlaceholder", nil)];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=250)
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", <#comment#>) message:NSLocalizedString(@"opinionTextMaxSize", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    else
    {
        return textView.textInputMode != nil;
    }
}



@end
