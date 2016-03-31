//
//  ViewController.m
//  ScrollView+Autolayout
//
//  Created by 周际航 on 16/3/29.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ScrollBannerView.h"
#import "AyiScheduleView.h"
#import "ArrangeCellView.h"
@interface ViewController ()

@property (nonatomic, weak) UIScrollView *backgroundScrollView;

@property (nonatomic, weak) ScrollBannerView *scrollBannerView;

@property (nonatomic, weak) ArrangeCellView *arrangeCellView;

@property (nonatomic, weak) AyiScheduleView *ayiScheduleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    [self setUpConstraints];
    [self setUpData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
// 创建视图控件
- (void)setUpViews{
    
    UIScrollView *backgroundScrollView = [[UIScrollView alloc] init];
    backgroundScrollView.alwaysBounceVertical = YES;
    backgroundScrollView.alwaysBounceHorizontal = NO;
    backgroundScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:backgroundScrollView];
    self.backgroundScrollView = backgroundScrollView;
    
    ScrollBannerView *scrollBannerView = [[[NSBundle mainBundle] loadNibNamed:@"ScrollBannerView" owner:nil options:nil] firstObject];
    [self.backgroundScrollView addSubview:scrollBannerView];
    self.scrollBannerView = scrollBannerView;
    
    ArrangeCellView *arrangeCellView = [[ArrangeCellView alloc] init];
    [self.backgroundScrollView addSubview:arrangeCellView];
    self.arrangeCellView = arrangeCellView;
    
    AyiScheduleView *ayiScheduleView = [[[NSBundle mainBundle] loadNibNamed:@"AyiScheduleView" owner:nil options:nil] firstObject];
    [self.backgroundScrollView addSubview:ayiScheduleView];
    self.ayiScheduleView = ayiScheduleView;
}

// 设置控件约束关系
- (void)setUpConstraints{
    __weak typeof(self) weakSelf = self;
    CGFloat padding = 12;
    [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.view);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    [self.scrollBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.backgroundScrollView);
    }];
    
    [self.arrangeCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollBannerView.mas_bottom);
        make.left.right.equalTo(weakSelf.backgroundScrollView);
    }];
    
    [self.ayiScheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.arrangeCellView.mas_bottom).offset(padding);
        make.left.right.equalTo(weakSelf.backgroundScrollView);
        make.bottom.equalTo(weakSelf.backgroundScrollView).offset(-padding);
    }];
    
}

- (void)setUpData{
    __weak typeof(self) weakSelf = self;
    self.scrollBannerView.bannerListModel = [BannerListModel fakeModel];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.arrangeCellView.arrangeCellModelList = [ArrangeCellModelList fakeModel];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.ayiScheduleView.ayiDetailAndScheduleModel = [AyiDetailAndScheduleModel fakeModel];
    });
}

@end
