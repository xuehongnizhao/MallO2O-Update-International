//
//  SwpTextView.m
//  Swp_song
//
//  Created by songweiping on 16/1/31.
//  Copyright © 2016年 songweiping. All rights reserved.
//
//  @author             --->    swp_song    ( SwpTextView 自带 Placeholder )
//
//  @modification Time  --->    2016-02-01 13:44:16
//
//  @since              --->    1.0.1
//
//  @warning            --->    !!! <  > !!!

#import "SwpTextView.h"


static CGFloat         const kSwpTextViewAcquiesceFontSize        = 15.0f;
static SwpTimeInterval const kSwpTextViewAcquiesceAnimateDuration = 0.5;

@interface SwpTextView ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示 placeholder View !*/

@property (nonatomic, strong) UILabel *swpPlaceholderView;
/*! ---------------------- UI   Property  ---------------------- !*/
#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 用户输入数据回调      !*/
@property (nonatomic, copy, setter = swpTextViewChangeText:) SwpTextViewTextChangeHeadle swpTextViewTextChangeHeadle;
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpTextView

/*!
 *  @author swp_song
 *
 *  @brief  Override initWithFrame
 *
 *  @param  frame
 *
 *  @return SwpTextView
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self settingSwpTextViewProperty];
        [self setUpUI];
    }
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  layoutSubviews ( Override layoutSubviews )
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self settingUIFrame];
}
/*!
 *  @author swp_song
 *
 *  @brief  当前 控制器 被销毁时 调用
 */
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*!
 *  @author swp_song, 2016-02-01 11:06:01
 *
 *  @brief  setupUI ( 添加控件 )
 *
 *  @since  1.0.1
 */
- (void)setUpUI {
    [self addSubview:self.swpPlaceholderView];
}


/*!
 *  @author swp_song, 2016-02-01 11:07:55
 *
 *  @brief  settingSwpTextViewProperty  ( 设置 swpTextView 属性 )
 *
 *  @since  1.0.1
 */
- (void)settingSwpTextViewProperty {
    self.font = [UIFont systemFontOfSize:kSwpTextViewAcquiesceFontSize];
    [self showPlaceholderWithText:self.swpTextViewText == nil ? @"" : self.swpTextViewText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}


/*!
 *  @author swp_song, 2016-02-01 11:12:54
 *
 *  @brief  settingUIFrame  ( 设置 UI 控件 的 frame )
 *
 *  @since  1.0.1
 */
- (void)settingUIFrame {
    CGFloat placeholderX          = 8.0;
    self.swpPlaceholderView.frame = CGRectMake(placeholderX, 3, self.frame.size.width - placeholderX * 2.0, 25);
}


/*!
 *  @author swp_song, 2016-02-01 11:17:02
 *
 *  @brief  textDidChange   ( 通知 绑定方法 )
 *
 *  @param  notification
 *
 *  @since  1.0.1
 */
- (void)textDidChange:(NSNotification *)notification {
    _swpTextViewText = super.text;
    
    if (self.swpTextViewTextChangeHeadle) self.swpTextViewTextChangeHeadle(self, super.text);
    
    if ([self.swpTextViewDelegate  respondsToSelector:@selector(swpTextView:changeText:)]) {
        [self.swpTextViewDelegate swpTextView:self changeText:super.text];
    }
    
    [self showPlaceholderWithText:super.text];
}

/*!
 *  @author swp_song, 2016-02-01 11:17:37
 *
 *  @brief  showPlaceholderWithText ( 判断 文字 显示 | 隐藏 )
 *
 *  @param  text
 *
 *  @since  1.0.1
 */
- (void)showPlaceholderWithText:(NSString *)text {
    //textview长度为0
    if (self.text.length == 0) {
        //判断是否为删除键
        if ([text isEqualToString:@""]) {
            [self swpPlaceholderViewDisplay:YES animateDuration:kSwpTextViewAcquiesceAnimateDuration];
        } else {
            [self swpPlaceholderViewDisplay:NO animateDuration:kSwpTextViewAcquiesceAnimateDuration];
        }
    } else {
        //textview长度不为0
        if (self.text.length == 1) {
            //textview长度为1时候
            if ([text isEqualToString:@""]) {
                //判断是否为删除键
                [self swpPlaceholderViewDisplay:YES animateDuration:kSwpTextViewAcquiesceAnimateDuration];
            } else {
                //不是删除
                [self swpPlaceholderViewDisplay:NO animateDuration:kSwpTextViewAcquiesceAnimateDuration];
            }
        } else {
            //长度不为1时候
            [self swpPlaceholderViewDisplay:NO animateDuration:kSwpTextViewAcquiesceAnimateDuration];
        }
    }
}

/*!
 *  @author swp_song, 2016-02-01 11:19:02
 *
 *  @brief  swpPlaceholderViewDisplay   ( 是否显示 swpPlaceholderView )
 *
 *  @param  isDisplay
 *
 *  @param  duration
 *
 *  @since  1.0.1
 */
- (void)swpPlaceholderViewDisplay:(BOOL)isDisplay animateDuration:(SwpTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.swpPlaceholderView.alpha = isDisplay;
    }];
}


