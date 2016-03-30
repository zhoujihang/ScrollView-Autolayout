//
//  ScrollBannerView.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/7/24.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerListModel.h"
@protocol ScrollBannerViewDelegate <NSObject>

- (void)scrollBannerViewClickedImgWithBannerModel:(ProjectCommonModel *)bannerModel;

@end

@interface ScrollBannerView : UIView

@property (nonatomic, weak) id<ScrollBannerViewDelegate> delegate;

@property (nonatomic, strong) BannerListModel *bannerListModel;

@end
