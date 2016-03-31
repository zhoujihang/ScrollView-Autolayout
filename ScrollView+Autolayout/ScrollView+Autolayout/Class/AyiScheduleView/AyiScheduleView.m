//
//  AyiScheduleView.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "AyiScheduleView.h"
#import "ScheduleUnitView.h"

#import "NSDate+Extension.h"

static CGFloat defaultDayNameViewHeight = 112;
@interface AyiScheduleView()
// 约束属性 -----------------------------------------
// 日期到左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayNameViewLeftSpaceCons;
// 日期视图的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayNameViewWidthCons;
// 日期视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayNameViewHeightCons;

// 日期视图和排班表之间的水平距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayNameAndScheduleHorizontalSpaceCons;
// 排班表到右边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scheduleViewRightSpaceCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeightCons;

// 控件属性 -----------------------------------------
@property (weak, nonatomic) IBOutlet UIView *dayNameView;
// 存放 日期名字 的数组
@property (nonatomic, strong) NSMutableArray *dayNameArr;
// 存放 小圆圈
@property (weak, nonatomic) IBOutlet UIView *scheduleView;
// 一行中显示多少个圆的cell
@property (nonatomic, assign) NSInteger cellCountInOneRow;

// 填充数据后 dayNameView 的高度
@property (nonatomic, assign) CGFloat dayNameViewHeightWithContent;
@end


@implementation AyiScheduleView
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.topLineHeightCons.constant = 1/[UIScreen mainScreen].scale;
    self.bottomLineHeightCons.constant = 1/[UIScreen mainScreen].scale;
    
    [self setUpViews];
}
- (void)setUpViews{
    self.dayNameViewHeightCons.constant = defaultDayNameViewHeight;
    [self resizeBounds];
}
- (void)setAyiDetailAndScheduleModel:(AyiDetailAndScheduleModel *)ayiDetailAndScheduleModel{
    _ayiDetailAndScheduleModel = ayiDetailAndScheduleModel;
    
    [self createSubviews];
    [self setUpSubviewsFrame];
    [self refreshView];
}

- (void)clearSubviews{
    while (self.dayNameView.subviews.count>0) {
        UIView *view = [self.dayNameView.subviews firstObject];
        [view removeFromSuperview];
    }
    while (self.scheduleView.subviews.count>0) {
        UIView *view = [self.scheduleView.subviews firstObject];
        [view removeFromSuperview];
    }
}

- (void)createSubviews{
    [self clearSubviews];
    
    self.cellCountInOneRow = 11;
    NSInteger count = self.ayiDetailAndScheduleModel.ayiScheduleArr.count;
    // 添加 dayNameView 内的子控件
    for (int i=0; i<count; i++) {
        UILabel *dayNameLabel = [[UILabel alloc]init];
        dayNameLabel.font = [UIFont systemFontOfSize:14];
        dayNameLabel.textAlignment = NSTextAlignmentRight;
        [self.dayNameView addSubview:dayNameLabel];
    }
    // 添加 scheduleView 内的子控件 ，时间固定从 8:00 到 18:00
    for (int i=0; i<count; i++){
        UIView *rowView = [[UIView alloc]init];
        for (int j=0; j<self.cellCountInOneRow; j++) {
            ScheduleUnitView *unitView = [[ScheduleUnitView alloc]init];
            [rowView addSubview:unitView];
        }
        [self.scheduleView addSubview:rowView];
    }
}

