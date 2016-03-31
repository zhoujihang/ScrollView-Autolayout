//
//  ProjectCellView.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ProjectCellView.h"
#import <Masonry/Masonry.h>
#import "UIImage+Extension.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ProjectCellView()

@property (nonatomic, weak) UIImageView *iconImgView;

@property (nonatomic, weak) UILabel *titleLabel;
// 解决高度约束冲突的控件
@property (nonatomic, weak) UILabel *flexibleLabel;
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
    [self resizeBounds];
}

// 创建视图控件
- (void)setUpViews{
    UIImageView *iconImgView = [[UIImageView alloc] init];
    [self addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor getColor:@"333333"];
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *flexibleLabel = [[UILabel alloc] init];
    [self addSubview:flexibleLabel];
    self.flexibleLabel = flexibleLabel;
    
}
// 设置控件约束关系
- (void)setUpConstraints{
    __weak typeof(self) weakSelf = self;
    CGFloat padding = 12;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
        make.centerX.equalTo(self);
        make.bottom.equalTo(weakSelf.titleLabel.mas_top).offset(-4);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(18));
        make.bottom.equalTo(weakSelf.flexibleLabel.mas_top).offset(-8);
    }];
    
    [self.flexibleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}
// 根据内容重设bounds
- (void)resizeBounds{
    self.bounds = CGRectMake(0, 0, 1000, 1000);
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

- (void)setArrangeCellModel:(ArrangeCellModel *)arrangeCellModel{
    _arrangeCellModel = arrangeCellModel;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_arrangeCellModel.imageUrl]];
    self.titleLabel.text = _arrangeCellModel.title;
}

@end
