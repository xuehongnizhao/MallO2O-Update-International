//
//  SearchHisViewController.m
//  MallO2O
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "CateGoodsViewController.h"
#import "SearchHisViewController.h"
#import "SearchResultViewController.h"
#import "SearchHotGoodsTableViewCell.h"

@interface SearchHisViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong ,nonatomic) UITableView *searchHisTableView;
@property (strong ,nonatomic) UISearchBar *searchBar;

@end

@implementation SearchHisViewController{
    //历史记录数据
    NSMutableArray* historyArray;
    NSInteger tableviewHang;
    NSArray *hotSearchArray;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    [self setRightBarButtonItem];
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
    [self addSearchBar];
    [_searchHisTableView reloadData];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)addSearchBar{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 100 * Balance_Width, 10, 200 * Balance_Width, 25)];
    _searchBar.delegate = self;
//    _searchBar.layer.borderWidth = 0.5;
//    [_searchBar setBackgroundColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar addSubview:_searchBar];
    [self.searchBar becomeFirstResponder];
    _searchBar.placeholder = NSLocalizedString(@"searchHisSearchBarPlaceholder", nil);
//    _searchBar
    UITextField *searchField=[((UIView *)[_searchBar.subviews objectAtIndex:0]).subviews lastObject];
    searchField.font = [UIFont systemFontOfSize:12];
//    searchField.backgroundColor = [UIColor lightGrayColor];
    searchField.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide:) name:UIKeyboardDidHideNotification object:nil];
}

/**
 *  通过通知判断键盘是否显示
 *
 *  @param notify 判断内部是否有打开键盘通知
 */
- (void)keyboardWasShown:(NSNotification *)notify{
    NSDictionary *userInfo = [notify userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    _searchHisTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - keyboardSize.height - 65);
}

- (void)keyboardWasHide:(NSNotification *)notify{
    _searchHisTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
/**
 *  视图即将消失调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchBar removeFromSuperview];
}
/**
 *  点击search的搜索按钮
 *
 *  @param searchBar 搜索栏
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self huanCunXinXiYongDe];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    hotSearchArray = [NSArray array];
    historyArray = [[NSMutableArray alloc] init];
    [historyArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"room_history"]];
    [self getHotSearchFromData];
    NSLog(@"%@",historyArray);
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
    [self setNavBarTitle:@"" withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
    重写父类pop方法
 
 */
- (void)popViewController{
    [_searchBar endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    _searchHisTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_searchHisTableView];
    _searchHisTableView.delegate = self;
    _searchHisTableView.dataSource = self;
    [_searchHisTableView registerClass:[SearchHotGoodsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [UZCommonMethod hiddleExtendCellFromTableview:_searchHisTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    CGFloat keyBoardHeight =
}

/**
    获取热门商品的数据
 */
- (void)getHotSearchFromData{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"hot_search"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        hotSearchArray = resultObject[@"obj"];
        tableviewHang = [self setHotSearchData:resultObject];
        [self.searchHisTableView reloadData];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}

/**
    设置热门商品的数据   获取行数  动态改变cell高度
 */
- (NSInteger)setHotSearchData:(NSDictionary *)param{
    NSArray *dataArray = param[@"obj"];
    NSInteger dataCount = dataArray.count;
    NSInteger hang = dataCount/3;
    if (dataCount%3 != 0) {
        hang = hang + 1;
    }
    return hang;
}

#pragma mark 设置nav右侧按钮
- (void)setRightBarButtonItem{
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 30* Balance_Width, 30);
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.textColor = [UIColor blackColor];
    rightButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -40);
    [rightButton setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchPost) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

#pragma mark 点击搜索按钮
- (void)searchPost{
    [_searchBar endEditing:YES];
    [self huanCunXinXiYongDe];
}

- (void)huanCunXinXiYongDe{
    if (_searchBar.text != nil && ![_searchBar.text isEqualToString:@""]) {
        if (historyArray.count!=0)
        {
            if (![historyArray containsObject:_searchBar.text])
            {
                NSLog(@"成功添加历史记录");
                [historyArray addObject:_searchBar.text];
            }
            else
            {
                NSLog(@"已有该数据");
            }
        }else
        {
            [historyArray addObject:_searchBar.text];
        }
        [[NSUserDefaults standardUserDefaults] setObject:historyArray forKey:@"room_history"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    if (_searchBar.text != nil && ![_searchBar.text isEqualToString:@""]) {
        SearchResultViewController *viewController = [[SearchResultViewController alloc] init];
        [viewController setNavBarTitle:NSLocalizedString(@"searchHisSearchResultsNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
        viewController.searchText = _searchBar.text;
        [_searchBar endEditing:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"searchHisSearchBarCheckInputText", nil)];
    }
}


#pragma mark tableview代理方法和数据源方法
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (historyArray.count==0)
    {
        return 0;
    }
    else
    {
        return historyArray.count+1;
    }
}
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            return 50 + tableviewHang*40;
    }
    return 40;
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SearchHisTableViewCell *cell = [SearchHisTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell;
    if (indexPath.section == 0) {
        SearchHotGoodsTableViewCell *cell = [SearchHotGoodsTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath withCellId:@"cell"];
        cell.dataArray = hotSearchArray;
        __weak typeof(SearchHisViewController *) vc = self;
        [cell clickCell:^(NSDictionary *cateDic) {
            SearchResultViewController *viewController = [[SearchResultViewController alloc] init];
            [viewController setNavBarTitle:NSLocalizedString(@"searchHisSearchResultsNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
            viewController.searchText = cateDic[@"name"];
            [_searchBar endEditing:YES];
            [vc.navigationController pushViewController:viewController animated:YES];
        }];
        return cell;
    }
    if (indexPath.row<historyArray.count)
    {
        static NSString *CellIdentifier = @"history";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
        }
        [UZCommonMethod settingTableViewAllCellWire:_searchHisTableView andTableViewCell:cell];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        if (historyArray.count!=0)
        {
            cell.textLabel.text=[historyArray objectAtIndex:historyArray.count-1-indexPath.row];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"delete";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [UZCommonMethod settingTableViewAllCellWire:_searchHisTableView andTableViewCell:cell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
        }
        UILabel *label = [[UILabel alloc] initForAutoLayout];
        [cell.contentView addSubview:label];
        [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"清除历史记录";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColorFromRGB(0x9f9d9d);
        UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
        [cell.contentView addSubview:imageView];
        [imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, SCREEN_WIDTH/2-70, 10, 0) excludingEdge:ALEdgeRight];
        [imageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:imageView];
        imageView.image = [UIImage imageNamed:@"clear_history"];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    UIView *view    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *label  = [[UILabel alloc] initForAutoLayout];
    [view addSubview:label];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    label.text      = [NSString stringWithFormat:@"     %@", NSLocalizedString(@"searchHisSearchForRecordsTitle", nil)];
    label.textColor = UIColorFromRGB(0x555555);
    label.font      = [UIFont systemFontOfSize:17];
    
    return view;
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<historyArray.count)
    {
        SearchResultViewController *viewController = [[SearchResultViewController alloc] init];
        viewController.searchText=[historyArray objectAtIndex:historyArray.count-indexPath.row-1];
        [viewController setNavBarTitle:NSLocalizedString(@"searchHisSearchResultsNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
        [_searchBar endEditing:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [historyArray removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:historyArray forKey:@"room_history"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_searchHisTableView reloadData];
    }
}


@end
