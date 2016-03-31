//
//  NSCalendar+Extension.m
//  Ayibang
//
//  Created by 周际航 on 15/12/16.
//  Copyright © 2015年 ayibang. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)

+ (NSCalendar *)calendarInChinese{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 设置地区
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 设置时区
    calendar.timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];;
    
    return calendar;
}

@end
