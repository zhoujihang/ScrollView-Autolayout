//
//  BannerListModel.m
//  Ayibang
//
//  Created by 周际航 on 15/10/8.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "BannerListModel.h"

@implementation BannerListModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"bannerArr" : @"banners"
             };
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"bannerArr" : [ProjectCommonModel class]
             };
}

+ (BannerListModel *)fakeModel{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BannerJson" ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    BannerListModel *model = [BannerListModel mj_objectWithKeyValues:jsonString];
    return model;
}
@end

@implementation ProjectCommonModel


@end

