//
//  EditPerInfoViewController.m
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "EditPerInfoViewController.h"
#import "EditInfoTableViewCell.h"
#import "PerInfoModel.h"
#import "PECropViewController.h"

@interface EditPerInfoViewController ()<UITableViewDataSource,UITableViewDelegate,EditInfoTableViewCellDelegate,UIActionSheetDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextFieldDelegate>

@property (nonatomic) UIPopoverController *popover;

@property (strong ,nonatomic) UITableView *editTableView;

@property (strong ,nonatomic) UIButton *saveButton;

@property (strong ,nonatomic) NSString *userName;

@property (strong ,nonatomic) NSString *sexString;

@property (strong ,nonatomic) NSIndexPath *selectIndex;

@end

@implementation EditPerInfoViewController{
    NSArray *typeArray;
    NSArray *infoArray;
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
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    _selectIndex = [[NSIndexPath alloc] init];
    typeArray  = @[
                   NSLocalizedString(@"editPerInfoAvatar", nil),
                   NSLocalizedString(@"editPerInfoNickname", nil),
                   NSLocalizedString(@"editPerInfoSex", nil)
                   ];
    _userName  = [[NSString alloc] init];
    _sexString = [[NSString alloc] init];
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
    [self setNavBarTitle:NSLocalizedString(@"editPerInfoNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    _editTableView = [[UITableView alloc] initForAutoLayout];
    _editTableView.scrollEnabled = NO;
    [self.view addSubview:_editTableView];
    _editTableView.delegate   = self;
    _editTableView.dataSource = self;
    
    _saveButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:_saveButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [_editTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_editTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_editTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_editTableView autoSetDimension:ALDimensionHeight toSize:120 * Balance_Heith];
    
    [_saveButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_editTableView withOffset:20 * Balance_Heith];
    [_saveButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_saveButton autoSetDimension:ALDimensionHeight toSize:35 * Balance_Heith];
    [_saveButton autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH - 40];
    [_saveButton setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    _saveButton.layer.cornerRadius = 4;
    _saveButton.layer.masksToBounds = YES;
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _saveButton.backgroundColor = UIColorFromRGB(0x78c5d2);
    [_saveButton addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 保存信息
- (void)saveInfo{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_edit_info"];
//    NSDictionary *infoDic = GetUserDefault(Person_Info);
    if (_sexString == nil || [_sexString isEqualToString:@""]) {
//        _sexString = infoDic[@"sex"];
        _sexString = [UserModel shareInstance].sex;
    }
    if (_userName == nil || [_userName isEqualToString:@""]) {
//        _userName = infoDic[@"user_nickname"];
        _userName = [UserModel shareInstance].user_name;
    }
    
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"sex"     : _sexString,
                          @"user_nickname" : _userName,
                          @"u_id"    : [UserModel shareInstance].u_id
                          };

    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [UserModel shareInstance].sex = _sexString;
        [UserModel shareInstance].user_name = _userName;
        NSLog(@"%@",dic);
        [self.navigationController popViewControllerAnimated:YES];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

#pragma mark tableview的数据源方法和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditInfoTableViewCell *cell = [EditInfoTableViewCell cellOfTableView:tableView cellForRowAtIndexpath:indexPath];
    cell.delegate = self;
    cell.typeText = typeArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.imgUrl = [UserModel shareInstance].user_pic;
            break;
            
        case 1:

            cell.userName = [UserModel shareInstance].user_name;
            break;
            
        case 2:

            cell.sexString = [UserModel shareInstance].sex;
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            _selectIndex = indexPath;
            [self setPicture];
            break;
        case 2:
        {
            UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"editPerInfoPleaseSelectGender", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"editPerInfoWoman", nil), NSLocalizedString(@"editPerInfoMan", nil), nil];
            actSheet.tag = 2;
            _selectIndex = indexPath;
            [actSheet showInView:self.view];
        }
            break;
            
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 2) {
        if (buttonIndex != 2) {
            _sexString = [NSString stringWithFormat:@"%d",(int)buttonIndex];
            EditInfoTableViewCell *cell = (EditInfoTableViewCell *)[_editTableView cellForRowAtIndexPath:_selectIndex];
            [cell setSexString:_sexString];
        }
    }else{
        [self selectPicFromPhone:buttonIndex];
    }
    
}

#pragma mark 选择照片或者拍照
- (void)setPicture{
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"editPerInfoPhotos", nil), NSLocalizedString(@"editPerInfoPhotoAlbum", nil), nil];
    chooseImageSheet.tag = 1;
    [chooseImageSheet showInView:self.view];
}

- (void)selectPicFromPhone:(NSInteger)buttonIndex{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0://Take picture
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }else{
                NSLog(@"模拟器无法打开相机");
            }
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            break;
            
        case 1://From album
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            break;
            
        default:
            
            break;
    }
}


#pragma mark 设置截取图片
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    EditInfoTableViewCell *cell = (EditInfoTableViewCell *)[_editTableView cellForRowAtIndexPath:_selectIndex];
    /**
     *这个是截取之后的图片
     */
    UIImage *headerImage = [self OriginImage:croppedImage scaleToSize:CGSizeMake(500, 500)];
    cell.headImgView.image = headerImage;
    NSData       *data   = UIImageJPEGRepresentation(cell.headImgView.image, 0.1);
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_upload_pic"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id"    : [UserModel shareInstance].u_id
                          };
    NSLog(@"%@",data);
    [SwpRequest swpPOSTAddFile:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt fileName:@"pic" fileData:data swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@",resultObject);
        if ([resultObject[@"code"] integerValue] == 200) {
            [UserModel shareInstance].user_pic = resultObject[@"obj"][@"user_pic"];
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        } else {
            [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:[self.swpNetwork swpChekNetworkError:errorMessage]];
    }];
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    EditInfoTableViewCell *cell = (EditInfoTableViewCell *)[_editTableView cellForRowAtIndexPath:_selectIndex];
    cell.headImgView.image = image;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self openEditor];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor];
            
        }];
    }
}

- (IBAction)openEditor
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    EditInfoTableViewCell *cell = (EditInfoTableViewCell *)[_editTableView cellForRowAtIndexPath:_selectIndex];
    controller.image = cell.headImgView.image;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark cell的代理方法，取出textfield输入值
- (void)textFieldText:(NSString *)text atIndepath:(NSIndexPath *)index{
    _userName = text;
}

@end
