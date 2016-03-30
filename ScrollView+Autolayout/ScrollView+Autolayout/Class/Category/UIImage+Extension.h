//
//  UIImage+Extension.h
//  Ayibang
//
//  Created by 阿姨帮 on 15/7/8.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
