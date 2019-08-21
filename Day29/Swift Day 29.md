# Swift Day 29

>今天对项目五总结,复习,并完成三个挑战

## Wrap up
这个项目我们学习了tableView刷新数据和插入行,学习了`UIAlertViewController`添加textField.学习了String,闭包,`NSRange`等

## Review for project 5:Word Scramble

[复习](https://www.hackingwithswift.com/review/hws/project-5-word-scramble)

## Challenge

1. 用户输入的单词不能少于三个字母,并且输入的单词不能与原始八个字母的单词相同
2. 重构我们添加的`else`语句，以便它们调用一个名为`showErrorMessage()`的新方法。这应该接受错误消息和标题，并从那里完成所有`UIAlertController`工作。
3. 添加一个leftBarButtonItem,触发`startGame()`,用户点击时重新开始

**另外**一旦你完成了这三个，我们的游戏中就会出现一个非常微妙的错误，我希望你能尝试找到并修复它。

要触发错误，请在起始单词中查找三个字母的单词，然后使用大写字母输入。一旦它出现在表格中，尝试再次输入全部小写 - 您将看到它被输入。你能弄清楚导致这种情况的原因以及如何解决这个问题吗？