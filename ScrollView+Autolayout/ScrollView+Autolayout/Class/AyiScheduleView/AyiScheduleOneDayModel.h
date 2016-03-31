//
//  AyiScheduleOneDay.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleUnitModel.h"

@interface AyiScheduleOneDayModel : NSObject

@property (nonatomic, copy) NSString *ymd;

@property (nonatomic, strong) NSArray *scheduleUnitArr;

@end

