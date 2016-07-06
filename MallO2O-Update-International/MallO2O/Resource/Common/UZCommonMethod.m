//
//  UZCommonMethod.m
//  WMYRiceNoodles
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UZCommonMethod.h"

@implementation UZCommonMethod : NSObject

+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view
{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webview];
}

+ (void)settingLabel:(UILabel *)label labelColor:(UIColor *)color labelFont:(int)fontSize lbelXian:(BOOL)xian{
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    if (xian) {
        UIView *xian = [[UIView alloc] initForAutoLayout];
        [label addSubview:xian];
        [xian autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [xian autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [xian autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [xian autoSetDimension:ALDimensionHeight toSize:0.5];
        xian.backgroundColor = color;
    }
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageNamed:disableImageUrl]
            forState:UIControlStateDisabled];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
        selectedImage:(NSString *)selectedImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:selectedImageUrl]
            forState:UIControlStateSelected];
}


+ (void)hiddleExtendCellFromTableview:(UITableView *)tableview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableview setTableFooterView:view];
}


+ (void)settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename
{
    UIImage* backImage = [[UIImage imageNamed:imagename]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    UIImage* backImageSel = [[UIImage imageNamed:selImagename]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    
    if (IOS7) {
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        [[UINavigationBar appearance] setBackIndicatorImage:backImage];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImageSel];
    }
    else{
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                          forState:UIControlStateNormal
                                                        barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImageSel
                                                          forState:UIControlStateHighlighted
                                                        barMetrics:UIBarMetricsDefault];
    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, -1000)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
}


//+ (void)settingLeftButtonImage:(NSString *)imagename
//                 selectedImage:(NSString *)selectedImagename
//                        action:(SEL)action
//               andAtButtonItem:(UIBarButtonItem *)buttonItem
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:imagename]
//                      forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:selectedImagename]
//                      forState:UIControlStateHighlighted];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//#warning 内存溢出
//    buttonItem = mybuttonItem;
//}


+ (void)settingBackButtonImage:(NSString *)imagename
                 selectedImage:(NSString *)selectedImagename
                  andContrller:(UIViewController *)controller
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imagename]
                      forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImagename]
                      forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToFather:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    controller.navigationItem.leftBarButtonItem = mybuttonItem;
}
+ (void)backToFather:(UIButton *)sender
{
    UINavigationBar *navigationBar = (UINavigationBar *)sender.superview;
    UINavigationController *nc = (UINavigationController *)[self GetViewController:navigationBar];
    [nc popViewControllerAnimated:YES];
}
+ (UIViewController*)GetViewController:(UIView*)uView
{
    for (UIView* next = [uView superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


+ (CGFloat)checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)checkAPPVersion
{
    static dispatch_once_t onceToken;
    __block NSString *APPVersion = 0;
    dispatch_once(&onceToken, ^{
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        APPVersion = [infoDict objectForKey:@"CFBundleVersion"];
    });
    return APPVersion;
}

+ (void)settingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset :UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins  :UIEdgeInsetsZero];
    }
}

/**
 *  截取 字符串 前后空格
 *  @param      string
 *  @return     NSString
 */
+ (NSString *) trimString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


/**
 *  web 加载 远程URL
 *
 *  @param webView 需要加载url的webView
 *  @param string  加载的 url 字符串
 */
+ (void) webViewUpLoadUrl:(UIWebView *)webView withString:(NSString *)string {
    NSURL *url            = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void) dialingPhone:(NSString *)phoneNumber {
    
    NSString *tel = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
}

/**
 *  发送短信息
 *
 *  @param phoneNumber 电话号码
 */
+ (void) sendMessage:(NSString *)phoneNumber {
    NSString *sms = [NSString stringWithFormat:@"sms://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sms]];
}


/**
 *  判断 是否是分页数据 是分页数据 (是分页数据 数组不清空)
 *
 *  @param dataSource   数据源数组
 *  @param page         分页数
 *  @param firstPage    第一页
 *
 *  @return 数据源
 */
+ (NSMutableArray *) chekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage {
    
    NSMutableArray *array = [NSMutableArray array];
    if (page != firstPage) {
        array = dataSource;
    }
    return array;
}

/**
 将纯色转换成图片
 */
+ (UIImage *)setImageFromColor:(UIColor *)color viewWidth:(CGFloat )width viewHeight:(CGFloat )height{
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(BOOL)inputString:(NSString *)textString{
    NSString *telHead = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telHead];
    return [numberPre evaluateWithObject:textString];
}

@end
