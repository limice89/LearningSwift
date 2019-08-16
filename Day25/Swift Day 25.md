# Swift Day 25

>今天我们有两个主题,你会用到`UIProgressView`和属性观察器等等

## Monitoring page loads: UIToolbar and UIProgressView

现在我们要使用`UIView`的两个子类`UIToolbar`和`UIProgressView`;`UIToolbar`包含一些可点击的的`UIBarButtonItem`,`UIprogressView`是一个带颜色的表示事件进程的进度条.

使用`UIToolbar`很简单:所有视图控制器都自动带有`toolbarItems`数组，当视图控制器在`UINavigationController`中处于活动状态时，该数组会自动读取;

这与仅在视图控制器处于活动状态时显示`rightBarButtonItem`的方式非常相似。我们需要做的就是设置数组，然后告诉我们的导航控制器显示它的工具栏，它将为我们完成其余的工作

在`viewDidLoad()`中使用toolbar

```
let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    
toolbarItems = [spacer, refresh]
navigationController?.isToolbarHidden = false
```
> 第一行创建一个新类型`fixedSpace `的barButtonItem,不需要点击事件,所以target和action为nil; 第二行创建一个`refresh `的barButtonItem,点击执行webView重新加载操作.然后将他们放到`toolbarItems `数组,并设置navigationController的`isToolbarHidden `为`false`让toolbar显示;

接下来,添加`UIProgressView`到我们的toolbar,显示网页的加载进程;创建一个progressView属性

```
var progressView: UIProgressView!
```

在`viewDidLoad()`中创建progressView

```
progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)
```

> 第一行创建一个新的`UIProgressView`实例，为其提供默认样式。还有一种名为`.bar`的替代样式，它不会绘制未填充的行来显示进度范围，但默认样式在这里看起来最好。		
> 第二行设置progressView大小自适应		
> 最后一行使用customView参数创建一个新的UIBarButtonItem，我们将UIProgressView包装在UIBarButtonItem中，以便它可以进入我们的工具栏

我们将创建的progressButton放到`toolbarItems`数组里

```
toolbarItems = [progressButton,spacer, refresh]
```

如果你现在运行app,你发现progressView显示是一个细灰线,因为它的默认值是0,没有任何颜色,我们需要设置progressView 的值匹配webView的`estimatedProgress`,值从0~1变化,但是`WKNavigationDelegate`没有告诉我们值的变化

这时候我们可以使用苹果给出的解决方案**KVO**--任何时候对象Y的属性X发生改变,通知我

`viewDidLoad()`中我们添加self为观察者,观察对象为`estimatedProgress`

```
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
```
>`addObserver()`方法有四个参数：观察者是谁（self是观察者，所以我们使用self），我们想要观察什么属性（我们想要`WKWebView`的`estimatedProgress`属性），我们想要哪个值（我们想要刚刚设置的值，所以我们想要新的）和上下文值。

>`forKeyPath`和`context`有更多的解释。 `forKeyPath`未命名为forProperty，因为它不仅仅是输入属性名称。您实际上可以指定路径：一个属性在另一个内部，在另一个内部，依此类推。更高级的keypath甚至可以添加功能，例如数组中的所有元素的平均值！ Swift有一个特殊的关键字`#keyPath`，就像你之前看到的`#selector`关键字一样：它允许编译器检查你的代码是否正确--`WKWebView`类确实有一个`estimatedProgress`属性。

>`context`更简单：如果您提供唯一值，那么当你收到值已更改的通知时，会将相同的`context`值发送回给你。这允许你检查`context`以确保它是你调用的观察者。在某些极端情况下，需要指定（并检查）上下文以避免错误，但在本项目的任何内容中都不会访问它们。

***
**注意:** 
在更复杂的应用程序中，所有对`addObserver()`的调用都应与完成观察后对`removeObserver()`的调用相匹配 - 例如，当您完成视图控制器时。
***

当你使用KVO注册了一个观察者,你需要试下一个方法`observeValue()`,值发生改变的时候会执行

```
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        //UIProgressView的progress是float,estimatedProgress是double,需要转换
        progressView.progress = Float(webView.estimatedProgress)
    }
}
```

## Refactoring for the win

我们的应用程序有一个致命的缺陷，有两种方法可以解决它：增加代码或重构。巧妙的是，第一种选择似乎是最简单的，但与直觉恰恰相反是最复杂的。

缺点是：我们允许用户从网站列表中进行选择，但一旦他们进入该网站，他们就可以通过以下链接获得他们想要的任何其他地方。如果我们可以检查所遵循的每个链接，以便我们确保它在我们的安全列表中，那不是很好吗？

一个解决方案 - 增加代码 - 将让我们两次编写可访问网站列表：一次在`UIAlertControlle`r中，一次在我们检查链接时。这非常容易编写，但它可能是一个陷阱：您现在有两个网站列表，由你来保持两者都是最新的。如果你在重复的代码中发现错误，是否记得同时改正两处地方

第二种解决方案称为重构，它实际上是对代码的重写。不过，最终结果应该做同样的事情。重写的目的是使其更高效，使其更易于阅读，降低其复杂性，并使其更加灵活。最后如果我们要达到目的：我们想重构我们的代码，有一个共享的许可网址数组。		

增加网址数组属性
```
var websites = ["apple.com","google.com"]
```

修改webView加载网址,保证从数组中获取网址,这样要改变的时候,只需改变网址数组里的数据即可

```
let url:URL! = URL(string: "https://\(websites[0])")
webView.load(URLRequest(url: url))
```

同样的我们的`UIAlertController`的代码可以做一下修改

```
alert.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
alert.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
```
修改为

```
for website in websites {
	alert.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
}
```
最后要修改的是属于`WKNavigationDelegate `协议的方法`webView(_:decidePolicyFor:decisionHandler:)`这个方法
,方法用来在请求发送之前，决定是否跳转 -> 该方法如果不实现，系统默认跳转。如果实现该方法，则需要设置允许跳转，不设置则报错。
//该方法执行在加载界面之前

```
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }

    decisionHandler(.cancel)
}
```
属于`websites`数组中的网页才打开,否则取消,比如打开google,你搜索一些网站,点击不跳转
