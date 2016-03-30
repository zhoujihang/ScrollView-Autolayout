//
//  ProjectCellView.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ProjectCellView.h"
#import <Masonry/Masonry.h>
@interface ProjectCellView()

@property (nonatomic, weak) UIImageView *iconImgView;

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ProjectCellView

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
    [self setUpViews];
    [self setUpConstraints];
}

// 创建视图控件
- (void)setUpViews{
    UIImageView *iconImgView = [[UIImageView alloc] init];
    [self addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
}
// 设置控件约束关系
- (void)setUpConstraints{
    __weak typeof(self) weakSelf = self;
    CGFloat padding = 12;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
        make.centerX.equalTo(self);
        make.bottom.equalTo(weakSelf.titleLabel.mas_top).offset(-4);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(18));
        make.bottom.equalTo(weakSelf).offset(-8);
    }];
}
@end
