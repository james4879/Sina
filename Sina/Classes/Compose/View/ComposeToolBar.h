//
//  ComposeToolBar.h
//  Sina
//
//  Created by James on 3/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComposeToolBar;

@protocol ComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(ComposeToolBar *)toolBar didClickBtnAtIndex:(NSInteger)index;

@end

@interface ComposeToolBar : UIView

@property (nonatomic, weak) id <ComposeToolBarDelegate> delegate;

@end
