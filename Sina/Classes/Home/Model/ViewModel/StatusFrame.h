//
//  StatusFrame.h
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status;

@interface StatusFrame : NSObject

/** 微博数据 */
@property (nonatomic, strong) Status *status;

/** 原创微博frame */
@property (nonatomic, assign) CGRect originalViewFrame;

/****************	原创微博子控件frame   ****************/

// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图frame
@property (nonatomic, assign) CGRect originalPhotoFrame;

/** 转发微博frame */
@property (nonatomic, assign) CGRect retweetViewFrame;

/****************	转发微博子控件frame   ****************/

// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;

/****************	工具条frame   ****************/

@property (nonatomic, assign) CGRect tooBarFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
