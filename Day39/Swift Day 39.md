# Swift Day 39
> 今天我们有五个主题,你会学习GCD多线程,队列,`performSelector()`等等

## Setting up
在这个技术项目中，我们将返回到项目7，使用最重要的Apple框架之一解决一个关键问题：Grand Central Dispatch，或GCD。

项目7中通过在viewDidLoad（）中从互联网下载数据，我们的应用程序将锁定，直到所有数据都已传输完毕.

我们将通过使用GCD来解决这个问题，这将允许我们在不锁定用户界面的情况下获取数据。但要注意：尽管GCD起初可能看起来很容易，但它会带来一系列新问题，所以要小心！

拷贝Project7改为 Project9
## Why is locking the UI bad
为什么锁定UI不好,原因一:我们使用`Data`的`contentsOf`从互联网上下载数据，这就是所谓的阻塞调用。也就是说，它阻止方法中任何其他代码的执行，直到它连接到服务器并完全下载所有数据。

原因二:幕后，你的应用程序实际上同时执行多组指令，这使它可以利用多个CPU。每个CPU都可以独立于其他CPU执行某些操作，从而极大地提高了性能。这些代码执行过程称为线程,有几点需要注意:

1. 线程执行你的代码,不只是从`viewDidLoad()`中随机执行几行,默认情况下你的代码只在一个CPU内执行,因为你没有为CPU创建线程
2. 所有用户界面的工作必须在主线程执行,如果在其他线程执行,可能有效也可能发生错误,引起崩溃
3. 你不能控制线程什么时候执行以什么顺序执行,你只需创建并交给系统,系统会自动处理
4. 因为你不能控制执行顺序,所以你要确保只有一个线程修改数据

第1点和第2点解释了为什么我们的调用很糟糕：如果所有用户界面代码必须在主线程上运行，并且我们只是通过使用`Data的contentsOf`来阻止主线程，则会导致整个程序冻结 - 用户可以触摸屏幕，什么都不会发生。当数据最终下载（或者只是失败）时，程序将解冻。这是一种糟糕的体验，尤其是当iPhone经常使用质量差的数据连接时。

从广义上讲，如果您正在访问任何远程资源，您应该在后台线程上执行它 - 即，任何不是主线程的线程。如果你正在执行任何慢速代码，你应该在后台线程上执行它。如果您正在执行任何可以并行运行的代码 - 例如为100张照片添加过滤器 - 您应该在多个后台线程上执行此操作。

GCD的强大之处在于它消除了创建和使用多线程的许多麻烦。您不必担心创建和销毁线程，也不必担心确保为当前设备创建了最佳线程数。 GCD会自动为您创建线程，并以最有效的方式在它们上执行您的代码。

要修复我们的项目，你需要学习三个新的GCD函数，但最重要的一个叫做`async()` - 它表示“异步运行以下代码”，即不要阻塞（停止我正在做的事情）而它正在执行。是的，这似乎很简单，
## GCD 101: async()
我们将使用`async()`两次,一次将一些代码在后台线程执行,再一次将代码送回主线程执行,这使我们在不阻塞用户界面的前提下进行其他操作,然后回到主线程更新用户界面

你可以使用`async()`通知系统代码运行的地方;GCD是以队列的形式工作,就像现实中的队列(先进先出FIFO),这意味着GCD不会创建线程,只是管理分配的现有线程

GCD为你创建了许多队列,每个队列里有你的一系列任务,因为是先进先出,所以代码块按照顺序执行,但是也可以同时执行多个代码块,完成顺序无法保证

代码的重要性取决于所谓的“服务质量”或QoS，它决定了应该给出这个代码的服务级别。显然，最重要的是主队列，它在主线程上运行，并且应该用于安排必须立即更新用户界面的任何工作，即使这意味着阻止程序执行任何其他操作。但是有四个后台队列你可以使用，每个队列都有自己的QoS级别:
> 1. 用户交互(User Interactive): 这是优先级最高的后台线程,如果你有重要的事情要做并且保证用户界面正常使用,你可以使用.这个优先级要求系统几乎吧所有可用的CPU资源用在上面,保证尽快完成
> 2. 用户启动(User Initiated):由用户发起的并且需要立即得到结果的任务，比如滑动scroll view时去加载数据用于后续cell的显示，这些任务通常跟后续的用户交互相关，在几秒或者更短的时间内完成
> 3. 功能队列(The Utility queue):一些可能需要花点时间的任务，这些任务不需要马上返回结果，比如下载的任务，这些任务可能花费几秒或者几分钟的时间
> 4. 后台队列(The Background queue): 这些任务对用户不可见，比如后台进行备份的操作，这些任务可能需要较长的时间，几分钟甚至几个小时

