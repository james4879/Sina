//
//  UIImage+image.h
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

/** 生成没有被渲染的图片 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/** 拉伸图片 */
+ (UIImage *)imageWithStretchableName:(NSString *)imageName;

@end
