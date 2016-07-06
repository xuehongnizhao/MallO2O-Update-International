//
//  AddAdrsInforViewController.m
//  MallO2O
//
//  Created by mac on 9/15/15.
//  Copyright (c) 2015 songweipng. All rights reserved.
//

#import "AddAdrsInforViewController.h"
#import "AddAdrsModel.h"
#import "AddAdrsInfoTableViewCell.h"
#import "EditMapViewController.h"
#import "AddressControlModel.h"

static NSString *const cellID = @"addAdrsCell";

@interface AddAdrsInforViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *addAdrsTableView;

@end

@implementation AddAdrsInforViewController{
    NSMutableArray *addAdrsArray;
    NSMutableArray *idxpthArray;
    NSMutableArray *infoArray;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
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
    if (self.addressModel != nil) {
        [self initInfoData];
        [self.addAdrsTableView reloadData];
    }
    if (_textFieldString != nil || _searchString != nil) {
        [self.addAdrsTableView reloadData];
    }
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    idxpthArray = [[NSMutableArray alloc] init];
    AddAdrsModel *modelOne = [AddAdrsModel setModelData:NSLocalizedString(@"addAdrsInforCellContactsTitle", nil) andString:NSLocalizedString(@"addAdrsInforCellContactsPlaceholder", nil)];
    
    AddAdrsModel *modelTwo = [AddAdrsModel setModelData:NSLocalizedString(@"addAdrsInforCellReceiptAddressTitle", nil) andString:[NSString stringWithFormat:@"      %@", NSLocalizedString(@"addAdrsInforCellReceiptAddressPlaceholder", nil)]];
    
    AddAdrsModel *modelThree = [AddAdrsModel setModelData:NSLocalizedString(@"addAdrsInforCellAddressInDetailTitle", nil) andString:NSLocalizedString(@"addAdrsInforCellAddressInDetailPlaceholder", nil)];
    
    AddAdrsModel *modelFour = [AddAdrsModel setModelData:NSLocalizedString(@"addAdrsInforCellTelephoneTitle", nil) andString:NSLocalizedString(@"addAdrsInforCellTelephonePlaceholder", nil)];
    
    addAdrsArray = [NSMutableArray arrayWithObjects:modelOne,modelTwo,modelThree,modelFour, nil];
}

- (void)initInfoData{
    AddAdrsModel *modelOne = [AddAdrsModel setModelData:@"联系人" andString:_addressModel.consigneeString];
    AddAdrsModel *modelTwo;
    if (_textFieldString == nil) {
        modelTwo = [AddAdrsModel setModelData:@"收货地址" andString:[NSString stringWithFormat:@"    %@",_addressModel.addressString]];
    }else{
        modelTwo = [AddAdrsModel setModelData:@"收货地址" andString:[NSString stringWithFormat:@"    %@",_textFieldString]];
    }
    AddAdrsModel *modelThree = [AddAdrsModel setModelData:@"详细地址" andString:_addressModel.addressInfo];
    AddAdrsModel *modelFour = [AddAdrsModel setModelData:@"手机号" andString:_addressModel.telString];
    infoArray = [NSMutableArray arrayWithObjects:modelOne,modelTwo,modelThree,modelFour, nil];
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
    [self setNavBarTitle:_naviTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    [self settingRightButton];
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingRightButton{
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame     = CGRectMake(0, 0, 34, 34);
    rightBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font  = [UIFont systemFontOfSize:13];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    [rightBtn setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)save:(UIButton *)button{
    [self.view endEditing:YES];
    NSString *url = [[NSString alloc] init];
    if (_isEditStatus) {
        url = [SwpTools swpToolGetInterfaceURL:@"address_update"];
    }else{
        url = [SwpTools swpToolGetInterfaceURL:@"address_insert"];
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i <4 ; i ++) {
        AddAdrsInfoTableViewCell *cell = (AddAdrsInfoTableViewCell *)[_addAdrsTableView cellForRowAtIndexPath:idxpthArray[i]];
        [array addObject:cell.cellView.inputTextField.text];
        if ([cell.cellView.inputTextField.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:cell.cellView.inputTextField.placeholder];
            return;
        }
    }
    //去掉字符串两侧的空格、
    NSString *addressInfo = [array[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *aaa = [array[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([array[3] length] != 11 || ![UZCommonMethod inputString:array[3]]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"addAdrsInforCellCkeckTitle", nil)];
        return;
    }
    NSDictionary *dic = @{
                          @"app_key" : url,
//                          @"u_id" : GetUserDefault(U_ID),
                          @"u_id"   : [PersonInfoModel shareInstance].uID,
                          @"consignee" : array[0],
                          @"phone_tel" : array[3],
                          @"address" : addressInfo,
                          @"address_info" : aaa,
                          @"lat" : [NSString stringWithFormat:@"%f", _locationCoor.latitude],
                          @"lng" : [NSString stringWithFormat:@"%f", _locationCoor.longitude],
                          };
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (_addressModel.addressId != nil) {
        [dict setObject:_addressModel.addressId forKey:@"address_id"];
    }
    if (_editLongitude != nil && _locationCoor.latitude == 0) {
        [dict setObject:_editLongitude forKey:@"lng"];
        [dict setObject:_editLatitude forKey:@"lat"];
    }
    button.enabled = NO;
    
    [self swpPublicTooGetDataToServer:url parameters:dict isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [self.navigationController popViewControllerAnimated:YES];
        button.enabled = YES;
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        button.enabled = YES;
    }];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.addAdrsTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_addAdrsTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_addAdrsTableView autoSetDimension:ALDimensionHeight toSize:168 * Balance_Heith];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAdrsInfoTableViewCell *cell = [AddAdrsInfoTableViewCell addAdrsCellOfTableView:tableView cellForRowAtIndexPath:indexPath cellID:cellID];
    if (self.addressModel != nil) {
        cell.addAdrsInfoModel = infoArray[indexPath.row];
    }
    if (self.textFieldString != nil && indexPath.row == 1 ) {
        cell.cellView.inputTextField.text = [NSString stringWithFormat:@"    %@",_textFieldString];
    }
    if (self.searchString != nil && indexPath.row == 1) {
        cell.cellView.inputTextField.text = [NSString stringWithFormat:@"    %@",_searchString];
    }
    if (indexPath.row == 1) {
        cell.cellView.markImageView.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 3) {
        cell.cellView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.cellView.inputTextField.tag = 11;
        [cell.cellView.inputTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    [idxpthArray addObject:indexPath];
    cell.addAdrsModel = addAdrsArray[indexPath.row];
    return cell;
}

- (void)changeTextField:(UITextField *)textField{
    if (textField.tag == 11) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self.view endEditing:YES];
        EditMapViewController *viewController = [[EditMapViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (UITableView *)addAdrsTableView{
    if (!_addAdrsTableView) {
        _addAdrsTableView = [[UITableView alloc] initForAutoLayout];
        [_addAdrsTableView registerClass:[AddAdrsInfoTableViewCell class] forCellReuseIdentifier:cellID];
        _addAdrsTableView.delegate = self;
        _addAdrsTableView.dataSource = self;
        _addAdrsTableView.scrollEnabled = NO;
        _addAdrsTableView.layer.borderWidth = 0.7;
        _addAdrsTableView.layer.borderColor = UIColorFromRGB(0xd9d9d9).CGColor;
        _addAdrsTableView.backgroundColor = [UIColor whiteColor];
    }
    return _addAdrsTableView;
}

- (void)dealloc{

}

@end
