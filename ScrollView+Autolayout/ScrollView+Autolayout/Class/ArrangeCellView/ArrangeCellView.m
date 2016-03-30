//
//  ArrangeCellView.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ArrangeCellView.h"
#import "ProjectCellView.h"

#import <Masonry/Masonry.h>
@interface ArrangeCellView()


@property (nonatomic, strong) NSMutableArray *projectCellMArr;

@end

@implementation ArrangeCellView

- (void)setArrangeCellModelList:(ArrangeCellModelList *)arrangeCellModelList{
    _arrangeCellModelList = arrangeCellModelList;
    [self createCellViews];
    [self setUpConstraints];
}
// 删除原来的视图
- (void)clearCellViews{
    for (int i=0; i<self.projectCellMArr.count; i++) {
        UIView *view = self.projectCellMArr[i];
        [view removeFromSuperview];
    }
    self.projectCellMArr = [@[] mutableCopy];
}
// 创建视图控件
- (void)createCellViews{
    [self clearCellViews];
    
    for (int i=0; i<self.arrangeCellModelList.modelMArr.count; i++) {
        ArrangeCellModel *cellModel = self.arrangeCellModelList.modelMArr[i];
        ProjectCellView *cellView = [[ProjectCellView alloc] init];
        cellView.arrangeCellModel = cellModel;
        [self.projectCellMArr addObject:cellView];
        [self addSubview:cellView];
    }
}
// 设置控件约束关系
- (void)setUpConstraints{
    __weak typeof(self) weakSelf = self;
    
    
    
}
@end
