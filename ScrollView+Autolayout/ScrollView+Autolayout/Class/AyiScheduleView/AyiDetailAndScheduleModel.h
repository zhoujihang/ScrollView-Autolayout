//
//  AyiDetailAndScheduleModel.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AyiScheduleOneDayModel.h"

@interface AyiDetailAndScheduleModel : NSObject

@property (nonatomic, strong) NSArray *ayiScheduleArr;

+ (AyiDetailAndScheduleModel *)fakeModel;

@end
