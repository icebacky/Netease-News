<link rel="stylesheet" href="/Users/hanxiaoyu/Documents/highlight/styles/xcode.css">
<script src="/Users/hanxiaoyu/Documents/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>

>It mimics a Netease News homepage view

#Netease News

## Project Structure
---
```
<NavigationController>
	<!--Navigation Bar-->
	<NavigationBar>
		title = @"Netease News"
	</NavigationBar>
	
	<!--Main View-->
	<MainVc.View>
		<TitleView Type="UScrollView">
			<Button>title=@"Top Line"</Button>
			<Button>title=@"Hot"</Button>
			<Button>title=@"Video"</Button>
			<Button>title=@"Society"</Button>
			<Button>title=@"Subscribe"</Button>
			<Button>title=@"Science"</Button>
		</TitleView>
		
		<ContentView Type="UScrollView">	
			<contentView>Vc=@"TopLineVc"</contentView>
			<contentView>Vc=@"HotVc"</contentView>
			<contentView>Vc=@"VideoVc"</contentView>
			<contentView>Vc=@"SocietyVc"</contentView>
			<contentView>Vc=@"SubscribeVc"</contentView>
			<contentView>Vc=@"ScienceVc"</contentView>
		</ContentView>
	</MainVc.View>
	
	<!--Main ViewController's childViewCiontrollers-->
	<MainVc>
		<ChildViewController> class=@"TopLineVc" </ChildViewController>
		<ChildViewController> class=@"HotVc" </ChildViewController>
		<ChildViewController> class=@"VideoVc" </ChildViewController>
		<ChildViewController> class=@"SocieVc" </ChildViewController>
		<ChildViewController> class=@"SubscribeVc" </ChildViewController>
		<ChildViewController> class=@"ScienceVc" </ChildViewController>
	</MainVc>
</NavigationController>

```

Build Interface
---
The project is divided into two views.`Titles Scroll View` at the top and `Contents Scroll View` at the bottom.

Define some constants and macros.

```
// The width and heigh of current screen
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

// The height of navigation bar
static const CGFloat navBarH = 64; 
// The height of titles scroll view
static const CGFloat titleScrollViewH = 44; 
```


Let's build project structure

1. Add titleViewController
2. Add contentViewController
3. Add all childViewControllers


```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. Add titleViewController
    [self setUpTitleScrollView];
    
    // 2. Add contentViewController
    [self setUpContentScrollView];
    
    // 3. Add all childViewControllers
    [self setUpAllChildViewController];    
}

```


You couldn't scroll through these scroll views yet.

Because of there is no contents or contentSize of scrollViews

We will solve this issue next step
