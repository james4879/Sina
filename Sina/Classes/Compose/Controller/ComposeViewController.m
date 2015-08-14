//
//  ComposeViewController.m
//  Sina
//
//  Created by James on 3/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ComposeViewController.h"
#import "TextView.h"
#import "ComposeToolBar.h"
#import "ComposePhotoView.h"
#import "MBProgressHUD+Extension.h"
#import "ComposeTool.h"

@interface ComposeViewController () <UITextViewDelegate, ComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) TextView *textView;

@property (nonatomic, weak) ComposeToolBar *toolBar;

@property (nonatomic, weak) ComposePhotoView *photoView;

@property (nonatomic, weak) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ComposeViewController

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];
    [self setUpTextView];
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册
    [self setUpPhotoView];
}

/** 添加相册view */
- (void)setUpPhotoView
{
    ComposePhotoView *photoView = [[ComposePhotoView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    self.photoView = photoView;
    [self.textView addSubview:photoView];
}

/** 监听键盘的frame的改变 */
- (void)keyboardFrameChange:(NSNotification *)notification
{
    // 获取键盘弹出的事件
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 获取键盘的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 判断是否弹出键盘
    if (frame.origin.y == self.view.height) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

/** 添加工具条 */
- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    ComposeToolBar *toolBar = [[ComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    [self.view addSubview:toolBar];
    toolBar.delegate = self;
    self.toolBar = toolBar;
}

/****************	compose delegate method   ****************/
- (void)composeToolBar:(ComposeToolBar *)toolBar didClickBtnAtIndex:(NSInteger)index
{
    if (index == 1) {
        // 弹出相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // 设置相册类型
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

/****************	imagePicker delegate   ****************/
/** 选择图片完成的时候调用 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    self.photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    self.rightItem.enabled = YES;
}

/** 添加textView */
- (void)setUpTextView
{
    TextView *textView = [[TextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    self.textView = textView;
    textView.placeHolder = @"abc";
    textView.font = [UIFont systemFontOfSize:18];
    // 拖拽方向
    textView.alwaysBounceVertical = YES;
    // 观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    textView.delegate = self;
}

- (void)textChange
{
    // 判断textView是否有值
    if (self.textView.text.length) {
        self.textView.hidePlaceHolder = YES;
        self.rightItem.enabled = YES;
    } else {
        self.textView.hidePlaceHolder = NO;
        self.rightItem.enabled = NO;
    }
}

/** 移除监听 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 获取第一响应者 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

/****************	UITextView delegate method   ****************/

/** 开始拖拽 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/** 设置导航栏按钮 */
- (void)setUpNavigationBar
{
    self.title = @"发微博";
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    // rigth
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.rightItem = rightItem;
}

/** 发送微博 */
- (void)compose
{
    if (self.images.count) {
        [self sendPicture];
    } else {
        [self sendCompose];
    }
}

/** 取消 */
- (void)dismiss
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 发送文字 */
- (void)sendCompose
{
    [ComposeTool composeWithStatus:self.textView.text success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

/** 发送图片 */
- (void)sendPicture
{
    UIImage *image = self.images[0];
    NSString *status = self.textView.text.length ? self.textView.text:@"分享图片";
    self.rightItem.enabled = YES;
    [ComposeTool composeWithStatus:status image:image success:^{
        [MBProgressHUD showSuccess:@"发送图片成功"];
        // 回到主页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
        [MBProgressHUD showError:@"发送图片失败"];
        self.rightItem.enabled = YES;
    }];
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
