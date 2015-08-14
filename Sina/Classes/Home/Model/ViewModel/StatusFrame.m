//
//  StatusFrame.m
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

@implementation StatusFrame

///** 重写status的setter方法.给属性赋值 */
//- (void)setStatus:(Status *)status
//{
//    _status = status;
//    //计算原创微博frame
//    [self setUpOriginalViewFrame];
//    CGFloat toolBarY = CGRectGetMaxY(self.originalViewFrame);
//    if (status.retweeted_status) {
//        //计算转发微博的frame
//        [self setUpRetweetViewFrame];
//        toolBarY = CGRectGetMaxY(self.retweetViewFrame);
//    }
//    //计算工具条frame
//    CGFloat toolBarX = 0;
//    CGFloat toolBarW = kScreenW;
//    CGFloat toolBarH = 35;
//    self.tooBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
//    // 计算cell的高度
//    _cellHeight = CGRectGetMaxY(self.tooBarFrame);
//}
//
///** 计算原创微博frame */
//- (void)setUpOriginalViewFrame
//{
//    //头像
//    CGFloat imageX = kStatusCellMargin;
//    CGFloat imageY = imageX;
//    CGFloat imageWH = 35;
//    self.originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
//    
//    //昵称
//    CGFloat nameX = CGRectGetMaxX(self.originalIconFrame) + kStatusCellMargin;
//    CGFloat nameY = imageY;
//    CGSize nameSize = [self.status.user.name sizeWithAttributes:@{NSFontAttributeName:kNameFont}];
//    self.originalNameFrame = (CGRect){{nameX, nameY}, nameSize};
//    
//    // vip
//    if (self.status.user.vip) {
//        CGFloat vipX = CGRectGetMaxX(self.originalNameFrame) + kStatusCellMargin;
//        CGFloat vipY = nameY;
//        CGFloat vipWH = 14;
//        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
//    }
//    
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.originalNameFrame) + kStatusCellMargin * 0.5;
//    CGSize timeSize = [self.status.created_at sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
//    self.originalTimeFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(self.originalTimeFrame) + kStatusCellMargin;;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [self.status.source sizeWithAttributes:@{NSFontAttributeName:kNameFont}];
//    self.originalSourceFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
//    
//    //正文
//    CGFloat textX = imageX;
//    CGFloat textY = CGRectGetMaxY(self.originalIconFrame) + kStatusCellMargin;
//    CGFloat textW = kScreenW - 2 * kStatusCellMargin;
//    CGSize textSize = [self.status.text sizeWithFont:kNameFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
//    self.originalTextFrame = (CGRect){{textX, textY}, textSize};
//    
//    // 原创微博frame
//    CGFloat originalX = 0;
//    CGFloat originalY = 10;
//    CGFloat originalW = kScreenW;
//    CGFloat originalH = CGRectGetMaxY(self.originalTextFrame) + kStatusCellMargin;
//    self.originalViewFrame = (CGRect){{originalX, originalY}, {originalW, originalH}};
//    
//    // 配图
//    if (self.status.pic_urls.count) {
//        CGFloat photosX = kStatusCellMargin;
//        CGFloat photosY = CGRectGetMaxY(self.originalTextFrame) + kStatusCellMargin;
//        CGSize photoSize = [self photosSizeWithCount:self.status.pic_urls.count];
//        
//        self.originalPhotoFrame = (CGRect){{photosX, photosY}, photoSize};
//        originalH = CGRectGetMaxY(self.originalPhotoFrame) + kStatusCellMargin;
//    }
//}
//
///** 计算配图的尺寸 */
//- (CGSize)photosSizeWithCount:(NSInteger)count
//{
//    // 获取总列数
//    NSInteger cols = count == 4 ? 2 : 3;
//    // 总行数 = (总个数 - 1) / 总列数 + 1
//    NSInteger row = (count - 1) / cols + 1;
//    CGFloat photoWH = 70;
//    CGFloat w = cols * photoWH + (cols - 1) * kStatusCellMargin;
//    CGFloat h = row * photoWH + (row - 1) * kStatusCellMargin;
//    
//    return CGSizeMake(w, h);
//}
//
///** 转发微博 */
//- (void)setUpRetweetViewFrame
//{
//    // 昵称
//    CGFloat nameX = kStatusCellMargin;
//    CGFloat nameY = nameX;
//    CGSize nameSize = [self.status.retweeted_status.user.name sizeWithAttributes:@{NSFontAttributeName:kNameFont}];
//    self.retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};
//    
//    // 正文
//    CGFloat textX = nameX;
//    CGFloat textY = CGRectGetMaxY(self.retweetNameFrame) + kStatusCellMargin;
//    CGFloat textW = kScreenW - 2 * kStatusCellMargin;
//    CGSize textSize = [self.status.retweeted_status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
//    self.retweetTextFrame = (CGRect){{textX, textY}, textSize};
//    
//    // 原创微博frame
//    CGFloat retweetX = 0;
//    CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
//    CGFloat retweetW = kScreenW;
//    CGFloat retweetH = CGRectGetMaxY(self.retweetTextFrame) + kStatusCellMargin;
//    self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
//    
//    // 配图
//    NSInteger count = self.status.retweeted_status.pic_urls.count;
//    if (count) {
//        CGFloat photosX = kStatusCellMargin;
//        CGFloat photosY = CGRectGetMaxY(self.retweetTextFrame) + kStatusCellMargin;
//        CGSize photosSize = [self photosSizeWithCount:count];
//        self.retweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
//        retweetH = CGRectGetMaxY(self.retweetPhotosFrame) + kStatusCellMargin;
//    }
//}
//
//- (CGFloat)cellHeight
//{
//    return _cellHeight;
//}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = kScreenW;
    CGFloat toolBarH = 35;
    _tooBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_tooBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = kStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + kStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:kNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + kStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + kStatusCellMargin;
    
    CGFloat textW = kScreenW - 2 * kStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + kStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = kStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + kStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotoFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotoFrame) + kStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = kScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * kStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * kStatusCellMargin;
    
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = kStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:kNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + kStatusCellMargin;
    
    CGFloat textW = kScreenW - 2 * kStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + kStatusCellMargin;
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = kStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + kStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + kStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = kScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}

@end
