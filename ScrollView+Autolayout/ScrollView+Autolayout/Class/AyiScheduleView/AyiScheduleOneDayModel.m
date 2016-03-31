//
//  AyiScheduleOneDay.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "AyiScheduleOneDayModel.h"

@implementation AyiScheduleOneDayModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ymd" : @"date",
             @"scheduleUnitArr" : @"schedule"
             };
}

+ (NSDictionary *)objectClassInArray{
    return @{@"scheduleUnitArr":[ScheduleUnitModel class]};
}



@end

