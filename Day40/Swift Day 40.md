# Swift Day 40
> 今天主要对项目9总结和复习,并完成三个挑战


## Wrap up 

我们简单的学习了GCD,但GCD并不简单,GCD自动处理线程创建和管理,自动平衡系统资源并考虑QoS(Quality of Service) 确保你的代码高效执行


## Review for Project 9:Grand Central Dispatch

[复习](https://www.hackingwithswift.com/review/hws/project-9-grand-central-dispatch)

## Challenge

1. 修改项目1,从后台加载NSSL图像列表,加载完成以后表视图调用 `reloadData()`
2. 修改项目8，以便在后台加载和解析游戏级别数据。完成后，请确保在主线程上更新UI
3. 修改项目7，以便您的过滤代码在后台进行。这个过滤代码是在项目的一个挑战中添加的