//
//  NewFeatureViewController.m
//  Sina
//
//  Created by James on 3/8/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "NewFeatureViewCell.h"

@interface NewFeatureViewController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置属性
    flow.itemSize = [UIScreen mainScreen].bounds.size;
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.collectionView registerClass:[NewFeatureViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //collection的属性
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //设置pageControl
    [self setUpPageControl];
}

/** 设置pageControl */
- (void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

/****************	collection view controller data source   ****************/

/** 多少组 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/** 多少行 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

/** cell数据 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewFeatureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CGFloat screentH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    if (screentH > 480) {
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h", indexPath.row + 1];
    }
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndexPath:indexPath count:4];
    return cell;
}

/****************	scroll view delegate method   ****************/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    self.pageControl.currentPage = page;
}

@end
