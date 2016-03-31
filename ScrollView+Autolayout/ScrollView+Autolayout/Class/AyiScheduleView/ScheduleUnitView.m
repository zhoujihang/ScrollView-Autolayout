//
//  ScheduleUnitView.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/8/7.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "ScheduleUnitView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface ScheduleUnitView()

@property (nonatomic, weak) UILabel *timeLabel;
// 背景图片
@property (nonatomic, weak) UIImageView *bgImgView;

@end

@implementation ScheduleUnitView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *bgImgView = [[UIImageView alloc]init];
        [self addSubview:bgImgView];
        self.bgImgView = bgImgView;
        
        UILabel *timeLabel      = [[UILabel alloc]init];
        // CourierNewPSMT 该字体很细
//        UIFont *font = [UIFont fontWithName:@"CourierNewPSMT" size:12];
        UIFont *font            = [UIFont systemFontOfSize:12];
        timeLabel.font          = font;
        timeLabel.textColor     = [UIColor getColor:@"666666"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        self.timeLabel          = timeLabel;

    }
    return self;
}

- (void)setModel:(ScheduleUnitModel *)model{
    _model = model;
    
    if (model.isFree) {
        self.isEmpty = YES;
        self.timeLabel.textColor = [UIColor getColor:@"666666"];
    }else{
        self.isEmpty = NO;
        self.timeLabel.textColor = [UIColor whiteColor];
    }
    self.timeLabel.text = model.hour;
    
}

- (void)setIsEmpty:(BOOL)isEmpty{
    _isEmpty = isEmpty;
    
    self.bgImgView.image = [self imageWithSize:self.size isEmpty:isEmpty];
}

- (UIImage *)imageWithSize:(CGSize)size isEmpty:(BOOL)isEmpty{
    UIImage *img;
    static UIImage *emptyImage;
    static UIImage *fullImage;
    
    img = isEmpty ? emptyImage : fullImage;
    if (!img) {
        // 开启位图上下文
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        // 取得当前上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // 画圆形边框
        UIColor *borderColor = [UIColor getColor:@"D6D6D6"];
        [borderColor set];
        CGContextSetLineWidth(ctx,1/[UIScreen mainScreen].scale);
        
        CGFloat radius = size.width * 0.5 - 1/[UIScreen mainScreen].scale; // 圆半径
        CGFloat centerX = size.width * 0.5; // 圆心
        CGFloat centerY = size.width * 0.5;
        CGContextAddArc(ctx, centerX, centerY, radius, 0, M_PI * 2, 0);
        if (isEmpty) {
            CGContextStrokePath(ctx); // 画空心圆
            emptyImage = UIGraphicsGetImageFromCurrentImageContext();
        }else{
            CGContextFillPath(ctx);   // 画实心圆
            fullImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        // 关闭上下文
        UIGraphicsEndImageContext();
    }
    img = isEmpty ? emptyImage : fullImage;
    return img;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgImgView.frame = self.bounds;
    self.timeLabel.frame = self.bounds;
    
    // 对大量子控件使用这个会拖慢应用程序，导致明显的卡顿
//    self.layer.cornerRadius = self.width/2;
//    self.layer.masksToBounds = YES;
}
@end
