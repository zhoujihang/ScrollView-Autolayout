//
//  NSDate+Extension.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCalendar+Extension.h"
@interface NSDate (Extension)

// 返回 年月日 的日期模型
- (NSDateComponents *)YMD_Components;
// 返回 年月日 时分秒 星期 的日期模型
- (NSDateComponents *)YMDHMSW_Components;
// 返回使用本地timezone的日期格式类
+ (NSDateFormatter *)dateFormatterInChineseTimeZoneWithFormatterString:(NSString *)formatterString;
// 将2015-08-11 12:24:36 类型的时间 转换为时间戳
+ (NSDate *)dateStrTransformToTimestamp:(NSString*)dateStr;

+ (NSString *)weekDayNameForWeekDayNumber:(NSInteger)weekDay;

// 服务上门时间显示格式
- (NSString *)serviceTimeStringFromDate;
/**
 *  从时间戳中获取 YYYY-MM-dd HH:mm 类型时间
 *
 *  @param stamp 时间戳
 *
 *  @return 时间戳代表的时间字符串
 */
+(NSString *)stringFromStamp:(NSNumber *)stamp;

/**
 *  比较两个时间的大小
 *
 *  @param date
 *
 *  @return [今天 ex_compareToDate:明天] 返回 NSOrderedAscending
 */
- (NSComparisonResult)ex_compareToDate:(NSDate *)date;

@end
