//
//  ArrangeCellModelList.h
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrangeCellModelList : NSObject

@property (nonatomic, strong) NSMutableArray *modelMArr;

+ (instancetype)fakeModel;

@end

@interface ArrangeCellModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *title;

@end

