//
//  CalendarDayCell.m
//  tttttt
//
//  Created by 张凡 on 14-8-20.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarDayCell.h"

@implementation CalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bounds.size.width, self.bounds.size.width-10)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:14*Balance_Width];
    

    //农历
    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 13)];
    day_title.textColor = [UIColor lightGrayColor];
    day_title.font = [UIFont boldSystemFontOfSize:10*Balance_Width];
    day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:day_title];
    
    //选中时显示的图片
    NSLog(@"%f",self.bounds.size.width);
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 35, 35)];
    [imgview setCenter:CGPointMake(day_lab.center.x, day_lab.center.y)];
    imgview.image = [UIImage imageNamed:@"chack.png"];
    [self addSubview:imgview];
    [self addSubview:day_lab];
}


- (void)setModel:(CalendarDayModel *)model
{


    switch (model.style) {
        case CellDayTypeEmpty://不显示
            [self hidden_YES];
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            
            day_lab.textColor = [UIColor lightGrayColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeFutur://将来的日期
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
                day_lab.textColor = COLOR_THEME;
            }
            
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
                day_lab.textColor = COLOR_THEME1;
            }
            
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = [UIColor whiteColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = NO;
            //判断是开始日期 还是结束日期
            if(model.type == CellBeginDate)
            {
                day_title.text = @"开始日期";
            }else if(model.type == CellEndDate)
            {
                day_title.text = @"结束日期";
            }
            break;
        default:
            break;
    }


}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}


@end