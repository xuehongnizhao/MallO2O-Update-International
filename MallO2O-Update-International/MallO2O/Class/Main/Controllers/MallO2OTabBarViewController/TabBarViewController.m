//
//  TabBarViewController.m
//  LeDingShop
//
//  Created by songweipng on 15/4/1.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "TabBarViewController.h"

#import "HomeViewController.h"
#import "CateViewController.h"
#import "ShoppingCartViewController.h"
#import "MineViewController.h"
#import "DicoverViewController.h"

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#define FONT_SIZE 10

@interface TabBarViewController ()

@end

@implementation TabBarViewController

#pragma mark ----- 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
    
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -setupViewControllers
-(void)setupViewControllers
{
    NSArray *controllerNames = @[
                               @"HomeViewController",
                               @"CateViewController",
                               @"DicoverViewController",
                               @"ShoppingCartViewController",
                               @"MineViewController",
                               ];
    NSMutableArray *controllers = [[NSMutableArray alloc]init];
   
    for (NSString *controllerName in controllerNames) {
        MallO2OBaseViewController *bvc     = [[[NSClassFromString(controllerName) class] alloc]init];
        UINavigationController *naviGation = [[UINavigationController alloc] initWithRootViewController:bvc];
        naviGation.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 1;
        naviGation.fd_interactivePopDisabled = YES;
        [controllers addObject:naviGation];
    }
    // 返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x111111)];
    [self setViewControllers:controllers];
    [self customizeTabBarForController:self];
}



#pragma mark -customizeTabBarForController
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    //设置tab透明背景
    [tabBarController.tabBar setTranslucent:YES];
    tabBarController.tabBar.backgroundView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    
//    [self addSeparateWith:tabBarController];
    UIView *view = [[UIView alloc] initForAutoLayout];
    [tabBarController.tabBar.backgroundView addSubview:view];
    [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [view autoSetDimension:ALDimensionHeight toSize:0.6];
    view.backgroundColor = UIColorFromRGB(0xe1e1e1);
    //设置选中图片
    NSArray *tabBarItemImages  = @[
                                  @"tabbar_home",
                                  @"tabbar_cate",
                                  @"tabbar_discover",
                                  @"tabbar_shopping_cart",
                                  @"tabbar_mine",
                                  ];
    
    NSArray *tabBarItemNames  = @[
                                  NSLocalizedString(@"tabBarHome", nil),
                                  NSLocalizedString(@"tabBarCate", nil),
                                  NSLocalizedString(@"tabBarDiscover", nil),
                                  NSLocalizedString(@"tabbarShoppingCart", nil),
                                  NSLocalizedString(@"tabbarMine", nil),
                                 ];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:nil withUnselectedImage:nil];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_no",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        //设置item名称
        NSString* itemTitle=[tabBarItemNames objectAtIndex:index];
        [item setTitle:itemTitle];
        
        // 设置item距离图片距离
        [item setTitlePositionAdjustment:UIOffsetMake(0, 3)];
        
        // 设置itemtitle选中颜色以及未选中颜色
        // 未选中
        [item setUnselectedTitleAttributes: @{
                                              NSFontAttributeName: [UIFont systemFontOfSize:12],
                                              NSForegroundColorAttributeName:UIColorFromRGB(0x606060),
                                              }];
        // 选中
        [item setSelectedTitleAttributes: @{
                                            NSFontAttributeName: [UIFont systemFontOfSize:12],
                                            NSForegroundColorAttributeName:UIColorFromRGB(0xe44b50),
                                            }];
        
        
        index++;
    }
    
//    tabBarController.selectedIndex = 0;
    
    
}

/**
 *  返回 状态栏字体样式
 *
 *  @return 返回黑色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


#pragma mark - 添加线到 tabBar 上
/**
 *
 *
 *  @param tabBarController
 */
- (void) addSeparateWith:(RDVTabBarController *)tabBarController {
    NSInteger _numOfMenu            = [tabBarController.viewControllers count];
    CGFloat   separatorLineInterval = SCREEN_WIDTH / _numOfMenu;
    
    for (int i = 0; i < _numOfMenu; i++) {
        //separator
        if (i != _numOfMenu - 1) {
            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, 50 / 2);
            CAShapeLayer *separator = [self createSeparatorLineWithColor:[UIColor lightGrayColor] andPosition:separatorPosition];
            [tabBarController.tabBar.backgroundView.layer addSublayer:separator];
        }
    }
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,10)];
    [path addLineToPoint:CGPointMake(160, 40)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0f;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    //    NSLog(@"separator position: %@",NSStringFromCGPoint(point));
    //    NSLog(@"separator bounds: %@",NSStringFromCGRect(layer.bounds));
    return layer;
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
