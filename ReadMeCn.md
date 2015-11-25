#网易新闻
## 项目结构
---
```
<NavigationController>
	<!--导航栏-->
	<NavigationBar>
		title = @"网易新闻"
	</NavigationBar>
	
	<!--主界面-->
	<MainVc.View>
		<TitleView Type="UScrollView">
			<Button>title=@"头条"</Button>
			<Button>title=@"热点"</Button>
			<Button>title=@"视频"</Button>
			<Button>title=@"社会"</Button>
			<Button>title=@"订阅"</Button>
			<Button>title=@"科技"</Button>
		</TitleView>
		
		<ContentView Type="UScrollView">	
			<contentView>Vc=@"头条Vc"</contentView>
			<contentView>Vc=@"热点Vc"</contentView>
			<contentView>Vc=@"视频Vc"</contentView>
			<contentView>Vc=@"社会Vc"</contentView>
			<contentView>Vc=@"订阅Vc"</contentView>
			<contentView>Vc=@"科技Vc"</contentView>
		</ContentView>
	</MainVc.View>
	
	<!--主界面控制器的子控制器-->
	<MainVc>
		<ChildViewController> class=@"头条Vc" </ChildViewController>
		<ChildViewController> class=@"热点Vc" </ChildViewController>
		<ChildViewController> class=@"视频Vc" </ChildViewController>
		<ChildViewController> class=@"社会Vc" </ChildViewController>
		<ChildViewController> class=@"订阅Vc" </ChildViewController>
		<ChildViewController> class=@"科技Vc" </ChildViewController>
	</MainVc>
</NavigationController>

```
##搭建界面
---
整个项目分两块, 上面的`标题滚动视图`和下面的`内容滚动视图`

把常用的一些数值当做宏, 常量抽取出来

```
// 屏幕宽高
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
// 导航栏高度
static const CGFloat navBarH = 64; 
// 标题滚动视图高度
static const CGFloat titleScrollViewH = 44; 
```

先把界面大体结构搭建出来:

1. 添加标题滚动视图
2. 添加内容滚动视图
3. 添加所有子控制器

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加标题滚动视图
    [self setUpTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setUpContentScrollView];
    
    // 3.添加子控制器
    [self setUpAllChildViewController];    
}

```

目前滚动视图上面还没有内容, 也没确定contentSize, 尚不能滚动, 我们将在下一步完善