这些QoS队列会影响系统优先处理任务的方式:`User Interactive`和`User Initiated`的任务会尽快执行,不管对电池的寿命影响. `Utility`任务尽可能在不牺牲太多性能的情况下保持高效率.`Background`任务以系统效率为优先级执行

GCD会自动平衡工作,以便优先级较高的队列比优先级较低的队列有更多的时间执行,这意味着如果后台任务遇到用户交互任务会暂缓执行

还有一个选择就是default 队列,这个是介于`user-initiated`和`utility`之间的队列,这是一个多用途的队列

说了这么多,是时候举个栗子了:我们将使用`asyn()`使我们的所有加载代码在默认服务质量的后台队列中执行,实际上只有两行代码不同:

```
DispatchQueue.global().async { [weak self] in
```
这个代码在后台任务执行,后面是一个尾随闭包,如果你想指定使用`user-initiated`队列而不是使用默认队列,你可以修改为:

```
DispatchQueue.global().async { [weak self] in
```
`async()`方法接受一个参数,这是一个异步执行的闭包,我们使用尾随闭包的语法,它删除了一组不必要的括号.

因为`async()`使用闭包,我们以`[weak self] in` 开头,确保不会引起循环引用,我们的加载代码跟之前一样;下面是加载代码:

```
DispatchQueue.global(qos: .userInitiated).async { [weak self] in
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self?.parse(json: data)
            return
        }
    }
}

showError()
```

如果你想尝试其他QoS队列,你可以使用`.userInteractive`, `.utility`和`background`
## Back to the main thread: DispatchQueue.main
代买更改以后,我们的代码有好也有坏,好的是它在下载JSON数据的时候不会阻塞主线程,糟糕的是,我们将任务推送到后台线程,工作中其他的代码也将在后台线程中执行

这同时也引起了一些混乱:无论加载什么,都会调用`showError()`,代码中有一个`return`,但它实际什么都没做--它是从异步执行的闭包中返回的,而不是从整个方法中返回的. 所以无论下载成功还是下载失败,都会调用`showError()`,如果下载成功,会在后台线程解析JSON,并在后台线程调用表视图的`reloadData()`

我们来修复下这个问题,我们可以从后台线程解析JSON,但是,**不能在后台线程进行用户交互操作**

如果你在后台线程上,想在主线程执行代码,需要再次调用`saync()`,但是这次是在`DispatchQueue.main`上执行;

我们可以在每次执行`showError()`和`parse()`之前使用`async()`,但既不好看又低效.最好是在`showError()`里面使用`async()`,包含整个`UIAlertController`代码;同样的在`parse()`中,但积极是表视图刷新的时候,JSON的解析仍然保留在后台线程中

所以 `parse()`中

```
tableView.reloadData()
```

修改为:

```
DispatchQueue.main.async { [weak self] in
    self?.tableView.reloadData()
}
```
`showError()`无视结果都会调用,所以,我们应该把它放到 `DispatchQueue.global()`中

```
DispatchQueue.global(qos: .userInitiated).async { [weak self in
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self?.parse(json: data)
            return
        }
    }

    self?.showError()
}
```

这里还有一个问题,我们的`showError()`会创建展示一个`UIAlertController` ,现在是一个`user-interface`在后台线程执行,所以我们需要更改到主线程执行:

```
func showError() {
    DispatchQueue.main.async { [weak self] in
        let ac = UIAlertController(title: "加载错误", message: "加载错误,请查看网络连接后重试", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self?.present(ac, animated: true)
    }
    
}
```

## Easy GCD using performSelector(inBackground:)

还有一种使用GCD的方法,在特定情况下使用非常容易,成为`performSelector()`,它有两个变体:`performSelector(inBackground:)` 和`performSelector(onMainThread:)`.

它们的工作方式相同,你需要传递一个方法名称,`inBackground`将在后台线程运行,`onMainThread`会在前台线程上运行,你不必关心它具体怎么运行,GCD会为你处理好这些,如果在主线程或后台线程执行某个方法,这两个是最简单的

```
override func viewDidLoad() {
    super.viewDidLoad()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
}

@objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
}

@objc func showError() {
    let ac = UIAlertController(title: "加载错误", message: "加载错误,请查看网络连接后重试.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```

我们可以在JSON解析的时候增加`else`相关代码:

```
if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
    petitions = jsonPetitions.results
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
} else {
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
```
