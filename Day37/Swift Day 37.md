# Swift Day 37
>今天，有三个主题需要解决，你将学习如何向按钮添加目标事件，分割和连接字符串，隐藏视图等等

## Loading a level and adding button targets

我们需要玩家拼出不同字母组中的七个单词，每个单词都有一个线索供他们猜测。重要的是，字母组的总数最多为20,下面是一些例子

```
HA|UNT|ED: Ghosts in residence
LE|PRO|SY: A Biblical skin disease
TW|ITT|ER: Short online chirping
OLI|VER: Has a Dickensian twist
ELI|ZAB|ETH: Head of state, British style
SA|FA|RI: The zoological web
POR|TL|AND: Hipster heartland
```
如你所见，我使用`|`符号来分割我的字母组，这意味着一个按钮将具有“HA”，另一个“UNT”和另一个“ED”。然后有一个冒号和一个空格，接着是一个简单的clues。你可以从GitHub下载[https://github.com/twostraws/HackingWithSwift](https://github.com/twostraws/HackingWithSwift)。像以前一样将level1.txt复制到Xcode项目中。

我们的第一个任务是加载级别并配置所有按钮以显示一个字母组。我们需要两个新数组来处理这个：一个用于存储当前用于拼写答案的按钮，另一个用于存储所有可能的解决方案。我们还需要两个整数：一个用于保持玩家的分数，该分数将从0开始,提交答案时改变，另一个用于保持当前级别。

```
var activatedButtons = [UIButton]()
var solutions = [String]()
var score = 0
var level = 1
```
我们还需要创建三个当button点击时的方法

```
@objc func letterTaped(_ sender: UIButton) {
    
}
@objc func submitTapped(_ sender: UIButton) {
    
}
@objc func clearTapped(_ sender: UIButton) {
    
}
```
我们需要在创建button的时候,为button添加点击时触发的事件

```
submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
```
`.touchUpInside`表示点击button时触发事件		
同样的clear button增加点击事件

```
clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
```
字母按钮增加点击事件

```
letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
```

先不管按钮点击事件的方法实现,我们先把字母提示等数据加载进啦使用,我们创建一个单独的方法`loadLevel()`,这个方法里会做两件事1.加载解析之前的文本文件2.随机分配给字母button不同的字母组合

首先，我们将使用`enumerated()`方法循环数组。我们之前没有使用它，但它很有用，因为它将每个对象从一个数组作为循环的一部分传递给你，以及该对象在数组中的位置。

还有一个新的字符串方法需要学习，称为`replacementOccurrences()`。这允许您指定两个参数，并用第二个参数替换第一个参数的所有实例。我们将使用它将“HA | UNT | ED”转换为HAUNTED

在我向你展示代码之前，请注意我如何使用方法的三个变量：`clueString`将存储所有的线索，`solutionString`将存储每个答案有多少个字母（与线索位于相同的位置），而`letterBits`是一个数组存储所有字母组：HA，UNT，ED等。

```
func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"

                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
    }

    // Now configure the buttons and labels
}
```
我们当前的`loadLevel()`方法以注释结束//Now configure the buttons and labels，我们将用方法的最后部分填充它。这需要设置`cluesLabel`和`answersLabel`文本，然后将字母组分配给按钮。

在我向您展示实际代码之前，需要引入一个新的字符串方法：`trimmingCharacters（in :)`删除您从字符串的开头和结尾指定的任何字母。它最常用于参数`.whitespacesAndNewlines`，它修剪空格，制表符和换行符，我们在这里需要的是因为我们的线索字符串和解决方案字符串最终都会有额外的换行符。

```
cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

letterBits.shuffle()

if letterBits.count == letterButtons.count {
    for i in 0 ..< letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
    }
}
```
在运行程序之前，请确保在`viewDidLoad()`方法中添加对`loadLevel()`的调用。
## Loading a level and adding button targets
下面实现按钮的点击事件

```
@objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
}
```
>这里做了四件事:
>
>1. 安全检查,确保点击的按钮有标题
>2. 将按钮标题添加到当前答案
>3. 将按钮添加到`activatedButtons`数组
>4. 隐藏被点击的按钮

下面是清除按钮的点击事件,让答案清空, button隐藏的显示, activatedButtons 清空

```
@objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    for btn in activatedButtons {
        btn.isHidden = false
    }

    activatedButtons.removeAll()
}
```
使用`firstIndex（of :)`来搜索解决方案数组中的项目，如果找到它，则告诉我们它的位置。请记住，`firstIndex（of :)`的返回值是可选的，因此在没有找到任何内容的情况下，您将无法获得值 - 我们解包的时候要注意。

如果用户得到的答案是正确的，我们将更改答案标签，以便不是说“7 LETTERS”，而是说“HAUNTED”，让他们知道他们已经解决了哪些问题。

`firstIndex（of :)`会告诉我们哪个解决方案与他们的单词匹配，然后我们可以使用该位置来查找匹配的线索文本。我们需要做的就是将答案label文本用`\n`拆分，用解决方案本身替换解决方案位置的行，然后将答案label重新赋值。

你已经学会了如何使用组件`(separatedBy :)`将文本拆分成数组，现在是时候遇到它的相对方法：`join（separator :)`。这使得数组成为单个字符串，每个数组元素由其参数中指定的字符串分隔。

完成后，我们清除当前答案textfield,并增加一个得分。如果得分可以被7整除，我们知道他们已经找到了所有七个单词，所以我们将展示一个`UIAlertController`，它将提示用户进入下一个级别。

```
@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText) {
        activatedButtons.removeAll()

        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }
}
```

我们还没有写过levelUp（）方法，但它并不那么难。它需要：

> 1. level增加1。
> 2.  从solutions中删除所有项目。
> 3.  调用`loadLevel()`以便加载并显示新的级别文件。
> 4.  确保我们所有的字母按钮都可见。
>

```
func levelUp(action: UIAlertAction) {
	level += 1
	solutions.removeAll(keepingCapacity: true)
	
	loadLevel()
	
	for btn in letterButtons {
	    btn.isHidden = false
	}
}
```
你需要创建level2.txt，level3.txt等等。

为了帮助你入门，我在本项目的示例文件中为您创建了一个示例level2.txt - 尝试将其添加到项目中。你要做的是其他level的文本 - 只要确保每次总共有20个字母组！


## Loading a level and adding button targets

在这个项目完成之前还有最后一件事要做，它既简单又容易：属性观察者。当我们查看Swift的基本原理时，你会了解这些，但现在是时候将它们付诸行动了。

现在我们有一个名为`score`的属性，在创建游戏时设置为0，并在找到答案时增加1。但是我们没有对该分数做任何事情，因此我们的分数标签永远不会更新。

这个问题的一个解决方案是每当分数值改变时使用`scoreLabel.text =“Score：\（score）”`。但是如果你从几个地方改变分数会发生什么？您需要在所有改变分数的地方加上这句,这就不是很好了。

Swift的解决方案是属性观察器，它允许您在属性发生更改时执行代码。为了使它们工作，我们使用didSet在刚刚设置属性时执行代码，或者在设置属性之前使用willSet执行代码。

在我们的例子中，我们想要在我们的得分属性中添加一个属性观察者，以便我们在更改得分值时更新得分标签。因此，将您的分数属性更改为：

```
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```