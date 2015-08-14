//
//  CoverView.h
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoverView;

@protocol CoverViewDelegate <NSObject>

@optional
- (void)coverViewDidCover:(CoverView *)cover;

@end

@interface CoverView : UIView

/** 显示 */
+ (instancetype)show;

/** 设置显示 */
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id <CoverViewDelegate> delegate;

@end
