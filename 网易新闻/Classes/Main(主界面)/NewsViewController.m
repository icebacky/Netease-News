//
//  NewsViewController.m
//  网易新闻
//
//  Created by 韩啸宇 on 15/11/25.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "NewsViewController.h"
#import "UIView+Frame.h"

#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocietyViewController.h"
#import "SubscribeViewController.h"
#import "ScienceViewController.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

static const CGFloat navBarH = 64; // 导航栏高度
static const CGFloat titleScrollViewH = 44; // 标题滚动视图高度
static CGFloat const transformScale = 1.3; // 按钮缩放比例

@interface NewsViewController () <UIScrollViewDelegate>

/** 标题滚动视图 */
@property (nonatomic, weak) UIScrollView *titleScrollView;
/** 内容滚动视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;

/** 当前选定的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

/** 保存所有按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加标题滚动视图
    [self setUpTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setUpContentScrollView];
    
    // 3.添加所有的子控制器
    [self setUpAllChildViewController];
    
    // 4.添加标题按钮
    [self setUpButtonTitle];
    
    // 5.取消额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark - lazy

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

#pragma mark - 初始化控件
// 1.添加标题滚动视图
- (void)setUpTitleScrollView {
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    
    CGFloat titleX = 0;
    CGFloat titleY = self.navigationController ? navBarH : 0;
    CGFloat titleW = screenW;
    CGFloat titleH = titleScrollViewH;
    
    titleScrollView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    _titleScrollView = titleScrollView;
    [self.view addSubview:titleScrollView];
}

// 2.添加内容滚动视图
- (void)setUpContentScrollView {
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    CGFloat contentX = 0;
    CGFloat contentY = CGRectGetMaxY(_titleScrollView.frame);
    CGFloat contentW = screenW;
    CGFloat contentH = screenH - contentY;
    
    contentScrollView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    contentScrollView.backgroundColor = [UIColor lightGrayColor];
    
    _contentScrollView = contentScrollView;
    [self.view addSubview:contentScrollView];
    
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
}

// 3.添加所有子控制器
- (void)setUpAllChildViewController {
    // 头条
    TopLineViewController *topLineVc = [[TopLineViewController alloc] init];
    topLineVc.title = @"头条";
    [self addChildViewController:topLineVc];
    
    // 热点
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 视频
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 社会
    SocietyViewController *societyVc = [[SocietyViewController alloc] init];
    societyVc.title = @"社会";
    [self addChildViewController:societyVc];
    
    // 订阅
    SubscribeViewController *readerVc = [[SubscribeViewController alloc] init];
    readerVc.title = @"订阅";
    [self addChildViewController:readerVc];
    
    // 科技
    ScienceViewController *scienceVc = [[ScienceViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
}

// 4.添加按钮
- (void)setUpButtonTitle {
    CGFloat buttonW = 100;
    CGFloat buttonH = titleScrollViewH;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    // 遍历所有子控制器
    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
        // 按钮文字颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 按钮标题
        [button setTitle:vc.title forState:UIControlStateNormal];
        
        // 动态计算按钮frame
        buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 按钮点击
        if (0 == i) {
            [self buttonClick:button];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_titleScrollView addSubview:button];
        
        // 保存到数组
        [self.buttons addObject:button];
    }
    
    // 标题和内容滚动视图的contentSize, 隐藏水平指示器
    _titleScrollView.contentSize = CGSizeMake(buttonW * count, 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    
    _contentScrollView.contentSize = CGSizeMake(screenW * count, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 逻辑操作
// 按钮点击
- (void)buttonClick:(UIButton *)button
{
    [self selectButton:button];
    
    NSInteger i = button.tag;
    CGFloat offsetX = i * screenW;
    [self showVcView:offsetX];
    
    // 滚动到对应的view
    [_contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
}

// 选中按钮
- (void)selectButton:(UIButton *)button
{
    // 还原上一个按钮
    [_selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 还原尺寸
    _selectedButton.transform = CGAffineTransformIdentity;
    
    // 记录选中按钮
    _selectedButton = button;
    
    // 选中按钮处理
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 让选中的按钮居中
    [self setButtonAtCenter:button];
    // 让选中的按钮方法
    button.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

// 让选中的按钮居中显示
- (void)setButtonAtCenter:(UIButton *)button
{
    // 设置标题滚动区域偏移量
    CGFloat offsetX = button.centerX - screenW * 0.5;
    
    // 偏移量的最大最小值(最初和最末尾)
    CGFloat maxOffsetX = _titleScrollView.contentSize.width - screenW;
    CGFloat minOffsetX = 0;
    // 开头和末尾的按钮不要居中, 不好看
    offsetX = offsetX < minOffsetX ? minOffsetX : offsetX;
    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;
    
    // 滚动区域
    [_titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

// 显示控制器view
- (void)showVcView:(CGFloat)offsetX
{
    // 取出对应控制器的view添加到内容滚动视图上去
    NSUInteger index = offsetX / screenW;
    UIViewController *showVc = self.childViewControllers[index];
    
    // 判断下当前控制器有没有加载完成
    if (showVc.isViewLoaded) return;
    
    CGFloat showX = index * screenW;
    CGFloat showY = 0;
    CGFloat showW = screenW;
    CGFloat showH = _contentScrollView.height;
    showVc.view.frame = CGRectMake(showX, showY, showW, showH);
    
    [_contentScrollView addSubview:showVc.view];
}

#pragma mark - UIScrollViewDelegate
// 停止减速后, 选中对应按钮, 添加对应控制器view
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取最新偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前滚动的页码
    NSUInteger page = offsetX / screenW;
    
    // 选中按钮
    [self selectButton:_buttons[page]];
    
    // 跳转
    [self showVcView:offsetX];
}

// 监听scrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 偏左的按钮
    NSUInteger indexL = offsetX / screenW;
    UIButton *leftButton = _buttons[indexL];
    
    // 右边的按钮
    NSUInteger indexR = indexL + 1;
    UIButton *rightButton = indexR < _buttons.count ? _buttons[indexR] : nil;

    CGFloat rightScale = offsetX / screenW - indexL;
    CGFloat leftScale = 1 - rightScale;
    
    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
    rightButton.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
    
    // 颜色渐变
    // 右边按钮 -> 黑色 -> 红色  R: 0 ~ 1
    UIColor *rightColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    // 左边按钮 -> 红色 -> 黑色  R: 1 ~ 0
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
}
@end
