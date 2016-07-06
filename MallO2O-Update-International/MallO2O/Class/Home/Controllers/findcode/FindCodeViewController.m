//
//  FindCodeViewController.m
//  MallO2O
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "FindCodeViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

@interface FindCodeViewController ()<ZBarReaderViewDelegate>

@property (strong ,nonatomic) ZBarReaderView *readerView;

@property (strong ,nonatomic) ZBarCameraSimulator *cameraSim;

@property (strong ,nonatomic) UIView *alphaView;

@end

@implementation FindCodeViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
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

- (void)viewDidAppear:(BOOL)animated{
    [_readerView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_readerView stop];
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
    [self setNavBarTitle:@"模板控制器" withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    _readerView = [[ZBarReaderView alloc] initForAutoLayout];
    _readerView.torchMode = 0;
    _readerView.trackingColor = [UIColor blackColor];
    [self.view addSubview:self.readerView];
    _readerView.tracksSymbols = NO;
    _readerView.backgroundColor = [UIColor blackColor];
    _readerView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _readerView.layer.borderWidth = 0.8;
    [_readerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _readerView.readerDelegate = self;
    _readerView.allowsPinchZoom = YES;
    

    _alphaView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:self.alphaView];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.7;
    [_alphaView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(350, 0, 0, 0)];
    
    _alphaView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:self.alphaView];
    _alphaView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [_alphaView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT - 100, 0)];
    
    _alphaView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:self.alphaView];
    [_alphaView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, 0, SCREEN_HEIGHT - 350, SCREEN_WIDTH/2 + 125)];
    _alphaView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    _alphaView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:self.alphaView];
    [_alphaView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, SCREEN_WIDTH/2 + 125, SCREEN_HEIGHT - 350, 0)];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.7;
    
    UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
    [self.view addSubview:imageView];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [imageView autoSetDimension:ALDimensionWidth toSize:250];
    [imageView autoSetDimension:ALDimensionHeight toSize:250];
    imageView.image = [UIImage imageNamed:@"find_code"];
    
//    _readerView.scanCrop = imageView.frame;
    
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:150];
    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [label autoSetDimension:ALDimensionHeight toSize:30];
    [label autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH];
    label.text = NSLocalizedString(@"dicoverBesomPromptTitle", nil);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    UIButton *cancleButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:cancleButton];
    [cancleButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [cancleButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [cancleButton autoSetDimension:ALDimensionHeight toSize:37];
    [cancleButton autoSetDimension:ALDimensionWidth toSize:95];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
    cancleButton.layer.borderWidth = 0.89;
    [cancleButton setBackgroundColor:[UIColor clearColor]];
    [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 4;
    
    if(TARGET_IPHONE_SIMULATOR) {
        _cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        _cameraSim.readerView = _readerView;
        
    }
}

/**
 当前页面的dismiss
 */
- (void)cancle{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

/**
 旋转的设置 为zbar.a内部文件
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [_readerView willRotateToInterfaceOrientation: toInterfaceOrientation
                                        duration: duration];
}

/**
 扫码后获取扫码值 并通过委托传递到首页进行操作
 */
- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
//        NSLog(@"%@",sym.data);
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%@",sym.data);
            if ([self.delegate respondsToSelector:@selector(getFindCodeFVCCodeNum:)]) {
                [self.delegate getFindCodeFVCCodeNum:sym.data];
            }
        }];
        break;
    }
}


@end
