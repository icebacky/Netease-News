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

## 新闻标题按钮设置
---
给每个对应的控制器设置一个按钮, 之后点击按钮就能跳转到相应控制器的view(未实现), 并将按钮添加到标题滚动视图

按钮取决于对应的控制器

```
    CGFloat buttonW = 100;
    CGFloat buttonH = titleScrollViewH;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    // 遍历所有子控制器
    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:vc.title forState:UIControlStateNormal];

        // 动态计算按钮frame
        buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [_titleScrollView addSubview:button];
    }

```
知道按钮的细节之后, 我们可以给titleScrollView和contentScrollView设置contentSize, 并将水平指示器隐藏

```
    _titleScrollView.contentSize = CGSizeMake(buttonW * count, 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    
    _contentScrollView.contentSize = CGSizeMake(screenW * count, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;

```

##监听按钮点击
---
在添加按钮时, 根据当前子控制器的下标, 给按钮设置tag, 以后就能根据tag来获取自控制器

给按钮添加点击事件, 我们需要点击的按钮标题变为红色, 之前选中的按钮颜色变回黑色, 并且滚动到对应的view.

程序一开始默认选中第一个按钮:头条

```    
    // 遍历所有子控制器
    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
        
        // 按钮点击
        if (0 == i) {
            [self buttonClick:button];
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleScrollView addSubview:button];
    }
```

按钮点击, 需要一个额外的成员变量来记录当前被选中的按钮, 然后进行操作

```
// 选中按钮
- (void)selectButton:(UIButton *)button
{
    // 还原上一个按钮
    [_selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 选中按钮处理
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 记录选中按钮
    _selectedButton = button;
}
```

跳转到相应的界面, view在我们用的时候才进行创建

```
// 按钮点击
- (void)buttonClick:(UIButton *)button
{
    [self selectButton:button];
    
    // 取出对应控制器的view添加到内容滚动视图上去
    NSUInteger index = button.tag;
    UIViewController *showVc = self.childViewControllers[index];
    
    CGFloat showX = index * screenW;
    CGFloat showY = 0;
    CGFloat showW = screenW;
    CGFloat showH = _contentScrollView.height;
    showVc.view.frame = CGRectMake(showX, showY, showW, showH);
    
    [_contentScrollView addSubview:showVc.view];
    
    // 滚动到对应的view
    _contentScrollView.contentOffset = CGPointMake(showX, 0);
    
}
```

在iOS7之后, UIScrollView增加了automaticallyAdjustsScrollViewInsets属性, 会给我们空出一个navigationBar/toolbar(44) + statusbar(20)的宽度, 造成错位, 记得将其设置为NO;

## 监听内容滚动
---
给内容滚动视图设置分页.

当翻到新一页的时候, 判断该view是否创建, 如果创建直接显示, 没有创建的话创建该view, 并跳转到这个页面, 选中对应的按钮

我们发现, 创建跳转界面 点击按钮和 监听滚动都用到了, 我们可以将这个功能抽取成一个方法.

页面的滚动, 需要让控制器遵守`<UIScrollViewDelegate>`协议, 并成为内容滚动视图的代理, 我们在滚动减速完成的时候 选中对应的按钮, 添加对应控制器的view

```
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
```
要想取出按钮, 我们需要将之前添加的按钮保存起来, 创建一个可变数组, 在创建按钮的时候将其保存到里面, 等到需要用的时候就可以取出来了

##按钮细节
---

显示某一view的时候, 为了美观会将该按钮居中显示(最前面和最后面的除外, 一边空着也不好看), 并且将该按钮放大, 之前选中的按钮缩小, 按钮的颜色要需要渐变

###按钮居中显示

按钮想要居中, 就需要计算它的偏移量:

- 点击按钮的时候
	- Btn.offSetX = Btn.centerX - screenW * 0.5;
<br/><br/>
- 滚动内容的时候
	- 调用点击按钮实现<br/><br/>
- 最开头的几个按钮不需要移动到中间
	- MinOffsetX = 0<br/><br/>
- 最末尾的几个按钮不需要移动到中间
	- MaxOffsetX = ContentSizeW - screenW<br/><br/>
	
```
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
```
