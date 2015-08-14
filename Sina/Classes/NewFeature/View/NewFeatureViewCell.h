//
//  NewFeatureViewCell.h
//  Sina
//
//  Created by James on 3/8/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureViewCell : UICollectionViewCell

/** 暴露的属性,让调用者赋值 */
@property (nonatomic, strong) UIImage *image;

/** 判断时候是最后一页 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
