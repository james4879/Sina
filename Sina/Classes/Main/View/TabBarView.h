//
//  TabBarView.h
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarView;

@protocol TabBarViewDelegate <NSObject>

@optional
- (void)tabBar:(TabBarView *)tabBar didClickAtIndex:(NSInteger)index;

/** 点击加号按钮 */
- (void)tabBarDidClickPlusButton:(TabBarView *)tabBar;

@end

@interface TabBarView : UIView

/** 保存tabbarItem按钮模型 */
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) id <TabBarViewDelegate> delegate;

@end
