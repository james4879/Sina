//
//  StatusViewCell.h
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;

@interface StatusViewCell : UITableViewCell

@property (nonatomic, strong) StatusFrame *statusFrame;

/** cell的重用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
