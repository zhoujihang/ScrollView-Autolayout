//
//  ScheduleUnitView.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleUnitModel.h"

@interface ScheduleUnitView : UIView

@property (nonatomic, strong) ScheduleUnitModel *model;
// 视图是否未被预约 yes ： 未被预约  no：被预约
@property (nonatomic, assign) BOOL isEmpty;

@end
