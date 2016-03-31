//
//  ArrangeCellModelList.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ArrangeCellModelList.h"
#import <MJExtension/MJExtension.h>
@implementation ArrangeCellModelList

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"modelMArr" : [ArrangeCellModel class]
             };
}

+ (instancetype)fakeModel{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArrangeCellJson" ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    ArrangeCellModelList *model = [ArrangeCellModelList mj_objectWithKeyValues:jsonString];
    return model;
}

@end


@implementation ArrangeCellModel



@end