#pragma mark - Setting Property Public Methods
/*!
 *  @author swp_song, 2016-02-01 11:36:57
 *
 *  @brief  swpTextViewSetText  ( 设置 swpTextView 显示文字 )
 *
 *  @param  swpTextViewText
 *
 *  @since  1.0.1
 */
- (void)swpTextViewSetText:(NSString *)swpTextViewText {
    self.text = swpTextViewText;
}

/*!
 *  @author swp_song, 2016-02-01 11:39:07
 *
 *  @brief  setSwpTextViewPlaceholder   ( 设置 swpTextView 显示 placeholder )
 *
 *  @param  swpTextViewPlaceholder
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholder:(NSString *)swpTextViewPlaceholder {
    _swpTextViewPlaceholder      = swpTextViewPlaceholder;
    self.swpPlaceholderView.text = _swpTextViewPlaceholder;
}

/*!
 *  @author swp_song, 2016-02-01 11:44:50
 *
 *  @brief  setSwpTextViewTextFontSzie  ( 设置 swpTextView 字体大小 )
 *
 *  @param  swpTextViewTextFontSize
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewTextFontSize:(CGFloat)swpTextViewTextFontSize {
    _swpTextViewTextFontSize = swpTextViewTextFontSize;
    self.font                = [UIFont systemFontOfSize:_swpTextViewTextFontSize];
}

/*!
 *  @author swp_song, 2016-02-01 11:47:53
 *
 *  @brief  setSwpTextViewPlaceholderFontSize   ( 设置 swpTextView placeholder 字体大小 )
 *
 *  @param  swpTextViewPlaceholderFontSize
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholderFontSize:(CGFloat)swpTextViewPlaceholderFontSize {
    _swpTextViewPlaceholderFontSize = swpTextViewPlaceholderFontSize;
    self.swpPlaceholderView.font    = [UIFont systemFontOfSize:_swpTextViewPlaceholderFontSize];
}

/*!
 *  @author swp_song, 2016-02-01 11:54:45
 *
 *  @brief  swpTextViewTextFontSize:swpTextViewPlaceholderFontSize: ( 设置 swpTextView 文字 and placeholder 字体大小 )
 *
 *  @param  textFontSize
 *
 *  @param  placeholderFontSize
 *
 *  @since  1.0.1
 */
- (void)swpTextViewTextFontSize:(CGFloat)textFontSize swpTextViewPlaceholderFontSize:(CGFloat)placeholderFontSize {
    self.font                    = [UIFont systemFontOfSize:textFontSize];
    self.swpPlaceholderView.font = [UIFont systemFontOfSize:placeholderFontSize];
}

/*!
 *  @author swp_song, 2016-02-01 12:00:26
 *
 *  @brief  setSwpTextViewTextFontColor ( 设置 swpTextView 字体颜色 )
 *
 *  @param  swpTextViewTextFontColor
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewTextFontColor:(UIColor *)swpTextViewTextFontColor {
    _swpTextViewTextFontColor = swpTextViewTextFontColor;
    self.textColor            = _swpTextViewTextFontColor;
}

/*!
 *  @author swp_song, 2016-02-01 13:36:33
 *
 *  @brief  setSwpTextViewPlaceholderFontColor  ( 设置 swpTextView placeholder 字体颜色 )
 *
 *  @param  swpTextViewPlaceholderFontColor
 *
 *  @since  1.0.1
 */
- (void)setSwpTextViewPlaceholderFontColor:(UIColor *)swpTextViewPlaceholderFontColor {
    _swpTextViewPlaceholderFontColor  = swpTextViewPlaceholderFontColor;
    self.swpPlaceholderView.textColor = _swpTextViewPlaceholderFontColor;
}

/*!
 *  @author swp_song, 2016-02-01 13:40:54
 *
 *  @brief  swpTextViewTextFontColor:swpTextViewPlaceholderFontColor: ( 设置 swpTextView 文字 and placeholder 字体颜色 )
 *
 *  @param  textFontColor
 *
 *  @param  placeholderFontColor
 *
 *  @since  1.0.1
 */
- (void)swpTextViewTextFontColor:(UIColor *)textFontColor swpTextViewPlaceholderFontColor:(UIColor *)placeholderFontColor {
    self.textColor                    = textFontColor;
    self.swpPlaceholderView.textColor = placeholderFontColor;
}

/*!
 *  @author swp_song, 2016-02-02 10:48:36
 *
 *  @brief  swpTextViewChangeText           ( 用户输入数据回调 )
 *
 *  @param  swpTextViewTextChangeHeadle
 *
 *  @since  1.0.1
 */
- (void)swpTextViewChangeText:(SwpTextViewTextChangeHeadle)swpTextViewTextChangeHeadle {
    _swpTextViewTextChangeHeadle = swpTextViewTextChangeHeadle;
}

#pragma mark - Init UI Methods
- (UILabel *)swpPlaceholderView {
    
    return !_swpPlaceholderView ? _swpPlaceholderView = ({
        UILabel *lable  = [[UILabel alloc] init];
        lable.text      = @"placeholder";
        lable.font      = [UIFont systemFontOfSize:kSwpTextViewAcquiesceFontSize];
        lable.textColor = [UIColor lightGrayColor];
        lable;
    }) : _swpPlaceholderView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
