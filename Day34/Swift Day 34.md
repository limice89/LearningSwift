# Swift Day 34
>今天我们有两个主题,会用到将HTML注入WebView,添加一个tab到tabBarController中等等


## Rendering a petition: loadHTMLString
完成JSON解析后,我们可以创建一个webView详情控制器,显示petition内容

File > New > File > iOS > Source > Cocoa Touch Class创建一个`DetailViewController`继承自`UIViewController`

然后修该控制器视图view为webView

```
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```
我们增加了一个Petition类型的detailItem属性,我们要向在webView中显示petition文本,我们需要使用HTML语言进行包装一下

```
guard let detailItem = detailItem else { return }

let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> body { font-size: 150%; } </style>
</head>
<body>
\(detailItem.body)
</body>
</html>
"""

webView.loadHTMLString(html, baseURL: nil)
```
使用`guard`拆包`detailItem`,确保detailItem有值的情况下执行下面代码

我试图让HTML尽可能清晰，但如果你不懂HTML，不要担心。重要的是，有一个名为`html`的Swift字符串，其中包含显示页面所需的所有内容，并将其传递到Web视图的`loadHTMLString()`方法，以便加载它。这与我们之前加载HTML的方式不同，因为我们这里没有使用网站，只是一些自定义HTML。

我们现在要把列表控制器与详情控制器关联起来,在`didSelectRowAt`中跳转到`DetailViewController`

以前我们使用`instantiateViewController()`方法从`Main.storyboard`加载一个视图控制器，但是在这个项目中，`DetailViewController`不在storyboard中 - 可以直接加载类而不是从storyboard加载用户界面。

```
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let petition = petitions[indexPath.row]
    let vc = DetailViewController()
    vc.detailItem = petition
    navigationController?.pushViewController(vc, animated: true)
    
}
```
运行程序并点击cell,会跳转到详情页显示petition具体信息
## Finishing touches: didFinishLaunchingWithOptions

在项目完成之前,我们做两项更改,首先,向`UITabBarController`中增加一个热门petition的选项,然后增加一错误信息使我们的代码更可控

我们使用代码创建第二个视图控制器到tabBarController中而不是在storyboard中创建,因为如果使用storyboard创建维护起来非常麻烦

打开`AppDelegate.swift`找到我们的`didFinishLaunchingWithOptions`方法,这个方法在程序完成加载并准备使用的时候调用.我们在这里将第二个`ViewController`加入到tabBarController中

```
if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem  = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}
```
>* storyboard会自动创建一个窗口显示所有的视图控制器,窗口需要知道它的初始视图控制器是哪个,并将其设置为`rootViewController`属性
>* 在Single View App 模板中,根视图控制器是`ViewController`,但我们嵌入了导航控制器,嵌入了tabBarController,所以,现在我们的根视图控制器现在是一个`UITabBarController`
>* 我们需要手动创建一个新的`ViewController`，这首先意味着获取对`Main.storyboard`文件的引用。这是使用UIStoryboard类完成的,您不需要提供bundle，因为`nil`表示“使用我当前的应用程序包”。
>* 我们使用`instantiateViewController()`方法创建视图控制器，传入我们想要的视图控制器的storyboard ID。之前我们将导航控制器设置为storyboard ID为“NavController”
>* 我们为新的视图控制器创建一个UITabBarItem对象，设为`Top Rated`和tag为1;tag很重要
>* 我们将新的视图控制器添加到我们的tabBarController的`viewControllers`数组中，这将使它出现在选项卡栏中。

因此，代码会创建一个包含在导航控制器中的重复`ViewController`，为其提供一个新的选项卡栏项，以将其与现有选项卡区分开来，然后将其添加到可见选项卡列表中。这使我们可以为两个选项卡使用相同的类，而无需在故事板中复制控制器。

我们给新`UITabBarItem` tag为1的原因是因为它是一种识别它的简单方法。两个选项卡都包含一个`ViewController`，这意味着执行相同的代码。这意味着两者都将下载相同的JSON数据，这毫无意义。但是如果你将`ViewController.swift`的`viewDidLoad()`方法中的`urlString`修改为下面的代码:

```
let urlString: String
if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
} else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
}
```
`ViewController`的第一个实例加载原始JSON，第二个实例仅加载热门的请求

我们当前的加载代码不是很稳固：我们有几个`if`语句检查事情是否正常工作，但是如果出现问题则没有其他语句显示错误消息。

通过添加一个新的`showError()`方法可以很容易地解决这个问题，该方法创建了一个显示常规失败消息的`UIAlertController`：

```
func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
你可以调整JSON下载和解析的代码,增加调用失败显示错误信息

```
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
    } else {
        showError()
    }
} else {
    showError()
}
```
或者，我们可以通过在调用`parse()`之后插入`return`来重写它。这意味着如果能得到JSON并解析，该方法将退出，因此我们方法能执行到的末尾，这意味着未能正常得到JSON解析，我们可以显示错误

```
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
    }
}

showError()
```