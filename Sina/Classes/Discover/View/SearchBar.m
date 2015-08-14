//
//  SearchBar.m
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        //设置左边的图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.width += 20;
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        //显示输入框的左边的内容要设置左边的视图模式
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
