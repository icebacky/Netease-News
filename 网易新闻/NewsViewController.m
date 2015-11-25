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

@interface NewsViewController ()

/** 标题滚动视图 */
@property (nonatomic, weak) UIScrollView *titleScrollView;
/** 内容滚动视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTitleScrollView];
    
    [self setUpContentScrollView];
    
    [self setUpAllChildViewController];
    
}

// 1.添加标题滚动视图
- (void)setUpTitleScrollView {
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    
    CGFloat titleX = 0;
    CGFloat titleY = self.navigationController ? navBarH : 0;
    CGFloat titleW = screenW;
    CGFloat titleH = titleScrollViewH;
    
    titleScrollView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    titleScrollView.backgroundColor = [UIColor redColor];
    
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
    contentScrollView.backgroundColor = [UIColor blueColor];
    
    _titleScrollView = contentScrollView;
    [self.view addSubview:contentScrollView];
    
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

@end
