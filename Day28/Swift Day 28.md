# Swift Day 28

> 今天学习三个主题,主要学习`UITextChecker`找到无效单词,向tableView插入行等

## Prepare for submission: lowercased() and IndexPath

在`submit()`方法之前需要检查用户输入的单词是否由给定的字母组成,检查单词是否已经被拼写过,检查单词是不是一个有效的单词
如果三项检查都通过了,`submit()`添加单词到`userWords`数组,然后增加一行到tableView,我们可以使用表视图的`reloadData()`方法强制重新加载,但是当我们只更改一行的时候,这不是非常有效的方式

创建三个方法,用于检查单词是否可以加入`userWords`,先暂时都返回true,后面在对三个方法修改

```
func isPossible(word: String) -> Bool {
    return true
}
func isOriginal(word: String) -> Bool {
    return true
}
func isReal(word: String) -> Bool {
    return true
}
```

现在我们实现`submit()`方法

```
func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()
    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                
            }
        }
    }
    
}
```
因为用户可能输入的字符是大写的,我们需要对输入的字符进行转换为小写,方便我们使用		
这里使用了三个嵌套`if`,只有当所有`if`都为`true`的时候才会执行最里面大括号里的代码,也就是word是可用的

我们可以调用`reloadData()`方法并让表对所有行进行完全重新加载，但这意味着需要为一个小的更改做很多额外的工作，并且还会导致tableView跳动 - 这个单词不存在的时候。

这可能很难让用户直观地跟踪，因此使用`insertRows()`可以告诉表视图，新行已放置在数组中的特定位置，以便它可以为出现的新单元设置动画。正如您可能想象的那样，添加一个单元格也比重新加载所有内容要容易得多！

这里有两点需要详细说一下。首先，我们在项目1中简要介绍了IndexPath，因为它包含表中每个项目的一个分区和一行。与项目1一样，我们这里没有使用分区，但行号应该等于我们在数组中添加项目的位置 - 在这种情况下位置0。

其次，`with`参数允许您指定行应该如何设置动画。每当您从表中添加和删除内容时，`.automatic`值意味着“为此更改执行任何标准系统动画”。在这种情况下，它意味着“从顶部滑入新行”。

无论输入什么词，我们的三种检查方法总是返回true，你可以运行程序应该可以点击+按钮并在alertView中输入单词。
## Checking for valid answers
如你所见，return关键字在任何时候都会退出方法。如果你单独使用`return`，它将退出方法并且不执行任何其他操作。但是如果你使用带有值的`return`，它会将该值发送回任何调用方法的值。例如，我们之前使用它来发回表中的行数。

在你发送值之前，你需要告诉Swift您希望返回一个值。 Swift将自动检查返回的值是否为正确的数据类型，因此这很重要。

```
func isOriginal(word: String) -> Bool {
    return true
}
```
`isOriginal()`传参是字符串,返回值是`Bool`,因为我们需要检查word是否已经存在`userWords`内,如果存在返回`false`,如果不存在则返回`true`;所以方法里的代码需要修改为

```
return !usedWords.contains(word)
```
`contains()`是数组的方法,检查数组中是否有某个元素,如果有返回`true`没有返回`false`,最前面的`!`是取反

**接下来是`isPossible()`方法**		
我们如何确定"cease"是根据"agencies"中字母拼写的,并且每个字母只使用一次,解决方案是遍历答案的每个字符,如果在原始八个字母的单词中存在,在原始单词中删除该字母,然后循环下去,如果答案一个字母存在两次第一次存在,被删除后,下次不存在则检查失败,这里我们需要使用`String`的`firstIndex(of:)`方法--返回字符串字母的第一个位置,如果不存在返回`nil`

```
func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else {
        return false
    }
    for letter in word {
        if let position = tempWord.firstIndex(of: letter){
            tempWord.remove(at: position)
        }else {
            return false
        }
    }
    return true
}
```

如果在字符串中找到了该字母，我们使用`remove(at :)`从`tempWord`变量中删除使用过的字母。这就是我们需要`tempWord`变量的原因：因为我们将从中删除字母，以便下次循环时再次检查。

