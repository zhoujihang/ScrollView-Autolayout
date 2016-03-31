//
//  NSDate+Extension.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (NSDateComponents *)YMD_Components{
    NSCalendar *calendar = [NSCalendar calendarInChinese];
    NSDateComponents *ymdComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    return ymdComponents;
}
- (NSDateComponents *)YMDHMSW_Components{
    NSCalendar *calendar = [NSCalendar calendarInChinese];
    
    NSDateComponents *ymdhmsw_Components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit fromDate:self];
    
    return ymdhmsw_Components;
    
}
+ (NSDateFormatter *)dateFormatterInChineseTimeZoneWithFormatterString:(NSString *)formatterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat       = formatterString;
    dateFormatter.timeZone         = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    return dateFormatter;
}
+ (NSDate*)dateStrTransformToTimestamp:(NSString *)dateStr{
    NSDateFormatter *formatter = [NSDate dateFormatterInChineseTimeZoneWithFormatterString:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* timeSpDate     = [formatter dateFromString:dateStr];
   
    return timeSpDate;
}
+(NSString *)stringFromStamp:(NSNumber *)stamp {
    NSDateFormatter *formatter = [NSDate dateFormatterInChineseTimeZoneWithFormatterString:@"YYYY-MM-dd HH:mm"];
    NSDate* timeSpDate     = [NSDate dateWithTimeIntervalSince1970:stamp.doubleValue];

    return [formatter stringFromDate:timeSpDate];

}
+ (NSString *)weekDayNameForWeekDayNumber:(NSInteger)weekDay{
    NSString *weekDayString;
    // 周日 1  周一 2  周二 3 。。。周六 7
    switch (weekDay) {
        case 1:
            weekDayString = @"周日";
            break;
        case 2:
            weekDayString = @"周一";
            break;
        case 3:
            weekDayString = @"周二";
            break;
        case 4:
            weekDayString = @"周三";
            break;
        case 5:
            weekDayString = @"周四";
            break;
        case 6:
            weekDayString = @"周五";
            break;
        case 7:
            weekDayString = @"周六";
            break;
            
        default:
            break;
    }
    return weekDayString;
}
// 服务上门时间显示格式
- (NSString *)serviceTimeStringFromDate{
    NSString *serviceTimeStr ;
    
    NSDateComponents *dateCompt = [self YMDHMSW_Components];
    NSString *ymdStr = [NSString stringWithFormat:@"%4ld-%02ld-%02ld",(long)dateCompt.year,(long)dateCompt.month,(long)dateCompt.day];
    NSString *weekDayStr = [NSDate weekDayNameForWeekDayNumber:dateCompt.weekday];
    NSString *hmStr = [NSString stringWithFormat:@"%02ld:%02ld",(long)dateCompt.hour,(long)dateCompt.minute];
    
    serviceTimeStr = [NSString stringWithFormat:@"%@ %@ %@ 上门",ymdStr,weekDayStr,hmStr];
    return serviceTimeStr;
}

- (NSComparisonResult)ex_compareToDate:(NSDate *)date{
    NSTimeInterval time1 = [self timeIntervalSince1970];
    NSTimeInterval time2 = [date timeIntervalSince1970];
    
    NSComparisonResult result = time1>time2 ? NSOrderedDescending : (time1==time2 ? NSOrderedSame : NSOrderedAscending);
    
    return result;
}
@end