- (void)setUpSubviewsFrame{
    CGFloat oneLineHeight = 28.0;
    CGFloat dayNameViewWidth = self.dayNameViewWidthCons.constant;
    CGFloat scheduleViewWidth = [UIScreen mainScreen].bounds.size.width - dayNameViewWidth - self.dayNameViewLeftSpaceCons.constant - self.dayNameAndScheduleHorizontalSpaceCons.constant - self.scheduleViewRightSpaceCons.constant;
    
    // 计算 dayNameView 内的子控件
    CGFloat dayNameLabelHeight = oneLineHeight;
    CGFloat dayNameLabelWidth = dayNameViewWidth;
    for (int i=0; i<self.dayNameView.subviews.count; i++) {
        UIView *subview = self.dayNameView.subviews[i];
        subview.frame = CGRectMake(0, dayNameLabelHeight*i, dayNameLabelWidth, dayNameLabelHeight);
    }
    
    // 计算 scheduleView 内的子控件
    CGFloat rowViewHeight = oneLineHeight;
    CGFloat rowViewWidth = scheduleViewWidth;
    CGFloat padding = 3;    // 行内子控件的间距
    CGFloat subviewWidth = rowViewWidth/self.cellCountInOneRow;
    CGFloat subviewHeight = rowViewHeight;
    CGFloat cellViewHeight = subviewHeight-2*padding;
    CGFloat cellViewWidth = subviewWidth-2*padding;
    // 直径
    CGFloat cellViewDiameter = MIN(cellViewWidth, cellViewHeight);
    CGPoint firstCellCenter = CGPointMake(subviewWidth/2, subviewHeight/2);
    
    for (int i=0; i<self.scheduleView.subviews.count; i++) {
        // 行控件
        UIView *rowView = self.scheduleView.subviews[i];
        rowView.frame = CGRectMake(0, rowViewHeight*i, rowViewWidth, rowViewHeight);
        
        // 行内子控件的布局
        for (int j=0; j<rowView.subviews.count; j++) {
            UIView *cellView = rowView.subviews[j];
            
            cellView.frame = CGRectMake(0, 0, cellViewDiameter, cellViewDiameter);
            cellView.center = CGPointMake(firstCellCenter.x+subviewWidth*j, firstCellCenter.y);
        }
    }
    
    // 计算高度
    UIView *lastDayNameView = [self.dayNameView.subviews lastObject];
    if (!lastDayNameView) {
        self.bounds = CGRectMake(0, 0, 1000, 1000);
        self.dayNameViewHeightCons.constant = defaultDayNameViewHeight;
    }else{
        CGFloat maxY = CGRectGetMaxY(lastDayNameView.frame);
        // 布局前让父控件变大，解决约束冲突
        self.bounds = CGRectMake(0, 0, 1000, 1000);
        self.dayNameViewHeightCons.constant = maxY;
    }
    [self resizeBounds];
}

// 为控件填充数据
- (void)refreshView{
    
    for (int i=0; i<self.scheduleView.subviews.count; i++) {
        // 服务时间行
        UIView *rowView = self.scheduleView.subviews[i];
        // 日期名字
        UILabel *dayNameLabel = self.dayNameView.subviews[i];
        
        if (i>=self.ayiDetailAndScheduleModel.ayiScheduleArr.count) {
            rowView.hidden = YES;
            dayNameLabel.hidden = YES;
            continue;
        }
        
        rowView.hidden = NO;
        dayNameLabel.hidden = NO;
        
        AyiScheduleOneDayModel *oneDayModel = self.ayiDetailAndScheduleModel.ayiScheduleArr[i];
        
        // 填充 dayNameView 的内容
        NSString *ymdSting = oneDayModel.ymd;
        dayNameLabel.text = [self dayNameStringFromYMDString:ymdSting];
        
        // 填充 scheduleView 的内容
        for (int j=0; j<rowView.subviews.count; j++) {
            // 列
            ScheduleUnitView *unitView = rowView.subviews[j];
            ScheduleUnitModel *unitModel = oneDayModel.scheduleUnitArr[j];
            unitView.model = unitModel;
        }
    }
}
// 根据内容重设bounds
- (void)resizeBounds{
    self.bounds = CGRectMake(0, 0, 1000, 1000);
    
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
}


/**
 *  ymdString的格式为 2015-08-07 转化为 今天/明天/11.23/11.24 这样的格式
 *
 *  @return
 */
- (NSString *)dayNameStringFromYMDString:(NSString *)ymdString{
    NSString *dayName = nil;
    NSDateFormatter *dateFormatter = [NSDate dateFormatterInChineseTimeZoneWithFormatterString:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *ymdDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",ymdString]];
    // 获取 ymdDate 的YMD日期模型
    NSDateComponents *ymdComponents = [ymdDate YMD_Components];
    
    NSDate *todayDate = [NSDate date];
    
    // 指定日期的 0 时时间
    NSTimeInterval ymdSeconds = ymdDate.timeIntervalSince1970;
    // 手机当前的时间
    NSTimeInterval todaySeconds = todayDate.timeIntervalSince1970;
    // 秒数差值
    NSTimeInterval secondMargin = ymdSeconds - todaySeconds;
    // 一天的秒数
    NSTimeInterval secondOneday = 24*60*60;
    if (secondMargin >-secondOneday && secondMargin <= 0) {
        dayName = @"今天";
    }else if(secondMargin>0 && secondMargin<=secondOneday){
        dayName = @"明天";
    }else{
        dayName = [NSString stringWithFormat:@"%ld.%ld",(long)ymdComponents.month,(long)ymdComponents.day];
    }
    
    return dayName;
}

@end