该方法以`return true`结束，因为只有在起始单词中找到用户单词中的每个字母不超过一次时才会到达此行。如果找不到任何字母，或者使用的字母多于可能，则其中一条不符合会返回`false`，直到我们确定这个单词是好的。

**下面是`isReal()`方法**		

```
func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
    
}
```
>这里有一个新类，叫做`UITextChecker`。这是一个iOS类，旨在发现拼写错误，这使得它非常适合于了解给定单词是否正确。我们正在创建一个类的新实例，并将其放入`checker`常量中以供日后使用。

>这里也有一种新类型，叫做`NSRange`。这用于存储字符串范围，该范围是保存起始位置和长度的值。我们想要检查整个字符串，因此我们使用0作为起始位置，使用字符串的长度作为长度。

>接下来，我们调用`UITextChecker`实例的`rangeOfMisspelledWord(in :)`方法。这需要五个参数，但我们只关心前两个和最后一个：第一个参数是我们的字符串，`word`，第二个是我们要扫描的范围（整个字符串），最后一个是我们应该检查的语言，`en`表示英语。

>参数三和四在这里没有用，但为了完整起见：参数三选择文本检查器应该开始扫描的范围内的一个点，参数四让我们设置`UITextChecker`是否应该从范围的开始处开始如果从参数三开始检查没有拼写错误的情况下

>调用`rangeOfMisspelledWord（in :)`会返回另一个`NSRange`结构，它告诉我们找到拼写错误的位置。但我们关心的是是否发现任何拼写错误，如果没有发现任何错误，我们的`NSRange`会是NSNotFound。通常`location`会告诉你拼写错误开始的地方，但是NSNotFound告诉我们这个单词拼写正确 - 也就是说，它是一个有效的单词。
>

在我们继续之前，我想简单介绍一件小事。在`isPossible()`方法中，我们通过将单词视为数组来循环每个字母，但在这个新代码中，我们使用`word.utf16`代替。为什么？

答案是一个烦人的向后兼容性问题：Swift的字符串本身将国际字符存储为单个字符，例如字母“é”正好存储。但是，在Swift的字符串出现之前，UIKit是用Objective-C编写的，它使用了一个名为UTF-16的不同字符系统 - 16位Unicode转换格式的简称 - 其中重音和字母分别存储。

这是一个微妙的差异，通常它根本不是一个区别，但由于表情符号的兴起，它变得越来越成问题 - 那些在信息中经常使用的小图像。表情符号实际上只是幕后的特殊字符组合，它们使用Swift字符串和UTF-16字符串进行不同的测量：Swift字符串将它们视为1个字母的字符串，但UTF-16认为它们是2个字母的字符串。这意味着如果您使用UIKit方法计数，则存在错误计算字符串长度的风险。

我意识到这似乎是毫无意义的额外复杂性，所以让我试着给你一个简单的规则：当你使用`UIKit`，`SpriteKit`或任何其他Apple框架时，使用`utf16.count`进行字符计数。如果它只是你自己的代码 - 即循环遍历字符并单独处理每个代码 - 那么请使用`count`。
## Or else what?

我们的代码仍有一个问题需要解决，这是一个非常繁琐的问题。如果单词是可能的，原始的和真实的，我们将它添加到找到的单词列表，然后将其插入表视图。但如果这个词错误呢？或者，如果它可能但不是首次出现的？在这种情况下，我们拒绝这个词并且不说明原因，因此用户得不到任何反馈。

因此，我们项目的最后一部分是在用户进行无效移动时向用户提供反馈。这很乏味，因为它只是在`submit()`中的所有`if`语句中添加`else`语句，每次都配置要向用户显示的消息。

```
func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()
    let errorTitle: String
    let errorMessage: String
    
    
    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                return
            }else {
                errorTitle = "单词错误"
                errorMessage = "拼写的单词不是有效的单词"
            }
        }else {
            errorTitle = "单词已存在"
            errorMessage = "当前答案中已存在该单词"
        }
    }else {
        guard let title = title?.lowercased() else { return }
        errorTitle = "单词无效"
        errorMessage = "拼写的单词字母没有从\(title)中获取"
    }
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
    
}
```

