//
//  ArrangeCellView.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ArrangeCellView.h"
#import "ProjectCellView.h"
#import "UIView+Extension.h"
#import <Masonry/Masonry.h>
@interface ArrangeCellView()

@property (nonatomic, assign) CGFloat oneCellHeight;

@end

@implementation ArrangeCellView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    
    ProjectCellView *cellView = [[ProjectCellView alloc] init];
    self.oneCellHeight = cellView.height;
}

- (void)setArrangeCellModelList:(ArrangeCellModelList *)arrangeCellModelList{
    _arrangeCellModelList = arrangeCellModelList;
    [self createCellViews];
    [self setUpFrame];
    // 告诉系统重新计算 intrinsicContentSize
    [self invalidateIntrinsicContentSize];
}
// 删除原来的视图
- (void)clearCellViews{
    while (self.subviews.count>0) {
        UIView *view = self.subviews.firstObject;
        [view removeFromSuperview];
    }
}
// 创建视图控件
- (void)createCellViews{
    [self clearCellViews];
    
    for (int i=0; i<self.arrangeCellModelList.modelMArr.count; i++) {
        ArrangeCellModel *cellModel = self.arrangeCellModelList.modelMArr[i];
        ProjectCellView *cellView = [[ProjectCellView alloc] init];
        cellView.arrangeCellModel = cellModel;
        [self addSubview:cellView];
    }
}
// 设置控件约束关系
- (void)setUpFrame{
    NSInteger maxColumn = 4;
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width/maxColumn;
    CGFloat cellHeight = self.oneCellHeight;
    for (int i=0; i<self.subviews.count; i++) {
        UIView *cell = self.subviews[i];
        
        NSInteger x = i%maxColumn;
        NSInteger y = i/maxColumn;
        
        CGFloat cellX = x * cellWidth;
        CGFloat cellY = y *cellHeight;
        cell.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    }
}
- (CGFloat)viewHeight{
    UIView *lastCell = self.subviews.lastObject;
    CGFloat maxY = lastCell==nil ? self.oneCellHeight : CGRectGetMaxY(lastCell.frame);
    return maxY;
}
- (CGSize)intrinsicContentSize{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [self viewHeight]);
    return size;
}

@end
