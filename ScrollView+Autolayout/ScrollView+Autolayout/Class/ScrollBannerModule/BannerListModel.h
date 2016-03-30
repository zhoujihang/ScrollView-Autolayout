//
//  BannerListModel.h
//  Ayibang
//
//  Created by 周际航 on 15/10/8.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//


#import <MJExtension/MJExtension.h>
@interface BannerListModel : NSObject

@property (nonatomic, strong) NSMutableArray *bannerArr;

+ (BannerListModel *)fakeModel;

@end

@interface ProjectCommonModel : NSObject

// 广告图片url
@property (nonatomic, copy) NSString *image;

@end

