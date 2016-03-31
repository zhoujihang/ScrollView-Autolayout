//
//  NSCalendar+Extension.h
//  Ayibang
//
//  Created by 周际航 on 15/12/16.
//  Copyright © 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (Extension)

/**
 *  提供中国时区的日历
 *
 *  @return 中国时区的日历
 */
+ (NSCalendar *)calendarInChinese;

@end
