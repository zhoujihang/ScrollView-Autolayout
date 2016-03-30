//
//  UIImage+Extension.m
//  Ayibang
//
//  Created by 阿姨帮 on 15/7/8.
//  Copyright (c) 2015年 ayibang. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGSize size = CGSizeMake(1, 1);
    return [self imageWithColor:color size:size];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
