//
//  OneViewController.m
//  Sina
//
//  Created by James on 3/8/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "OneViewController.h"
#import "SecondViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 20, 20);
    [btn addTarget:self action:@selector(jump2Second) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)jump2Second
{
    NSLog(@"%s", __func__);
    SecondViewController *second =[[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
