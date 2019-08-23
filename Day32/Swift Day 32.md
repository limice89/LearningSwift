# Swift Day 32

>总结 : 项目4-6,今天有三个主题,其中一个是挑战项,今天完不成挑战项也没关系,可以在后来有时间的时候补回来

## What you learned
项目4展示了构建复杂应用程序是多么容易：Apple的`WebKit`框架包含一个完整的Web浏览器，您可以将其嵌入到需要显示HTML的任何应用程序中。这可能是你自己的一个网页，或者它可能是项目4中所见的完整网站。

之后，项目5向您展示了如何构建您的第二个游戏，同时还使用`UITableViewController`进行了一些练习。从项目11开始，我们将切换到`SpriteKit`用于游戏，但是你也可以在UIKit中制作很多游戏。

`WebKit`是我们在项目3中的社交框架之后使用的第二个外部框架。这些框架总是提供许多复杂的功能，这些功能组合在一起用于一个目的，但您也学到了很多其他东西：

*  代理模式。我们在项目4中使用了这个，以便将`WebKit`事件发送到我们的`ViewController`类，以便我们可以对它们做其他事情。
*  我们使用`UIAlertController`及其`.actionSheet`样式向用户提供可供选择的选项。我们给了它一个取消的.cancel按钮，它使弹框消失。
*  你看到可以将`UIBarButtonItem`放入`toolbarItems`属性，然后导航控制器显示`UIToolbar`。我们还使用了`.flexibleSpace`按钮类型来使布局看起来更好。
*  你使用了KVO，我们用它来更新Web浏览器中的加载进度。这使您可以监视所有iOS中的任何属性，并在更改时收到通知。
*  你学习了如何使用`contentsOf`从磁盘加载文本文件。
*  我们第一次向`UIAlertController`添加了一个输入框，然后使用`ac?.textFields?[0]`将其获取。我们可以在其他几个项目中学习使用。
* 你再次深入学习了闭包的使用，只需将它们视为可以在变量中传递或作为其他函数的参数传递的函数。
* 你使用了一些字符串和数组操作方法：`contains()`，`remove(at :)`，`firstIndex(of :)`。

最重要的是，我们还深入了解了自动布局。我们在项目1和项目2中简要地使用了这个，但是您现在已经学会了更多自动布局的方法：VFL和锚点。还有其他方法
## Key points
我想重新复习下三段代码，因为它们具有特殊的意义。

首先，让我们来看项目4中的WKWebView。我们将此属性添加到视图控制器：
```
var webView: WKWebView!
```
重载`loadView()`方法

```
override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}
```
通常不需要loadView（）方法，因为大多数视图布局是从storyboard加载的。但是，在代码中编写部分或全部用户界面是很常见的，并且在那些时候您可能希望将`loadView()`替换为您自己的实现。

如果你想要一个更复杂的布局 - 也许你想让网页视图只占据屏幕的一部分 - 那么这种方法就不会有用了。相反，你只需要加载storyboard视图，然后使用`viewDidLoad()`将Web视图放在想要的位置。

除了覆盖`loadView()`方法之外，项目4还具有`webView`属性。这很重要，因为就Swift而言，常规视图属性只是一个`UIView`。

我们知道它实际上是一个`WKWebView`，但Swift不知道。所以，当你想调用它上面的任何方法就像重新加载页面一样，Swift不会让你使用`view.reload()`，因为就它而言，`UIView`没有`reload()`方法。

这就是属性解决的问题：它就像是视图的永久类型转换，因此无论何时我们需要操作Web视图，Swift都可以让我们使用该属性。

第二段代码来自项目5:

```
if let startWords = try? String(contentsOf: startWordsURL) {
    allWords = startWords.components(separatedBy: "\n")
}
```
你会用到`if let`和`try?`组合在一个表达式中,`contentsOf`加载文件从磁盘中,如果加载成功,你会得到文本,如果失败会抛出异常

你已经学过了`try`,`try!`和`try?`,我希望你现在明白为什么这三个都有帮助,这里的`try?`告诉我们,如果加载失败不要抛出异常而是返回nil;所以`contentsOf`返回的不是一个`String`而是一个`String?`,可能是文本也可能是nil;所以我们需要使用`if let`,只有当获取到文本的时候才执行括号里的代码

最后一段代码:

```
view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
```

在这行代码中演示了使用VFL的优点：它排列了五个label，一个在另一个之上，每个都有相同的高度，它们之间有少量空间，最后一个离边框距离大于等于10。

这一行也证明了VFL的缺点：它有看起来像线路！你需要非常仔细地阅读它，有时候要前后查找,以便做其他更改操作。 VFL是以一种富有表现力的方式解决许多自动布局问题的最快捷，最简单的方法，但随着本课程的学习，你将学习`UIStackView`等替代方案，它们可以在没有复杂语法的情况下做同样的事情。
## Challenge

创建一个你自己的app,app中允许用户弹框输入商品(假定用户输入的是真正的商品),创建一个购物清单,并允许用户清空购物清单,允许用户分享购物清单内容给别人
(先自己写在看提示)
提示:

* 请记住将`ViewController`更改为在`UITableViewController`上构建，然后更改故事板以匹配。
* 创建`[String]`类型的`shoppingList`属性以保存用户想要购买的所有项目。
* 使用样式`.alert`创建`UIAlertController`，然后调用`addTextField()`让用户输入文本。
* 当您有一个新的购物清单项目时，请确保在调用表格视图的`insertRows（at :)`方法之前将其插入到`shoppingList`数组中 - 如果您以错误的方式执行此操作，您的应用程序将会崩溃。
* 使用`UIActivityViewController`分享购物清单,购物清单是一个数组,将数组转化为字符串分享

```
let list = shoppingList.joined(separator: "\n")
```
