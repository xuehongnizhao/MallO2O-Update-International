//
//  SelectTypeViewController.m
//  MallO2O
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "SelectTypeViewController.h"
#import "SelectTypeModel.h"
#import "SelectTypeTableViewCell.h"
#import "SelectView.h"
#import "XHRealTimeBlur.h"
#import "SelectSonModel.h"
#import "CateGoodsViewController.h"

@interface SelectTypeViewController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>

@property (strong ,nonatomic) UITableView *selectTypeTableView;

/*-------------筛选上方区域关键字和价格区间------------*/
@property (strong ,nonatomic) UILabel     *searchLabel;
@property (strong ,nonatomic) UITextField *searchTextField;

@property (strong ,nonatomic) UILabel     *setPrice;
@property (strong ,nonatomic) UITextField *d_price;
@property (strong ,nonatomic) UITextField *h_price;
@property (strong ,nonatomic) UILabel     *jianHao;

@property (copy ,nonatomic) NSIndexPath *selectIndexPath;

@end

@implementation SelectTypeViewController{
    NSMutableArray *tableArray;
    NSMutableArray *tableViewArray;
    NSMutableArray *viewTableViewArray;
    SelectView *view;
    SelectTypeModel *outModel;
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
//    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
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
 页面即将消失的时候 将页面的编辑事件关掉(一般指textfield textview的编辑事件)
 */
- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}
/**
 *  数据初始化
 */
- (void) initData {
    viewTableViewArray = [[NSMutableArray alloc] init];
    tableViewArray = [[NSMutableArray alloc] init];
    [self getDataFromUrl];
}

#pragma mark 获取网络数据 推荐列表
- (void)getDataFromUrl{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"spe_list"]; 
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"cat_id" : self.cate_id
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        tableArray = resultObject[@"obj"];
        tableViewArray = [self arrayWithParam:resultObject[@"obj"]];
        [_selectTypeTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}
/**
    数据转成模型数组
 */
