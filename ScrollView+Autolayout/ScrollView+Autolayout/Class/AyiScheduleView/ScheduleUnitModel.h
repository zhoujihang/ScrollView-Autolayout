//
//  ScheduleUnitModel.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleUnitModel : NSObject

// 是否有空
@property (nonatomic, assign) BOOL isFree;
// 小时
@property (nonatomic, copy) NSString *hour;


@end
