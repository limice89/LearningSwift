# Swift Day 23

>今天我们巩固下项目1-3的知识

## What you learned
我们已经写了几个小项目,所有的应用都是在UIKit基础上构建的,通过这两个项目,你已经开始了解视图控制器的基本功能,这也是iOS中的基础部分,后面的体验会越来越好		
你可以将Swift知识付诸实践,做出许多真实有用的项目,因为大多数iOS应用是可视化的,所以,可以用UIKit做很多东西

> * 列表视图使用`UITableView`,这也是iOS中重要的组件之一,经常使用
> * 图像视图使用`UIImageView`,包含一个数据`UIImage`,`UIImage`包含像素点,`UIImageView`用来展示他们
> * 按钮使用`UIButton`,默认情况下,没有特殊的设计,他们想标签一样,点击的时候会触发事件
> * 控制器使用 `UIViewController`,提供了一个显示屏幕所需的所有显示技术,包括iPad上的旋转和多任务等
> * 系统弹框使用`UIAlertController`,项目2中的显示分数,用户根据需要作出选择等
> * 导航按钮 使用 `UIBarButtonItem` 我们使用了内置操作图标,但还有许多其他选项,你也可以自定义文本
> * 颜色使用`UIColor`,例如项目中的黑色边框,系统有很多颜色可以选择,你也可以创建自己的颜色使用
> * 使用`UIActivityViewController`将内容分享到Facebook和Twitter。还处理打印，将图像保存到照片库等等。

你可能对`UIView`和`CALayer`, `UIColor`和`CGColor`难以理解,我试图将它们描述为“较低级别”和“较高级别”，这可能会有所帮助，也可能没有帮助。简而言之，您已经看到了如何通过构建Apple的API来创建应用程序，而这正是Apple的工作原理：他们高级别的东西，如`UIView`，都是建立在像`CALayer`这样的低级别之上。有时您需要深入了解这些较低层的东西，但大部分时间您都会留在UIKit。

如果您担心自己不知道何时使用UIKit或何时使用其中一个较低级别的替代品，请不要担心：如果您在Xcode需要`CGColor`时尝试使用`UIColor`，会有提醒！

项目1和2都在Interface Builder中广泛使用，这是本系列中的一个运行主题：尽管你可以在代码中创建UI，但通常最好不要这样做。这不仅意味着您可以在各种设备类型中预览时确切了解布局的外观，还可以让专业设计人员进入并调整布局而无需触及代码。相信我：保持你的UI和代码是分开的是一件好事。

到目前为止，您遇到的三个重要的Interface Builder事物是：

  1. storyboard，使用Interface Builder编辑，但也通过设置storyboard标识符在代码中使用。		
  2.  Interface Builders的outlet和action。outlets将视图连接到命名属性（例如imageView），而action将它们连接到运行的方法，例如， `buttonTapped()`。
  3. AutoLayout，用于创建关于界面元素应如何相对于彼此定位的规则。

在本教程中，您将大量使用Interface Builder。有时我们会在代码中创建视图，但只在必要时才使用。

--
我还想简要介绍其他三件事，因为它们非常重要。

首先，您遇到了Bundle类，它允许您使用您构建到项目中的任何资源，如图像和文本文件。我们用它来获取项目1中的NSSL JPEG列表，我们可以在项目中再次使用它。

其次，加载那些NSSL JPEG是通过使用FileManager类扫描应用程序包来完成的，这样可以读取和写入iOS文件系统。我们使用它来扫描目录，但它也可以检查文件是否存在，删除内容，复制内容等。

最后，您学习了如何使用Swift的Int.random（in :)方法生成随机数。 Swift有很多功能使用随机数，我们将在以后的项目中使用。

## Key points

这里有五个重要的代码片段

***
> 第一个

```
let items = try! fm.contentsOfDirectory(atPath: path)
```

> fm是`FileManager`的实例, path是`Bundle`中资源路径,从资源中找出存在的对应文件数组, 但是你记得为什么使用 `try!`嘛
> 
> 当你需要目录中的内容是,它可能是存在的,也可能并不像期望的那样,也许实际目录并不存在,或者你不想写写错了目录名称,这时候`contentsOfDirectory()`调用失败,Swift抛出异常,逐行拒绝执行代码,直到给出处理错误		
> 
> 这很重要，因为处理错误可以让您的应用即使在出现问题时也能表现良好。但在这种情况下，我们直接从iOS获得了路径 - 我们没有手动输入，所以如果从我们自己的应用程序包中读取不起作用,那么显然确实存在一些非常错误。

>Swift需要使用try关键字处理可能无法调用的任何调用，这会强制您添加代码以捕获可能导致的任何错误。但是，因为我们知道这段代码会起作用 - 它不可能输入错误 - 我们可以使用try！关键字，这意味着“不需要抓取报错，因为它们不会发生。”当然，如果你错了 - 如果确实发生错误 - 那么你的应用程序会崩溃，所以要小心！		

***
>第二个

```
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}
```
>在项目1中使用它来使表视图显示图片数组所需的行数
>
>回顾一下，我们在创建项目1时使用了Single View App模板，这给了我们一个名为`ViewController`的`UIViewController`子类。为了使它使用表格，我们更改了`ViewController`，使其基于`UITableViewController`，它提供了许多问题的默认选项：有多少分区？多少行？每一行都有什么？点击一行会发生什么？等等。

>显然，我们不希望每个问题都使用默认，因为我们的应用程序需要根据自己的数据指定它想要的行数。而这就是override关键字的来源：它意味着“我知道这个问题有一个默认值，但我想提供一个新值。”这个案例中的“问题”是“numberOfRowsInSection”，它希望收到一个Int返回：应该有多少行？

***
>另外两个代码段

```
let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
}
```

>这两者都使用标识符字符串将代码链接到storyboard。在前一个代码中，它是一个cell的重用标识符;在后者中，它是视图控制器的storyboard标识符。你必须在Interface Builder和代码中使用相同的名称 - 如果不这样做，您将会崩溃，因为iOS不知道该怎么做。

这些代码中的第二个特别有趣，因为`if let`和`as? DetailViewController`。当我们使用cell的时候，我们使用了内置的“basic”样式 - 我们不需要使用自定义类来处理它，因此我们可以设置其文本显示。

但是，`DetailViewController`有自身的自定义内容需要处理：`selectedImage`。这在普通的`UIViewController`上是不存在的，这就是`instantiateViewController（）`方法返回的内容 - 毕竟它不知道（或关心）storyboard中的内容。这就需要`if let`和`as？`类型转换来处理：它意味着“我想对处理的对象是一个`DetailViewController`，所以请尝试将其转换为一个。”

只有当转换确实是`DetailViewController`时才执行大括号里的内容​​ - 这就意味我们可以安全地访问`selectedImage`属性。

## Challenge

>现在你已经对tableView ,imageView,NavigationController,等有一定的了解,现在让我们将他们串联起来,我们创建一个app,有一个国家旗帜的列表,但其中一个被点击时,跳转到详情页面,详情页面包含一个imageView,全尺寸展示,在详情页的增加一个按钮,通过`UIActivityViewController`分享这个图片和国家名字