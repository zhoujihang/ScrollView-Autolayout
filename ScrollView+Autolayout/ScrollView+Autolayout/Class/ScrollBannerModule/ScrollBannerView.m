//
//  ScrollBannerView.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/7/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "ScrollBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Extension.h"
static CGFloat kScale_HW = 112/375.0; // 固定的 高:宽 的值
@interface ScrollBannerView() <UIScrollViewDelegate>
// 约束属性
// 滚动视图的宽度属性
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidthCons;
// 滚动视图的高度属性
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightCons;

// 控件属性
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
// 当前显示的图片索引
@property (nonatomic, assign) NSInteger currentImageIndex;
@end

@implementation ScrollBannerView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self resizeBounds];
    [self setUpViews];
}
- (void)setUpViews{
    for (int i=0; i<3; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self.scrollView addSubview:imgView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFunction:)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tapGesture];
    }
    self.scrollView.delegate       = self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*3, self.scrollView.height);
    for (int i=0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imgView = self.scrollView.subviews[i];
        imgView.frame = CGRectMake(self.width*i, 0, self.width, self.height);
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
}
- (void)resizeBounds{
    self.bounds = CGRectMake(0, 0, 1000, 1000);
    self.scrollViewWidthCons.constant = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.width * kScale_HW;
    height = ((CGFloat)((int)(height*10)))/10;  // 只取小数后一位的精度，避免约束冲突
    self.scrollViewHeightCons.constant = height;
    
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    
}

- (void)setBannerListModel:(BannerListModel *)bannerListModel{
    if (bannerListModel.bannerArr.count == 0) return;
    _bannerListModel = bannerListModel;
    self.pageControl.numberOfPages = self.bannerListModel.bannerArr.count;
    self.pageControl.currentPage = 0;
    self.currentImageIndex = 0;
    [self addTimer];
    [self resizeBounds];
}

#pragma mark - 图片点击方法
- (void)tapFunction:(UITapGestureRecognizer *)tapGesture{
    ProjectCommonModel *bannerModel = self.bannerListModel.bannerArr[self.currentImageIndex];
    if ([self.delegate respondsToSelector:@selector(scrollBannerViewClickedImgWithBannerModel:)]) {
        [self.delegate scrollBannerViewClickedImgWithBannerModel:bannerModel];
    }
}

#pragma mark - scrollview 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    if (offsetX == self.scrollView.width*2 || offsetX == 0) {
        [self resetScrollViewContentOffset];
    }
}
// 重置contentOffset,让其指向中间的图片
- (void)resetScrollViewContentOffset{
    CGPoint offsetPoint = self.scrollView.contentOffset;
    NSInteger currentImageIndex = self.currentImageIndex;
    if (offsetPoint.x == 0) {
        // 左滑
        currentImageIndex = currentImageIndex-1 >= 0 ? currentImageIndex-1 : self.bannerListModel.bannerArr.count-1;
    }else if (offsetPoint.x == self.scrollView.width*2){
        // 右滑
        currentImageIndex = currentImageIndex+1 >= self.bannerListModel.bannerArr.count ? 0 : currentImageIndex+1;
    }
    self.currentImageIndex = currentImageIndex;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0) animated:NO];
}

// 设置当前展示图片的索引，切换了3个图片视图的图片内容和pagecontrol的索引
- (void)setCurrentImageIndex:(NSInteger)currentImageIndex{
    _currentImageIndex = currentImageIndex;
    UIImageView *imageView0 = self.scrollView.subviews[0];
    UIImageView *imageView1 = self.scrollView.subviews[1];
    UIImageView *imageView2 = self.scrollView.subviews[2];
    
    NSInteger imageIndex0 = currentImageIndex-1 >= 0 ? currentImageIndex-1 : self.bannerListModel.bannerArr.count-1;
    NSInteger imageIndex1 = currentImageIndex;
    NSInteger imageIndex2 = currentImageIndex+1 >= self.bannerListModel.bannerArr.count ? 0 : currentImageIndex+1;
    
    ProjectCommonModel *banner0 = self.bannerListModel.bannerArr[imageIndex0];
    ProjectCommonModel *banner1 = self.bannerListModel.bannerArr[imageIndex1];
    ProjectCommonModel *banner2 = self.bannerListModel.bannerArr[imageIndex2];
    NSURL *imageUrl0 = [NSURL URLWithString:banner0.image];
    NSURL *imageUrl1 = [NSURL URLWithString:banner1.image];
    NSURL *imageUrl2 = [NSURL URLWithString:banner2.image];
    [imageView0 sd_setImageWithURL:imageUrl0];
    [imageView1 sd_setImageWithURL:imageUrl1];
    [imageView2 sd_setImageWithURL:imageUrl2];
    
    self.pageControl.currentPage = currentImageIndex;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
#pragma mark - 定时器相关代码
- (void)addTimer{
    if (self.timer) {
        [self removeTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerTask) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerTask{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width*2, 0) animated:YES];
}
@end
