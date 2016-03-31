//
//  AyiDetailAndScheduleModel.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "AyiDetailAndScheduleModel.h"
#import <MJExtension/MJExtension.h>
@implementation AyiDetailAndScheduleModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ayiScheduleArr" : @"resources"
             };
    
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"ayiScheduleArr" : [AyiScheduleOneDayModel class]
             };
}

+ (AyiDetailAndScheduleModel *)fakeModel{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AyiScheduleJson" ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    AyiDetailAndScheduleModel *model = [AyiDetailAndScheduleModel mj_objectWithKeyValues:jsonString];
    return model;
}


@end