- (NSMutableArray *)arrayWithParam:(NSMutableArray *)param{
    NSMutableArray *array= [[NSMutableArray alloc] init];
    for (NSDictionary *dic in param) {
        SelectTypeModel *model = [SelectTypeModel arrayWithDic:dic];
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
    [self setNavBarTitle:NSLocalizedString(@"selectTypeNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self setNaviRightButton];
}

/**
 *  设置导航栏右侧按钮
 */
- (void)setNaviRightButton{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 44, 34);
    [rightBtn setTitle:NSLocalizedString(@"selectTypeSubmitButtonTitle", nil) forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

/**
 *  实现按钮点击事件
 */
- (void)save{
    NSString *ssss = [[NSString alloc] init];
    /*------------这个是我上传的string------------*/
    NSString *aaaa = [[NSString alloc] init];
    [self.view endEditing:YES];
    
    for (int i = 0; i <tableViewArray.count; i ++) {
        SelectTypeModel *model = tableViewArray[i];
        NSLog(@"%@",model.gcateSpecId);
        if (![model.gcateSpecId isEqualToString:@"0"] && ![model.gcateSpecId isKindOfClass:[NSNull class]] && model.gcateSpecId != nil) {
            NSLog(@"%@",model.gcateSpecId);
            if (ssss.length == 0) {
                ssss = [@"-" stringByAppendingFormat:@"%@-",model.gcateSpecId];
                aaaa = [aaaa stringByAppendingString:ssss];
            }else{
                ssss = [@",-" stringByAppendingFormat:@"%@-",model.gcateSpecId];
                aaaa = [aaaa stringByAppendingString:ssss];
            }
        }
    }
    
    NSMutableArray *arr = self.navigationController.viewControllers.mutableCopy;
    /* 删除不需要的VC */
    self.navigationController.viewControllers = arr;
    CateGoodsViewController *viewController = arr[1];
    viewController.likeString = _searchTextField.text;
    viewController.like_speString = aaaa;
    if ([_h_price.text integerValue] < [_d_price.text integerValue]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确价格"];
        return;
    }
    viewController.d_price = _d_price.text;
    viewController.h_price = _h_price.text;
    viewController.identifier = @"aaa";
    [self.navigationController popToViewController:viewController animated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    /*-------------筛选的关键字和价格区间控件添加------------*/
    _searchLabel = [[UILabel alloc] initForAutoLayout];
    _searchLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_searchLabel];
    
    _searchTextField = [[UITextField alloc] initForAutoLayout];
    [self.view addSubview:_searchTextField];
    _searchTextField.font = [UIFont systemFontOfSize:14];
    
    _setPrice = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:_setPrice];
    _setPrice.font = [UIFont systemFontOfSize:14];
    _d_price = [[UITextField alloc] initForAutoLayout];
    _d_price.delegate = self;
    [self.view addSubview:_d_price];
    _d_price.font = [UIFont systemFontOfSize:14];
    _d_price.keyboardType = UIKeyboardTypeNumberPad;
    _h_price = [[UITextField alloc] initForAutoLayout];
    [self.view addSubview:_h_price];
    _h_price.font = [UIFont systemFontOfSize:14];
    _h_price.delegate = self;
    _h_price.keyboardType = UIKeyboardTypeNumberPad;
    _jianHao = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:_jianHao];
    
    [_d_price addTarget:self action:@selector(clickPriceTextField:) forControlEvents:UIControlEventEditingChanged];
    [_h_price addTarget:self action:@selector(clickPriceTextField:) forControlEvents:UIControlEventEditingChanged];
    _selectTypeTableView = [[UITableView alloc] initForAutoLayout];
    [self.view addSubview:_selectTypeTableView];
    _selectTypeTableView.tag = 1;
    [UZCommonMethod hiddleExtendCellFromTableview:_selectTypeTableView];
    _selectTypeTableView.delegate = self;
    _selectTypeTableView.dataSource = self;
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    
    /*----------设置模糊搜索的自动布局----------*/
    [_searchLabel autoSetDimension:ALDimensionHeight toSize:30 * Balance_Heith];
    [_searchLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5 * Balance_Heith];
    [_searchLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:7 * Balance_Width];
    [_searchLabel autoSetDimension:ALDimensionWidth toSize:72.0f * Balance_Width];
    _searchLabel.text = NSLocalizedString(@"selectTypeKeywordTitle", nil);
    _searchLabel.font = [UIFont systemFontOfSize:14 * Balance_Width];
//    _searchLabel.layer.borderWidth = 1;
    
    /*----------设置模糊搜索的输入框自动布局----------*/
    [_searchTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_searchLabel withOffset:3];
    [_searchTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
    [_searchTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5 *Balance_Heith];
    [_searchTextField autoSetDimension:ALDimensionHeight toSize:30 * Balance_Heith];
//    _searchTextField.layer.borderWidth = 1;
    _searchTextField.font = [UIFont systemFontOfSize:13];
    _searchTextField.placeholder = NSLocalizedString(@"selectTypeKeywordPlaceholder", nil);
    
    [_setPrice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchLabel withOffset:13];
    [_setPrice autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5 * Balance_Width];
    [_setPrice autoSetDimension:ALDimensionWidth toSize:75.0f *Balance_Width];
    [_setPrice autoSetDimension:ALDimensionHeight toSize:20 * Balance_Heith];
    _setPrice.text = NSLocalizedString(@"selectTypePriceRange", nil);
    _setPrice.font = [UIFont systemFontOfSize:14 * Balance_Width];
//    _setPrice.layer.borderWidth = 1;
    
    [_d_price autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_setPrice withOffset:5];
    [_d_price autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchLabel withOffset:13];
    [_d_price autoSetDimension:ALDimensionHeight toSize:23 * Balance_Heith];
    [_d_price autoSetDimension:ALDimensionWidth toSize:70];
    _d_price.layer.borderWidth = 1;
    _d_price.layer.borderColor = [UIColorFromRGB(0xaeaeae) CGColor];
    _d_price.placeholder = NSLocalizedString(@"selectTypeLowPricePlaceholder", nil);
    _d_price.textAlignment = NSTextAlignmentCenter;
    _d_price.font = [UIFont systemFontOfSize:13];
    _d_price.layer.cornerRadius = 3;
    _d_price.layer.masksToBounds = YES;
    
    [_jianHao autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_d_price withOffset:3];
    [_jianHao autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchTextField withOffset:13];
    [_jianHao autoSetDimension:ALDimensionWidth toSize:15];
    [_jianHao autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    _jianHao.text = @"-";
    _jianHao.textColor = UIColorFromRGB(0xaeaeae);
    
    [_h_price autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jianHao withOffset:0];
    [_h_price autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchTextField withOffset:13];
    [_h_price autoSetDimension:ALDimensionHeight toSize:23 * Balance_Heith];
    [_h_price autoSetDimension:ALDimensionWidth toSize:70];
    _h_price.layer.borderWidth = 1;
    _h_price.layer.borderColor = [UIColorFromRGB(0xaeaeae) CGColor];
    _h_price.layer.cornerRadius = 3;
    _h_price.layer.masksToBounds = YES;
    _h_price.placeholder = NSLocalizedString(@"selectTypeHighPricePlaceholder", nil);
    _h_price.textAlignment = NSTextAlignmentCenter;
    _h_price.font = [UIFont systemFontOfSize:13];
    [self setXian];
}

/**
 通过view写的线
 */
- (void)setXian{
    UIView *xian1 = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:xian1];
    [xian1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchLabel withOffset:3];
    [xian1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [xian1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [xian1 autoSetDimension:ALDimensionHeight toSize:1];
    xian1.backgroundColor = UIColorFromRGB(0xaeaeae);
    
    xian1 = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:xian1];
    [xian1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_h_price withOffset:9];
    [xian1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [xian1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [xian1 autoSetDimension:ALDimensionHeight toSize:1];
    xian1.backgroundColor = UIColorFromRGB(0xaeaeae);
    
    
    /*----------设置tableview的自动布局----------*/
    [_selectTypeTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:xian1 withOffset:0];
    [_selectTypeTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_selectTypeTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_selectTypeTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

#pragma mark 设置tableview的代理方法和数据源方法
/**
 *  组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 1) {
        return 1;
    }
    return 1;
}

/**
 *  行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return tableViewArray.count;
    }
    return viewTableViewArray.count + 1;
}

/**
 *  数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        SelectTypeTableViewCell *cell = [SelectTypeTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
        cell.model = tableViewArray[indexPath.row];
        return cell;
    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [UZCommonMethod settingTableViewAllCellWire:view.tableView andTableViewCell:cell];
        NSMutableArray *array = [NSMutableArray arrayWithObject:NSLocalizedString(@"selectTypeAllTitle", nil)];
        [array addObjectsFromArray:viewTableViewArray];
        if (indexPath.row == 0) {
            cell.textLabel.text = array[0];
        }else{
            SelectSonModel *inModel = [outModel.sonArray objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = inModel.gcateSpecName;
        }
        return cell;
    }
}

/**
 *  高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        return 43 * Balance_Heith;
    }else
    return 40*Balance_Heith;
}

/**
 *  点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1) {
        _selectIndexPath = indexPath;
        [self setViewIn:indexPath];
    }else{
        [self.view disMissRealTimeBlur];
        [view removeFromSuperview];
        [self reloadDataAtIndex:indexPath];
    }
}

/**
 *  点击一级cell设置弹出的view的一些参数
 */
- (void)setViewIn:(NSIndexPath *)index{
    view = [[SelectView alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 160)];
    [self.view showRealTimeBlurWithBlurStyle:XHBlurStyleBlackGradient];
    viewTableViewArray = [tableArray[index.row] objectForKey:@"son"];
    view.string = [tableArray[index.row] objectForKey:@"gcate_spec_name"];
    view.tableView.tag = 2;
    view.tableView.delegate = self;
    view.tableView.dataSource = self;
    outModel = [tableViewArray objectAtIndex:index.row];
    [UZCommonMethod hiddleExtendCellFromTableview:view.tableView];
    [self setViewBackButton];
    [self.view addSubview:view];
}

/**
 *  设置view里的返回键
 */
- (void)setViewBackButton{
    [view.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view.backButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
}

/**
 点击取消按钮
 */
- (void)back{
    [self.view disMissRealTimeBlur];
    [view removeFromSuperview];
}

/**
 *  点击二级列表时返回一级列表数据
 *  单行刷新
 */
- (void)reloadDataAtIndex:(NSIndexPath *)index{
    SelectTypeModel *model = tableViewArray[_selectIndexPath.row];
    NSLog(@"%@",model.gcateSpecId);
    if (index.row == 0) {
        model.allText = NSLocalizedString(@"selectTypeAllTitle", nil);
        model.gcateSpecId = @"0";
    }else{
        SelectSonModel *model1 = [outModel.sonArray objectAtIndex:index.row - 1];
        model.allText = model1.gcateSpecName;
        model.gcateSpecId = model1.gcateSpecId;
    }
    SelectTypeModel *modeld = tableViewArray[_selectIndexPath.row];
    NSLog(@"%@",modeld.gcateSpecId);
    [_selectTypeTableView reloadRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:0];
}

- (void)clickPriceTextField:(UITextField *)textField{
    if (textField.text.length >= 5) {
        textField.text = [textField.text substringToIndex:5];
    }
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if ([textField.placeholder isEqualToString:NSLocalizedString(@"selectTypeHighPricePlaceholder", nil)] || [textField.placeholder isEqualToString:NSLocalizedString(@"selectTypeLowPricePlaceholder", nil)]) {
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
