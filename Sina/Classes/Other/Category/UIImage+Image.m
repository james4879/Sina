//
//  UIImage+image.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

/** 生成没有被系统渲染的图片 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/** 拉伸图片 */
+ (UIImage *)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
