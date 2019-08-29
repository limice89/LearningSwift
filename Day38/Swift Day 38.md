# Swift Day 38
>今天主要复习总结项目8,完成三个挑战

## Wrap up
这次学习了代码构建视图,`addTarget()`，`enumerated()`，`joined()`，`replacementOccurrences()`等等。
## Review for Project8: 7 Swifty Words
[复习](https://www.hackingwithswift.com/review/hws/project-8-7-swifty-words)

## Challenge
1. 使用您在项目2中学习的技术在按钮视图周围绘制一条细灰线，使其从UI的其余部分中突出。
2. 如果用户输入了错误的猜测，请显示警告，告诉他们错误。您需要扩展`submitTapped()`方法，以便在`firstIndex（of :)`无法找到时显示警告
3. 如果玩家做出错误猜测答案，请尝试让游戏扣除积分。考虑一下如何进入下一个级别 - 我们不能再在玩家的分数上使用简单的取余数，因为他们可能已经失去了一些分数。