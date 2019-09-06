# Swift Day 41
>今天总结7-9项目,并完成挑战

## What you learned

项目7,8,9是稍微难一点的项目,你需要解析JSON,创建复杂的布局,和多任务代码,不用担心百分百掌握`Codable`和GCD,后面我们会有很多机会使用

> * 你使用了`UITabBarController`这个控件,它在很多应用中很常见
> * tabbar上每一项以`UITabBarItem`表示,包含一个图标和一个文本标签
> * 我们是用`Data`的`contentsOf`方法加载URL,使用`JSONDecoder`解析使用数据
> * 我们再次使用了`WKWebView`,这次我们加载了自己的HTML,所以使用`loadHTMLString()`方法
> * 我们使用代码编写了用户界面,循环创建了游戏中的字母按钮
> * 在项目7中,我们使用了属性观察器,使用`didSet`,当`score`属性改变了以后,我们自动更新`socreLabel`显示新的分数
> * 学习了使用`DispatchQueue`在主线程和后台线程执行代码,同时学了使用`performSelector(inBackground:)`在后台执行整个方法
> * 最后,我们学习了一些新的方法.`enumerated()`循环数组;`joined()`将数组转化为字符串; `replacingOccurrences()`改变字符串内容.

## Key points
这里有三个重要的代码非常值得在复习复习.

**第一个:**

```
for (index, line) in lines.enumerated() {
    let parts = line.components(separatedBy: ": ")
```
这里的循环不同以前的循环,使用`enumerated()`会使数组在循环时返回两个字符串,一个是数组中对象的位置,另一个是数组对象本身

在循环中使用`enumerated()`是非常常见的,因为它传递item和对应的位置很有用,比如,我们要打印出比赛结果:

```
let results = ["Paul", "Sophie", "Lottie", "Andrew", "John"]

for (place, result) in results.enumerated() {
    print("\(place + 1). \(result)")
}
```

**第二个:**

```
var score: Int = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
这是一个属性观察者,当score属性的值发生改变后,将`scoreLabel`的文字相应改变

**第三个:**

```
DispatchQueue.global().async { [weak self] in
    // do background work

    DispatchQueue.main.async {
        // do main thread work
    }
}
```
该代码在后台执行一部分工作,然后到主线程执行其他操作,这种非常常见

代码的第一部分告诉GCD在后台线程执行下面的代码,这对于在执行一些耗时的工作是非常有用的,比如复杂操作:查询数据库或者加载文件等

代码的第二部分在后台线程任务执行完成以后,转到主线程,向用户展示对应的结果:数据库的搜索结果,或你获取的远程文件等

***非常值得一提的是,你必须在主线程更新自己的用户界面***;如果在后台线程执行,可能会出现闪退等问题

## Challenge

这个挑战我们会创建一个游戏,你仍然会使用UIKit,这也是你练习app技术的机会

这个游戏是:从列表中随机抽取一个单词,但是会以问号的形式展示给用户,比如你选的单词是"RHYTHM",展示给用户的是"??????"

用户一次猜一个字母,如果这个字母在单词内,比如H,这时候展示给用户的显示为 "?H??H?",如果猜错一个字母,越接近死亡,猜错七次则失败,如果拼全了单词则成功

你遇到的主要问题是Swift有专门针对单个字母的特殊数据类型`Character`,从字符创建字符串很简单,从字符串变为字符也一样

把字符串当成是数组就可以访问字符串中的各个字母,当你写`for letter in word`,`letter`就是一个`Character`类型,所以如果判断你的`usedLetters`数组包含字符串,你将该字母转化为字符串:

```
let strLetter = String(letter)
```
注意:与常规数组不同,字符串不能通过字符位置获取字符

当你又了每个字母的字符串形式,你可以使用`contains()`来检查它是否在`usedLetters`数组中

先自己做,然后再看提示

**提示:**

* 你已经知道怎么从磁盘中加载单词列表,并选择一个,这个我们在项目5中已经用过了
* 你知道如何提示用户输入文本,这个在项目5中也做过,只不过这次只能输入一个字母,根据`someString.count`判断
* 你可以在控制器中的`title`显示用户当前单词和分数
* 你应该创建一个`usedLetters`数组和一个`wrongAnswers`整数
* 当用户胜利或失败的时候,使用`UIAlertController`显示一个信息告诉用户

一段可能有用的代码:

```
let word = "RHYTHM"
var usedLetters = ["R", "T"]
var promptWord = ""

for letter in word.characters {
    let strLetter = String(letter)

    if usedLetters.contains(strLetter) {
        promptWord += strLetter
    } else {
        promptWord += "?"
    }
}

print(promptWord)
```

