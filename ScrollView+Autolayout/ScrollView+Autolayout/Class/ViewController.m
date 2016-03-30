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

@interface ViewController ()

@property (nonatomic, weak) UIScrollView *backgroundScrollView;

@property (nonatomic, weak) ScrollBannerView *scrollBannerView;

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
    
}

// 设置控件约束关系
- (void)setUpConstraints{
    __weak typeof(self) weakSelf = self;
    [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.view);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        
    }];
    
    [self.scrollBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.backgroundScrollView);
        
    }];
    
}

- (void)setUpData{
    self.scrollBannerView.bannerListModel = [BannerListModel fakeModel];
}

@end
